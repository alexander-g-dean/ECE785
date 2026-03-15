// i2c_base.c
// Version 1.0
// 2/6/2026

// Starter code to demonstrate I2C communications
// Open and close linux i2c bus controller device /dev/i2c-1
// Select I2C bus device with ioctl(I2C_SLAVE)
// Read and write registers with read(), write()
// Selecte I2C bus device and perform atomic read/write registers with ioctl(I2C_RDWR)

// Initializes MPU-9250 for basic accelerometer & gyroscope activity
// Does not enable I2C bus bypass or magnetometer

// Compile with gcc i2c_base.c -O -lrt -lm -o i2c_base 

#include <unistd.h> // POSIX API 
#include <stdio.h>  // printf, perror
#include <stdint.h> // for uint8_t
#include <fcntl.h> // open, close, O_RDWR, read, write
#include <sys/ioctl.h> // ioctl
#include <linux/i2c.h> // struct i2c_msg, I2C_M_RD
#include <linux/i2c-dev.h> // struct i2c_rdwr_ioctl_data, I2C_SLAVE, I2C_RDWR

#define DEV_ADX 0x68 // MPU-9250 I2C device address
// MPU-9250 register addresses
#define PWRMGT1_REG_ADX 0x6B
#define ACC_REG_ADX 0x3B

#define ACC_GYRO_DATA_LEN 14
#define BUFSIZE 16

int main() {
  int fd;
  uint8_t out_buffer[BUFSIZE], in_buffer[BUFSIZE]; // Buffers to store data
  char *filename = "/dev/i2c-1"; // I2C controller device file for Raspberry Pi

  // Open I2C bus controller device 
  if ((fd = open(filename, O_RDWR)) < 0) {
    perror("Failed to open the i2c bus");
    return 1;
  }
  
  // ** Write 1 data byte to register
  // 1a. Set device address
  if (ioctl(fd, I2C_SLAVE, DEV_ADX) < 0) {
    perror("Failed to set device address ");
    return 1;
  }
  // 1b. Write data to register 0x6B 
  out_buffer[0] = PWRMGT1_REG_ADX; // Register Address for Power Management 1
  out_buffer[1] = 0x00; // Data: Wake up and disable sleep mode
  if (write(fd, out_buffer, 2) != 2) {
    perror("Failed to write to the i2c bus");
    return 1;
  }
  
  // ** Read 8 data bytes from register 0x3B with write & read
  // Device address retained from previous ioctl(I2C_RDWR)
  // 2a. Specify starting register address for reading
  out_buffer[0] = ACC_REG_ADX; // Starting register of acc data
  if (write(fd, out_buffer, 1) != 1) {
    perror("Failed to write to the i2c bus");
    return 1;
  }
  // 2b. Read data 
  if (read(fd, in_buffer, ACC_GYRO_DATA_LEN) != ACC_GYRO_DATA_LEN) {
    perror("Failed to read from the i2c bus");
    return 1;
  }

  // 2.c Print out data
  printf("Data from 0x%x via write(), read()\n", ACC_REG_ADX);
  for (int i=0; i<BUFSIZE; i++)
    printf("%2d: 0x%02x %c", i, in_buffer[i], ((i+1)%4)? ' ':'\n');
  printf("\n");

  // ** Read 8 data bytes from ACC_REG_ADX with ioctl(I2C_RDWR)
  // data structures for ioctl rdwr
  struct i2c_rdwr_ioctl_data packets;
  struct i2c_msg messages[2];

  // 3a. Initialize message start data:
  // device address, buffer with register address, implicit write (flags=0)
  out_buffer[0] = ACC_REG_ADX;
  messages[0].buf   = out_buffer;
  messages[0].len   = 1;
  messages[0].addr  = DEV_ADX;
  messages[0].flags = 0;

  // 3b. Initialize message body data:
  // device address, read, destination buffer (and length) for data
  /* The data will get returned in this structure */
  messages[1].addr  = DEV_ADX;
  messages[1].flags = I2C_M_RD;
  messages[1].len   = ACC_GYRO_DATA_LEN;
  messages[1].buf   = in_buffer;

  // 3c. Make packets structure describe message parts
  packets.msgs      = messages;
  packets.nmsgs     = 2;

  /* 4. Send the request to kernel, get result back */
  if(ioctl(fd, I2C_RDWR, &packets) < 0) {
    perror("Unable to send/receive data with ioctl(I2C_RDWR");
    return 1;
  }

  // Print out data
  printf("Data from 0x%x via ioctl(I2C_RDWR)\n", ACC_REG_ADX);
  for (int i=0; i<BUFSIZE; i++)
    printf("%2d: 0x%02x %c", i, in_buffer[i], ((i+1)%4)? ' ':'\n');
  printf("\n");

  // Clean up
  close(fd);
  return 0;
}
