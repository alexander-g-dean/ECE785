// Code to read and dump the Acc and Gyro data received over I2C interface from IMU Sensor (MPU 9250)

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <time.h>

#define MPU9250_AG_ADDRESS 0x68 // MPU-9250 I2C address

#define MPU9250_M_ADDRESS 0x0c // MPU-9250 Mag I2C address
#define USE_MAG_CODE 0

struct timespec ts[10];

int Acc_Gyro_Mag_Init(int fd){
  __u8 buffer[14]; // Buffer to store sensor data

  // Set device address: Acc/Gyro
  if (ioctl(fd, I2C_SLAVE, MPU9250_AG_ADDRESS) < 0) {
    perror("Failed to acquire bus access and/or talk to device");
    return 1;
  }
  // Configure MPU-9250 to enable accelerometer and gyroscope
  buffer[0] = 0x6B; // Power Management 1
  buffer[1] = 0x00; // Wake up and disable sleep mode
  if (write(fd, buffer, 2) != 2) {
    perror("Failed to write to the i2c bus for acc/gyro");
    return 1;
  }
  // Enable I2C Bypass mode to access magnetometer
  buffer[0] = 0x37; // Int Pin Config (and I2C bypass)
  buffer[1] = 0x12; // Enable INT push-pull output, pulse high for 50 us,
                    // enable  I2C Bypass mode
  if (write(fd, buffer, 2) != 2) {
    perror("Failed to write to the i2c bus for acc/gyro");
    return 1;
  }
  // Set device address: Mag
  if (ioctl(fd, I2C_SLAVE, MPU9250_M_ADDRESS) < 0) {
    perror("Failed to acquire bus access and/or talk to device");
    return 1;
  }
  // Configure MPU-9250 to enable magnetometer
  buffer[0] = 0x0A; // Control 1
  buffer[1] = 0x16; // Continuous conversions 100 Hz, 16 bits
  if (write(fd, buffer, 2) != 2) {
    perror("Failed to write to the i2c bus for acc/gyro");
    return 1;
  }
  return 0;
}  

int Acc_Gyro_Read(int fd) {
  __u8 buffer[14]; // Buffer to store sensor data

  clock_gettime(CLOCK_MONOTONIC, &ts[0]);
  if (ioctl(fd, I2C_SLAVE, MPU9250_AG_ADDRESS) < 0) {
    perror("Failed to acquire bus access and/or talk to device");
    return 1;
  }
  clock_gettime(CLOCK_MONOTONIC, &ts[1]);
  // Read accelerometer and gyroscope data
  buffer[0] = 0x3B; // Starting register of accelerometer data
  if (write(fd, buffer, 1) != 1) {
    perror("Failed to write to the i2c bus");
    return 1;
  }
  clock_gettime(CLOCK_MONOTONIC, &ts[2]);

  if (read(fd, buffer, 14) != 14) {
    perror("Failed to read from the i2c bus");
    return 1;
  }
  clock_gettime(CLOCK_MONOTONIC, &ts[3]);

  // Combine high and low bytes for each sensor
  int16_t ax = (buffer[0] << 8) | buffer[1];
  int16_t ay = (buffer[2] << 8) | buffer[3];
  int16_t az = (buffer[4] << 8) | buffer[5];
  int16_t gx = (buffer[8] << 8) | buffer[9];
  int16_t gy = (buffer[10] << 8) | buffer[11];
  int16_t gz = (buffer[12] << 8) | buffer[13];

  // Print the sensor data
  printf("Accelerometer: X=%d, Y=%d, Z=%d\n", ax, ay, az);
  printf("Gyroscope: X=%d, Y=%d, Z=%d\n", gx, gy, gz);
  return 0;
}
int Mag_Read(int fd) {
  __u8 buffer[14]; // Buffer to store sensor data

  clock_gettime(CLOCK_MONOTONIC, &ts[4]);
  if (ioctl(fd, I2C_SLAVE, MPU9250_M_ADDRESS) < 0) {
    perror("Failed to acquire bus access and/or talk to device");
    return 1;
  }
  clock_gettime(CLOCK_MONOTONIC, &ts[5]);
  // Read mag data and status
  buffer[0] = 0x02; // Starting register 
  if (write(fd, buffer, 1) != 1) {
    perror("Failed to write to the i2c bus");
    return 1;
  }
  clock_gettime(CLOCK_MONOTONIC, &ts[6]);
  if (read(fd, buffer, 8) != 8) {
    perror("Failed to read from the i2c bus");
    return 1;
  }
  clock_gettime(CLOCK_MONOTONIC, &ts[7]);

  // Combine high and low bytes for each sensor
  int st1 = buffer[0];
  int st2 = buffer[7];

  int dor = (st1 & 2)>>1;
  int drdy = st1 & 1;
  int hofl = (st2 & 0x08)? 1:0;

  if (drdy) {
    int16_t hx = (buffer[2] << 8) | buffer[1];
    int16_t hy = (buffer[4] << 8) | buffer[3];
    int16_t hz = (buffer[6] << 8) | buffer[5];

    // Print the sensor data
    printf("Magnetometer: Rdy %d Overrun %d: X=%d, Y=%d, Z=%d\n", drdy, dor,
	   hx, hy, hz);
  } else
    printf("Magnetometer: Not Rdy\n");
  return 0;
}

void print_times(void) {
  unsigned diff;

  for (int i=3; i<7; i++) {
    diff = ts[i+1].tv_nsec - ts[i].tv_nsec;
    if (diff < 0)
      diff += 1e9;
    printf("%d: %.3f, ", i+1, diff/1000.0);
  }
  printf("us\n");
}

int main() {
  int file;
  char *filename = "/dev/i2c-1"; // I2C device file for Raspberry Pi

  if ((file = open(filename, O_RDWR)) < 0) {
    perror("Failed to open the i2c bus");
    return 1;
  }

  if (Acc_Gyro_Mag_Init(file)) {
    perror("AGM Init failed");
    return 1;
  }
      
  while (1) {
    if (Acc_Gyro_Read(file)) return 1;
    if (Mag_Read(file)) return 1;
    print_times();
    usleep(10000); // Wait before reading again
  }

  close(file);
  return 0;
}
