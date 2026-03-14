/**
 * @file   button2.c
 * @author Derek Molloy
 * @date   8 November 2015
 * @brief  A kernel module for controlling a button (or any signal) that is 
 * connected to a GPIO. It has full support for interrupts and for sysfs 
 * entries so that an interface can be created to the button or the button 
 * can be configured from Linux userspace. The sysfs entry appears at 
 * /sys/erpi/gpio27
 * @see http://www.derekmolloy.ie/
*/
// Modified by Alex Dean for gpiod_interface

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/gpio.h>       // Required for the GPIO functions
#include <linux/interrupt.h>  // Required for the IRQ code
#include <linux/kobject.h>    // Using kobjects for the sysfs bindings
// #include <linux/time.h>       // Using clock to measure button press times
#include <linux/ktime.h>

#define  DEBOUNCE_TIME 200    // The default bounce time -- 200ms
#define IO_OFFSET 512

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Derek Molloy");
MODULE_DESCRIPTION("A simple Linux GPIO Button2 LKM for the RPi");
MODULE_VERSION("0.1");

static bool isRising = 1;                 // rising edge default IRQ property
module_param(isRising, bool, S_IRUGO);    // S_IRUGO read/not changed
MODULE_PARM_DESC(isRising, " Rising edge = 1 (default), Falling edge = 0");

static unsigned int gpioButton = 27;      // default GPIO is 27
module_param(gpioButton, uint, S_IRUGO);  // S_IRUGO can be read/not changed
MODULE_PARM_DESC(gpioButton, " GPIO Button2 number (default=27)");

static unsigned int gpioLED = 17;         // default GPIO is 17
module_param(gpioLED, uint, S_IRUGO);     // S_IRUGO can be read/not changed
MODULE_PARM_DESC(gpioLED, " GPIO LED number (default=17)");

struct gpio_desc *descLED, *descButton;

static char   gpioName[8] = "gpioXXX";    // null terminated default string
static int    irqNumber;                  // used to share the IRQ number
static int    numberPresses = 0;          // store number of button presses
static bool   ledOn = 0;                  // used to invert the LED state
static bool   isDebounce = 1;             // use to store debounce state
// static struct ktime_t ts_last, ts_current, ts_diff;  // nano precision
static struct timespec64 ts_last, ts_current, ts_diff;  // nano precision

// Function prototype for the custom IRQ handler function
static irqreturn_t  erpi_gpio_irq_handler(int irq, void *dev_id);

/** @brief A callback function to output the numberPresses variable
 *  @param kobj a kernel object device that appears in the sysfs filesystem
 *  @param attr the pointer to the kobj_attribute struct
 *  @param buf the buffer to which to write the number of presses
 *  @return return the total number of characters written to the buffer
 */
static ssize_t numberPresses_show(struct kobject *kobj, 
                                  struct kobj_attribute *attr, char *buf) {
   return sprintf(buf, "%d\n", numberPresses);
}

/** @brief A callback function to read in the numberPresses variable */
static ssize_t numberPresses_store(struct kobject *kobj, struct 
                    kobj_attribute *attr, const char *buf, size_t count) {
   sscanf(buf, "%du", &numberPresses);
   return count;
}

/** @brief Displays if the LED is on or off */
static ssize_t ledOn_show(struct kobject *kobj, struct kobj_attribute *attr, 
                          char *buf) {
   return sprintf(buf, "%d\n", ledOn);
}

/** @brief Displays the last time the button was pressed - manually output*/
static ssize_t lastTime_show(struct kobject *kobj, 
                             struct kobj_attribute *attr, char *buf){
   return sprintf(buf, "%.2llu:%.2llu:%.2llu:%.9lu \n", (ts_last.tv_sec/3600)%24,
          (ts_last.tv_sec/60) % 60, ts_last.tv_sec % 60, ts_last.tv_nsec );
}

