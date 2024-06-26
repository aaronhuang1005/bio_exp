#include <Wire.h>
#include "Adafruit_HTU21DF.h"
#define A_1A 8
#define A_1B 9


Adafruit_HTU21DF htu = Adafruit_HTU21DF();

float val_hum = 0; 
int state = 0;
int time_stamp = 0;
int bps = 0;

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
    int rel_hum = 50;
    if(Serial.available()){
      String s = Serial.readString();
      //Serial.println(s);
      //String s = "123";
      s.trim();
      String set_hum = s.substring(0,s.indexOf('|'));
      String set_bps = s.substring(s.indexOf('|')+1,s.indexOf('/'));
      String switcher = s.substring(s.indexOf('/')+1,s.indexOf('!'));
      bps = set_bps.toInt();
      val_hum = set_hum.toFloat();
      state = switcher.toInt();
      //Serial.print(set_bps);
      //Serial.print("/");
      //Serial.println(state);
    }
    if(millis()-time_stamp>1000){
      Serial.println(rel_hum);
      time_stamp = millis();
    }
    
    if(state == 1){
      digitalWrite(A_1A,LOW);
      analogWrite(A_1B,255);
      digitalWrite(13,HIGH);
    }else{
      digitalWrite(A_1A,LOW);
      analogWrite(A_1B,0);
      digitalWrite(13,LOW);
    }
}
