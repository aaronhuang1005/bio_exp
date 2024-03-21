#include <Wire.h>
#include "Adafruit_HTU21DF.h"
#define A_1A 8
#define A_1B 9


Adafruit_HTU21DF htu = Adafruit_HTU21DF();

void setup() {
  Serial.begin(9600);
  pinMode(A_1A,OUTPUT);
  pinMode(A_1B,OUTPUT);
  digitalWrite(A_1A,LOW);
  digitalWrite(A_1B,LOW);

  if (!htu.begin()) {
    Serial.println("Couldn't find sensor!");
    while (1);
  }
}

void loop() {
    float temp = htu.readTemperature();
    float rel_hum = htu.readHumidity();
    Serial.print("Temp: "); Serial.print(temp); Serial.print(" C");
    Serial.print("\t\t");
    Serial.print("Humidity: "); Serial.print(rel_hum); Serial.println(" \%");
    digitalWrite(A_1A,LOW);
    analogWrite(A_1B,255);
}
