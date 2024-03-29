#include <Wire.h>
#include "Adafruit_HTU21DF.h"
#define A_1A 8
#define A_1B 9


Adafruit_HTU21DF htu = Adafruit_HTU21DF();

float val_hum = 0; 
int state = 0;

void setup() {
  Serial.begin(9600);
  pinMode(A_1A,OUTPUT);
  pinMode(A_1B,OUTPUT);
  pinMode(13,OUTPUT);
  digitalWrite(13,HIGH);
  digitalWrite(A_1A,LOW);
  digitalWrite(A_1B,LOW);

  if (!htu.begin()) {
    //Serial.println("Couldn't find sensor!");
    //while (1);
  }
}

void loop() {
    //float rel_hum = htu.readHumidity();
    float rel_hum = 0;
    if(Serial.available()){
      String s = Serial.readString();
      //String s = "123";
      s.trim();
      String set_hum = s.substring(0,s.indexOf('/'));
      String switcher = s.substring(s.indexOf('/')+1,s.indexOf('!'));
      val_hum = set_hum.toFloat();
      state = switcher.toInt();
      //Serial.print(val_hum);
      //Serial.print("/");
      //Serial.println(state);
    }
    Serial.println("0.0");
    if(state == 1){
      digitalWrite(A_1A,LOW);
      analogWrite(A_1B,255);
      digitalWrite(13,HIGH);
    }else{
      digitalWrite(A_1A,LOW);
      analogWrite(A_1B,0);
      digitalWrite(13,LOW);
    }
    delay(50);
}
