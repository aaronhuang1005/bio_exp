#define A_1A 8
#define A_1B 9

void setup() {
  // put your setup code here, to run once:
  pinMode(A_1A,OUTPUT);
  pinMode(A_1B,OUTPUT);
  digitalWrite(A_1A,LOW);
  digitalWrite(A_1B,LOW);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(A_1A,LOW);
  analogWrite(A_1B,255);
  /*
  for(int i = 0; i < 256; i++){
    analogWrite(A_1B,i);
    delay(125);
    Serial.println(i);
  }
  */
}
