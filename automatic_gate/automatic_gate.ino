#include <Servo.h>

// IR Sensor 
Servo servo1;
Servo servo2;
int sensor1_pin = 4;
int sensor2_pin = 5;
int servo1_pin = 9;
int servo2_pin = 10;
int val1, val2;

// Ultrasonic Sensor and Servo Declarations
Servo servo;
int trigPin = 6;
int echoPin = 7;
int servoPin = 8;

// defines variables
long duration;
int distance;

void setup() {
  // IR Sensor and Servo Setup
  pinMode(sensor1_pin, INPUT);
  pinMode(sensor2_pin, INPUT);
  servo1.attach(servo1_pin);
  servo2.attach(servo2_pin);
  
  // Ultrasonic Sensor and Servo Setup
  servo.attach(8);
  servo.write(0);
  delay(2000);
  
  // Sets the trigPin as an Output
  pinMode(trigPin, OUTPUT);
  // Sets the echoPin as an Input 
  pinMode(echoPin, INPUT);
  // Starts the serial communication 
  // Starts the serial communication 
  Serial.begin(9600);
}



void loop() {
  // IR Sensor and Servo Loop
  val1 = digitalRead(sensor1_pin);
  val2 = digitalRead(sensor2_pin);
  
  if (val1 == LOW) {
    Serial.println("IR Sensor 1 activated");
    servo1.write(0);  // Rotate servo1 to 0 degrees (or any desired position)
    delay(2000);
    servo1.write(90);// Reset servo1 to 90 degrees (center position)
    Serial.print("Servo1 activated");
    delay(2000);
  }
  
  if (val2 == LOW) {
    Serial.println("IR Sensor 2 activated");
    servo2.write(0); // Rotate servo2 to 180 degrees (or any desired position)
    delay(2000);
    servo2.write(90); // Reset servo2 to 90 degrees (center position)
    Serial.println("Servo2 activated");
    delay(2000);
  }

  // Dustbin code
    // Clears the trigPin
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, Hlkjh1IGH);
  // Calculating the distance
  distance= duration*0.034/2;
  // Prints the distance on the Serial Monitor
  Serial.print("Distance: ");
  Serial.println(distance);
  if ( distance <= 10   ) // Change Distance according to Ultrasonic Sensor Placement
   {
  
  servo.write(0);
  delay(3000);
   } 
  else 
  {
  servo.write(90);
  
   }

}

















  
  
