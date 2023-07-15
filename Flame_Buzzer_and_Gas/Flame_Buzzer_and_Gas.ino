#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <NewPing.h>

// Define the ultrasonic sensor pins
#define TRIGGER_PIN 2
#define ECHO_PIN 3
#define MAX_DISTANCE 9

// Define the water pump motor pin
#define PUMP_PIN 4

// Define the water level thresholds (in centimeters)
#define LOW_LEVEL_THRESHOLD 2 // Adjust this value based on the distance from the bottom of the tank
#define HIGH_LEVEL_THRESHOLD 6 // Adjust this value based on the distance from the bottom of the tank

// Pin connections for fire and gas detection
const int flamePin = 5;         // Flame sensor output pin
const int mq2Pin = A0;          // MQ2 gas sensor analog pin
const int buzzerPin = 6;        // Buzzer control pin

// LCD configuration
LiquidCrystal_I2C lcd(0x27, 16, 2); // I2C address may vary, adjust as needed

// Create a NewPing object for the ultrasonic sensor
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

void setup() {
  // Initialize the LCD display
  lcd.begin();
  lcd.backlight();
  lcd.print("Home Automation");

  // Set the pump pin and buzzer pin as OUTPUT
  pinMode(PUMP_PIN, OUTPUT);
  pinMode(buzzerPin, OUTPUT);

  // Turn off the pump and buzzer initially
  digitalWrite(PUMP_PIN, LOW);
  digitalWrite(buzzerPin, LOW);
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
