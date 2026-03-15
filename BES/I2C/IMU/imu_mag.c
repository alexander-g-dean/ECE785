// Source - https://stackoverflow.com/a
// Posted by Connor Olsen
// Retrieved 2026-01-07, License - CC BY-SA 3.0

#include <stdio.h>
#include <linux/i2c-dev.h>

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>

#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
#define IMU_ADDR 0x68 
#define IMU_WHO_AM_I 0x75


int file;

void i2c_init();
void write_register(uint8_t register_address, uint8_t value);
uint8_t read_register(uint8_t register_address);

void i2c_init(int address){
  int adapter_nr = 1;
  char filename[20];

  snprintf(filename, 19, "/dev/i2c-%d", adapter_nr);
  file = open(filename, O_RDWR);
  if(file < 0)
    printf("Error: Failed to open file %s\n", filename);
  int success= (ioctl(file, I2C_SLAVE, address));
  if(file < 0) {
    printf("Error: IMU I2C Failed to Open\n");
    //return -1;
  }
}
void write_register(uint8_t register_address, uint8_t value){
    uint8_t data[]={register_address,value};
    write(file, data,ARRAY_SIZE(data));
}
uint8_t read_register(uint8_t register_address){
  uint8_t value;
  if(write(file, &register_address, sizeof(register_address)) !=1)
    {
      printf("%d\n",write(file, &register_address, sizeof(register_address)));
      printf("Failed to send data\n");
    }
  read(file, &value, sizeof(value));
  return value;
}

int main(){
  i2c_init(IMU_ADDR);

  printf("\nNow testing the 'Who am I?' IMU register. Output should be 0x71\n");
   printf("Register 0x75: 0x%02X \n", read_register(IMU_WHO_AM_I));

  write_register(0x37, 0x22);
  i2c_init(0x0C);
  printf("\nNow testing the 'Who am I?' Magnetometer register. Output should be 0x48\n");

  printf("Register 0x00: 0x%02x\n", read_register(0x00));

  return 0;
}
