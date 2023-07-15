#include <Servo.h>

// IR Sensor and Servo Declarations
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
















  // Initialize the Serial communication for debugging (optional)
  Serial.begin(9600);
}

void loop() {
  // Read the distance from the ultrasonic sensor
  int distance = sonar.ping_cm();

  // Check if the distance reading is valid (non-zero)
  if (distance > 0) {
    // Calculate the water level from the bottom of the tank
    int waterLevel = MAX_DISTANCE - distance;
    Serial.println(waterLevel);

    // Read flame sensor value
    int flameValue = digitalRead(flamePin);

    // Read gas sensor value
    int gasValue = analogRead(mq2Pin);

    // Clear the LCD display
    lcd.clear();

    // Print the water level on the LCD display
    lcd.setCursor(0, 0);
    lcd.print("Water Level:");
    lcd.setCursor(0, 1);
    lcd.print(waterLevel);
    lcd.print(" cm");

    // Check if the water level is below the low level threshold
    if (waterLevel < LOW_LEVEL_THRESHOLD) {
      // Turn on the water pump
      digitalWrite(PUMP_PIN, HIGH);

      // Print the pump status on the LCD display
      lcd.setCursor(0, 1);
      lcd.print("Pump: ON (Low Level)");
    }
    // Check if the water level is above the high level threshold
    else if (waterLevel > HIGH_LEVEL_THRESHOLD) {
      // Turn off the water pump
      digitalWrite(PUMP_PIN, LOW);

      // Print the pump status on the LCD display
      lcd.setCursor(0, 1);
      lcd.print("Pump: OFF (High Level)");
    }
    else {
      // If the water level is within the acceptable range, turn off the pump
      digitalWrite(PUMP_PIN, LOW);

      // Print the system status on the LCD display
      lcd.setCursor(0, 1);
      lcd.print("System: Idle (Acceptable)");
    }

    // Check for flame or gas detection
    if (flameValue == LOW || gasValue > 200) {
      // Display warning message
      lcd.clear();
      lcd.setCursor(0, 0);
      lcd.print("Warning: Flame or Gas");
      lcd.setCursor(0, 1);
      lcd.print("Detected!");

      Serial.println("Warning: Flame or Gas detected!");

      // Generate a sound with the buzzer
//      tone(buzzerPin, 1000);
      digitalWrite(buzzerPin, HIGH);
      delay(4000); // Sound duration
//      noTone(buzzerPin);
      digitalWrite(buzzerPin, LOW);
//      delay(500); // Delay between detections
    }
  }

  delay(500); // Adjust the delay time as needed
}
