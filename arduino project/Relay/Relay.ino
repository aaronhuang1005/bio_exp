void setup() {
  pinMode(10,OUTPUT);
}

void loop() {
  digitalWrite(10,HIGH);
  delay(500);
  digitalWrite(10,LOW);
  delay(500);
}
