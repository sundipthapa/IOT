#include <Servo.h>

Servo servo1;
Servo servo2;

int sensor1_pin = 4;
int sensor2_pin = 5;
int servo1_pin = 9;
int servo2_pin = 10;
int val1, val2;

void setup() {
  pinMode(sensor1_pin, INPUT);
  pinMode(sensor2_pin, INPUT);
  servo1.attach(servo1_pin);
  servo2.attach(servo2_pin);
  Serial.begin(9600);
}

void loop() {
  val1 = digitalRead(sensor1_pin);
  val2 = digitalRead(sensor2_pin);
  
  // For IR Sensor 1 and Servo 1
  if (val1 == LOW) {
    Serial.println("IR Sensor 1 activated");
    servo1.write(0);  // Rotate servo1 to 0 degrees (or any desired position)
    delay(2000);      // Delay to allow the servo to reach the position
    servo1.write(90); // Reset servo1 to 90 degrees (center position)
    delay(2000);      // Delay to allow the servo to reach the center position
  }

  // For IR Sensor 2 and Servo 2
  if (val2 == LOW) {
    Serial.println("IR Sensor 2 activated");
    servo2.write(180); // Rotate servo2 to 180 degrees (or any desired position)
    delay(2000);       // Delay to allow the servo to reach the position
    servo2.write(90);  // Reset servo2 to 90 degrees (center position)
    delay(2000);       // Delay to allow the servo to reach the center position
  }
}
