#include <Wire.h>
#include "Adafruit_HTU21DF.h"

Adafruit_HTU21DF htu = Adafruit_HTU21DF();

void setup() {
  Serial.begin(9600);

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
    delay(500);
}