/** @brief Display the time diff in the form secs.nanosecs to 9 places */
static ssize_t diffTime_show(struct kobject *kobj, 
                             struct kobj_attribute *attr, char *buf){
   return sprintf(buf, "%llu.%.9lu\n", ts_diff.tv_sec, ts_diff.tv_nsec);
}

/** @brief Displays if button debouncing is on or off */
static ssize_t isDebounce_show(struct kobject *kobj, 
                               struct kobj_attribute *attr, char *buf){
   return sprintf(buf, "%d\n", isDebounce);
}

/** @brief Stores and sets the debounce state */
static ssize_t isDebounce_store(struct kobject *kobj, struct kobj_attribute 
                                *attr, const char *buf, size_t count){
   unsigned int temp;
   sscanf(buf, "%du", &temp);       // use temp var for correct int->bool
   gpiod_set_debounce(descButton,0);
   isDebounce = temp;
   if(isDebounce) { gpiod_set_debounce(descButton, DEBOUNCE_TIME);
      printk(KERN_INFO "ERPi Button2: Debounce on\n");
   }
   else { gpiod_set_debounce(descButton, 0);  // set the debounce time to 0
      printk(KERN_INFO "ERPi Button2: Debounce off\n");
   }
   return count;
}

/**  Use these helper macros to define the name and access levels of the 
 * kobj_attributes. The kobj_attribute has an attribute attr (name and mode), 
 * show and store function pointers. The count variable is associated with 
 * the numberPresses variable and it is to be exposed with mode 0664 using 
 * the numberPresses_show and numberPresses_store functions above
 */
static struct kobj_attribute count_attr = __ATTR(numberPresses, 0664, numberPresses_show, numberPresses_store);
static struct kobj_attribute debounce_attr = __ATTR(isDebounce, 0664, isDebounce_show, isDebounce_store);

/**  The __ATTR_RO macro defines a read-only attribute. There is no need to
 * identify that the function is called _show, but it must be present.
 * __ATTR_WO can be  used for a write-only attribute but only Linux 3.11.x+
*/
static struct kobj_attribute ledon_attr = __ATTR_RO(ledOn);
static struct kobj_attribute time_attr  = __ATTR_RO(lastTime);
static struct kobj_attribute diff_attr  = __ATTR_RO(diffTime);

/**  The erpi_attrs[] is an array of attributes that is used to create the 
 * attribute group below. The attr property of the kobj_attribute is used 
 * to extract the attribute struct
 */
static struct attribute *erpi_attrs[] = {
      &count_attr.attr,        // the number of button presses
      &ledon_attr.attr,        // is the LED on or off?
      &time_attr.attr,         // button press time in HH:MM:SS:NNNNNNNNN
      &diff_attr.attr,         // time difference between last two presses
      &debounce_attr.attr,     // is debounce state true or false
      NULL,
};

/**  The attribute group uses the attribute array and a name, which is 
 * exposed on sysfs -- in this case it is gpio27, which is automatically 
 * defined in the erpi_button_init() function below using the custom kernel 
 * parameter that can be passed when the module is loaded.
 */
static struct attribute_group attr_group = {
      .name  = gpioName,       // the name generated in erpi_button_init()
      .attrs = erpi_attrs,     // the attributes array defined just above
};

static struct kobject *erpi_kobj;

