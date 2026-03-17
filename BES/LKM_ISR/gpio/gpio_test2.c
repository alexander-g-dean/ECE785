/*
 * @file   gpio_test2.c
 * @author Derek Molloy
 * @date   8 November 2015
 * @brief  A kernel module for controlling a GPIO LED/button pair. The
 * device mounts an LED and pushbutton at gpio17
 * and gpio27 respectively. */

// Modified by Alex Dean for gpiod_ interface

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/gpio/consumer.h>
#include <linux/interrupt.h>            // for the IRQ code

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Derek Molloy");
MODULE_DESCRIPTION("A Button/LED test driver for the RPi");
MODULE_VERSION("0.1");

#define IO_OFFSET 512

static unsigned int gpioLED = 17;       // pin 11 (GPIO17)
static unsigned int gpioButton = 27;    // pin 13 (GPIO27)
static unsigned int irqNumber;          // share IRQ num within file
static unsigned int numberPresses = 0;  // store number of presses
static bool	    ledOn = 0;          // used to invert state of LED

struct gpio_desc *descLED, *descButton;

// prototype for the custom IRQ handler function, function below
static irqreturn_t erpi_gpio_irq_handler(int irq, void *dev_id);
				   

/** @brief The LKM initialization function */
static int __init erpi_gpio_init(void){
  int status;
   
  printk(KERN_INFO "GPIO_TEST2: Initializing the GPIO_TEST2 LKM\n");

  descLED = gpio_to_desc(IO_OFFSET + gpioLED);
  if (!descLED) return -ENODEV;
  status = gpiod_direction_output(descLED, 0);
  if (status) return status;

  descButton = gpio_to_desc(IO_OFFSET + gpioButton);
  if (!descButton) return -ENODEV;
  status = gpiod_direction_input(descButton);
  if (status) return status;

  irqNumber = gpiod_to_irq(descButton);
  if (irqNumber < 0) return irqNumber;
  status = request_irq(irqNumber,         // interrupt number requested
		       erpi_gpio_irq_handler, // handler function
		       IRQF_TRIGGER_RISING,  // on rising edge (press, not release)
		       "erpi_gpio_handler",  // used in /proc/interrupts
		       NULL);                // *dev_id for shared interrupt lines
  printk(KERN_INFO "GPIO_TEST2: IRQ request result is: %d\n", status);
  return status;
}

/** @brief The LKM cleanup function  */
static void __exit erpi_gpio_exit(void){
  printk(KERN_INFO "GPIO_TEST2: button value is currently: %d\n",
	 gpiod_get_value(descButton));
  printk(KERN_INFO "GPIO_TEST2: pressed %d times\n", numberPresses);
   
  gpiod_set_value(descLED, 0);    // turn the LED off
  gpiod_put(descLED);
  gpiod_put(descButton);

  free_irq(irqNumber, NULL);     // free the IRQ number, no *dev_id

  printk(KERN_INFO "GPIO_TEST2: Goodbye from the LKM!\n");
}

/** @brief The GPIO IRQ Handler function
 * A custom interrupt handler that is attached to the GPIO. The same
 * interrupt handler cannot be invoked concurrently as the line is
 * masked out until the function is complete. This function is static
 * as it should not be invoked directly from outside of this file.
 * @param irq    the IRQ number associated with the GPIO
 * @param dev_id the *dev_id that is provided - used to identify
 * which device caused the interrupt. Not used here.
 * @param regs   h/w specific register values -used for debugging.
 * return returns IRQ_HANDLED if successful - return IRQ_NONE otherwise.
 */
//static irq_handler_t erpi_gpio_irq_handler(unsigned int irq,
//                        void *dev_id, struct pt_regs *regs){
static irqreturn_t erpi_gpio_irq_handler(int irq, void *dev_id){
  ledOn = !ledOn;                     // invert the LED state
  gpiod_set_value(descLED, ledOn);    // set LED accordingly
  printk(KERN_INFO "GPIO_TEST2: Interrupt! (button is %d)\n",
	 gpiod_get_value(descButton));
  numberPresses++;                    // global counter

  return IRQ_HANDLED; // announce IRQ handled
}

module_init(erpi_gpio_init);
module_exit(erpi_gpio_exit);
