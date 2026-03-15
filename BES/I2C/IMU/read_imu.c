// Code to read and dump the Acc and Gyro data received over I2C interface from IMU Sensor (MPU 9250)

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <time.h>
#include <math.h>
#include <string.h>

#define MPU9250_AG_ADDRESS 0x68 // MPU-9250 I2C address
#define MPU9250_M_ADDRESS 0x0c // MPU-9250 Mag I2C address

struct timespec ts[10];
int verbose=0, print_time_diffs=0;

#define CLIP(a,b,c) (((b)>(c))? (c):(((b)<(a))? (a):(b)))

int get_i2c_registers(int file,
		      unsigned char addr,
		      unsigned char first_reg,
		      unsigned char num_regs,
		      unsigned char *val) {
  unsigned char outbuf;
  struct i2c_rdwr_ioctl_data packets;
  struct i2c_msg messages[2];

  /*
   * In order to read a register, we first do a "dummy write" by writing
   * 0 bytes to the register we want to read from.  This is similar to
   * the packet in set_i2c_register, except it's 1 byte rather than 2.
   */
  outbuf = first_reg;
  messages[0].addr  = addr;
  messages[0].flags = 0;
  messages[0].len   = sizeof(outbuf);
  messages[0].buf   = &outbuf;

  /* The data will get returned in this structure */
  messages[1].addr  = addr;
  messages[1].flags = I2C_M_RD/* | I2C_M_NOSTART*/;
  messages[1].len   = num_regs;
  messages[1].buf   = val;

  /* Send the request to the kernel and get the result back */
  packets.msgs      = messages;
  packets.nmsgs     = 2;
  if(ioctl(file, I2C_RDWR, &packets) < 0) {
    perror("Unable to send data");
    return 1;
  }
  return 0;
}

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
  buffer[2] = 0x00; // Enable Accel and Gyro. Dis Acc: 0x38, Dis Gyr: 0x07
  if (write(fd, buffer, 3) != 3) {
    perror("Failed to write to the i2c bus for acc/gyro");
    return 1;
  }

  //  Accel Config 2 #29
  buffer[0] = 29;
  buffer[1] = 1; // 0000 0 001: 1 kHz output data rate
  if (write(fd, buffer, 2) != 2) {
    perror("Failed to write to the i2c bus for acc/gyro");
    return 1;
  }
  
  // Configure INT pin as output:
  // active high, push-pull, pulsed output, clear on any read,
  // disable FSYNC input
  // Enable I2C Bypass mode to access magnetometer
  // 0 0 0 1 0 0 1 0
  buffer[0] = 0x37; // Int Pin Config reg adx
  buffer[1] = 0x12; // Int Pin Config (and I2C bypass)
  // Interrupt enable
  // Interrupt on raw sensor data ready
  buffer[2] = 0x01;
  if (write(fd, buffer, 3) != 3) {
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
  float am, gm;
  
  am = sqrt(ax*ax + ay*ay + az*az);
  gm = sqrt(gx*gx + gy*gy + gz*gz);

  
  // Print the sensor data
  if (verbose) {
    printf("Accelerometer: X=%d, Y=%d, Z=%d\n", ax, ay, az);
    printf("Gyroscope: X=%d, Y=%d, Z=%d\n", gx, gy, gz);
  } else {
    /*    printf("TAG, %u, %d, %d, %d, %f, \t%d, %d, %d, %f\n",
	  ts[1].tv_nsec, ax, ay, az, am, gx, gy,gz, gm); */
    printf("TAG, %u, %d, %d, %d, %f, \t%d, %d, %d, %f\n",
	   ts[1].tv_nsec, ax, ay, az, am, gx, gy,gz, gm);
  }
  return 0;
}

#define BL (80)
#define SCALE 10
void plot(float x, float y, float z, float m){
  static int first=1;
  char buf[BL+2];
  int px, py, pz, pm;
      
  memset(buf, ' ', BL+1);
  buf[BL+1] = (char) 0;  

  px= CLIP(0, x/SCALE+(BL/2), BL);
  py= CLIP(0, y/SCALE+(BL/2), BL);
  pz= CLIP(0, z/SCALE+(BL/2), BL);
  pm= CLIP(0, m/(2*SCALE)+(BL/2), BL);

  buf[BL/2] = '.';
  buf[px] = 'x';
  buf[py] = 'y';
  buf[pz] = 'z';
  buf[pm] = '|';

  if (first) {
    buf[0] = '[';
    buf[BL/2] = '0';
    buf[BL] = ']';
    first = 0;
  }

  printf("%sX:%4.0f  Y:%4.0f  Z:%4.0f  M:%3.0f\n", buf, x, y, z, m);
}

int Mag_Read(int fd) {
  __u8 buffer[14]; // Buffer to store sensor data
  static int n=0;
  int samples=5, samples_left;
  float sx, sy, sz, sm;
  
  sx = sy = sz = sm = 0.0;

  for (samples_left = samples; samples_left; ) {
    clock_gettime(CLOCK_MONOTONIC, &ts[4]);
    if (ioctl(fd, I2C_SLAVE, MPU9250_M_ADDRESS) < 0) {
      perror("Failed to acquire bus access and/or talk to device");
      return 1;
    }
    clock_gettime(CLOCK_MONOTONIC, &ts[5]);

    if (n) {
      if (get_i2c_registers(fd, MPU9250_M_ADDRESS, 0x02, 8, buffer)) {
	perror("get_i2c_registers failed");
	return 1;
      }
    } else {
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
    }
    clock_gettime(CLOCK_MONOTONIC, &ts[7]);
    n = 1-n;
  
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

      sx += hx;
      sy += hy;
      sz += hz;
      samples_left--;
    }
  }
  sx /= samples;
  sy /= samples;
  sz /= samples;
  sm = sqrt(sx*sx + sy*sy + sz*sz);
  plot(sx, sy, sz, sm);
  
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
    //    if (Acc_Gyro_Read(file)) return 1;
    if (Mag_Read(file)) return 1;

    if (print_time_diffs)
      print_times();
    usleep(10000); // Wait before reading again
  }

  close(file);
  return 0;
}