/** @brief The LKM initialization function */
static int __init erpi_button_init(void){
  int status = 0;
  unsigned long IRQflags = IRQF_TRIGGER_RISING;
  printk(KERN_INFO "ERPi Button2: Initializing the button LKM\n");
  sprintf(gpioName, "gpio%d", gpioButton);   // create /sys/erpi/gpio27

  // create the kobject sysfs entry at /sys/erpi
  erpi_kobj = kobject_create_and_add("erpi", kernel_kobj->parent);
  if(!erpi_kobj){
    printk(KERN_ALERT "ERPi Button2: failed to create kobject mapping\n");
    return -ENOMEM;
  }
  // add the attributes to /sys/erpi/ e.g., /sys/erpi/gpio27/numberPresses
  status = sysfs_create_group(erpi_kobj, &attr_group);
  if(status) {
    printk(KERN_ALERT "ERPi Button2: failed to create sysfs group\n");
    kobject_put(erpi_kobj);               // clean up remove entry
    return status;
  }
  // getnstimeofday(&ts_last);                // set last time to current time
  ktime_get_ts64(&ts_last);                // set last time to current time
  ts_diff = timespec64_sub(ts_last, ts_last);  // set the initial time diff=0

  // set up the LED. It is a GPIO in output mode and will be on by default
  ledOn = true;
  // New
  descLED = gpio_to_desc(IO_OFFSET + gpioLED);
  if (!descLED) return -ENODEV;
  status = gpiod_direction_output(descLED, 1);
  if (status) return status;

  descButton = gpio_to_desc(IO_OFFSET + gpioButton);
  if (!descButton) return -ENODEV;
  status = gpiod_direction_input(descButton);
  if (status) return status;
	
  printk(KERN_INFO "ERPi Button2: button state: %d\n", 
	 gpiod_get_value(descButton));

  irqNumber = gpiod_to_irq(descButton);
  if (irqNumber < 0) return irqNumber;
	
  printk(KERN_INFO "ERPi Button2: button mapped to IRQ: %d\n", irqNumber);
  if(!isRising){                           // if kernel param isRising=0
    IRQflags = IRQF_TRIGGER_FALLING;      // set on falling edge
  }
  status = request_irq(irqNumber,         // interrupt number requested
		       erpi_gpio_irq_handler, // handler function
		       IRQflags,              // use custom kernel param
		       "erpi_button2_handler",  // used in /proc/interrupts
		       NULL);                // *dev_id for shared interrupt lines
  printk(KERN_INFO "ERPi Button2: IRQ request result is: %d\n", status);
  return status;
}

static void __exit erpi_button_exit(void){
  printk(KERN_INFO "ERPi Button2: The button was pressed %d times\n", 
	 numberPresses);
  kobject_put(erpi_kobj);          // clean up, remove kobject sysfs entry

  gpiod_set_value(descLED, 0);      // turn the LED off, device was unloaded
  gpiod_put(descLED);
  gpiod_put(descButton);
  free_irq(irqNumber, NULL);       // free the IRQ number, no *dev_id required in this case
   
  printk(KERN_INFO "ERPi Button2: Goodbye from the ERPi Button2 LKM!\n");
}

/** @brief The GPIO IRQ Handler function
 *  This function is a custom interrupt handler that is attached to the GPIO 
 * above. The same interrupt handler cannot be invoked concurrently as the 
 * interrupt line is masked out until the function is complete. This function 
 * is static as it should not be invoked directly from outside of this file.
 *  @param irq    the IRQ number that is associated with the GPIO -- useful for logging.
 *  @param dev_id the *dev_id that is provided -- can be used to identify which device caused the interrupt
 *  Not used in this example as NULL is passed.
 *  @param regs   h/w specific register values -- only really ever used for debugging.
 *  return returns IRQ_HANDLED if successful -- should return IRQ_NONE otherwise.
 */
static irqreturn_t erpi_gpio_irq_handler(int irq, void *dev_id){
   ledOn = !ledOn;                   // invert LED on each button press
   gpiod_set_value(descLED, ledOn);   // set the physical LED accordingly
   ktime_get_ts64(&ts_current);      // get the current time as ts_current
   ts_diff = timespec64_sub(ts_current, ts_last);   // determine the time diff
   ts_last = ts_current;             // store current time as ts_last
   printk(KERN_INFO "ERPi Button2: The button state is currently: %d\n", 
                   gpiod_get_value(descButton));
   numberPresses++;                  // count number of presses
   return IRQ_HANDLED;  // announce IRQ was handled correctly
}

// This next calls are  mandatory -- they identify the initialization function
// and the cleanup function (as above).
module_init(erpi_button_init);
module_exit(erpi_button_exit);
