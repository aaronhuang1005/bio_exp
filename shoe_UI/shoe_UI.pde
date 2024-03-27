import processing.serial.*;

Serial myPort;
PrintWriter output;
int humidity = 0;
int set_humidity = 50;
int page = 0;
int set_position = 90;
Boolean motor = true;
Boolean record = false;

void setup(){
  size(700, 400);
  windowResize(700, 400);
  frameRate(30);
  background(0x20);
  
  output = createWriter("positions.txt");
  
  try {
    println(Serial.list()[0]);
    myPort = new Serial(this, Serial.list()[0], 9600);
  }catch(RuntimeException e) {
    println("Error setup port 001");
  }
  
}

void draw(){
  if(page == 0){
    noStroke();
    fill(0x20);
    rect(0, 0, 700, 400, 0);
    
    noStroke();
    fill(0x25);
    rect(20, 20, 500, 360, 7);
    
    fill(255, 255, 255);
    textSize(15);
    text("Setup Humidity", 560, 60);
    
    noStroke();
    fill(0x30);
    rect(570, 70, 80, 80, 10);
    
    fill(255, 255, 255);
    textSize(30);
    text(Integer.toString(set_humidity) + " %", 580, 120);
    
    noStroke();
    fill(0x25);
    rect(570, 235, 80, 80, 10);
    if(motor){
      fill(0, 255, 0);
      textSize(30);
      text("ON", 590, 285);
    }else{
      fill(255, 0, 0);
      textSize(30);
      text("OFF", 586, 285);
    }  
    
    fill(0x30);
    textSize(15);
    text("Record:", 620, 380);
    if(record){
      fill(20, 60, 2);
      textSize(15);
      text("ON", 670, 380);
    }else{
      fill(60, 20, 20);
      textSize(15);
      text("OFF", 670, 380);
    }
  }else if(page == 1){
    noStroke();
    fill(0x20);
    rect(0, 0, 700, 400, 0);
    
    fill(255, 255, 255);
    textSize(25);
    text("Serial port :", 290, set_position);
    
    for(int i=0;i<Serial.list().length;i++){
      fill(255, 255, 255);
      textSize(18);
      text(Serial.list()[i], 300, set_position);
      set_position += 10;
    }
  }
  
  if(record){
    output.println(Integer.toString(hour())+":"+Integer.toString(minute())+":"+Integer.toString(second())+" "+Integer.toString(humidity));
  }
}

void serialEvent(Serial myPort){
    try{
      String inString = myPort.readStringUntil('\n');
      if (inString != null) 
      {
        inString = trim(inString);
        humidity = Integer.parseInt(inString);
      }
    }catch(RuntimeException e) {
      background(100,0,0);
      fill(255, 255, 255);
      textSize(80);
      text("ERROR", 540, 320);
      println("Error Null input");
    }
}

void keyPressed(){
  //println(key);
  if(page == 1){
    try{
      if(key == '1'){
        myPort = new Serial(this, Serial.list()[0], 9600);
      }else if(key == '2'){
        myPort = new Serial(this, Serial.list()[1], 9600);
      }else if(key == '3'){
        myPort = new Serial(this, Serial.list()[2], 9600);
      }else if(key == '4'){
        myPort = new Serial(this, Serial.list()[3], 9600);
      }else if(key == '5'){
        myPort = new Serial(this, Serial.list()[4], 9600);
      }else if(key == '6'){
        myPort = new Serial(this, Serial.list()[5], 9600);
      }else if(key == '7'){
        myPort = new Serial(this, Serial.list()[6], 9600);
      }else if(key == '8'){
        myPort = new Serial(this, Serial.list()[7], 9600);
      }
      println("port setup");
    }catch(RuntimeException e){
      println("Error setup port 002");
    }
  }
  if(key == ' '){
    motor = !motor;
    String temp = Integer.toString(humidity);
    if(motor){
      temp += "1";
    }else{
      temp += "0";
    }
  }else if(key == 'r' || key == 'R'){
    record = !record;
  }else if(key == ESC){
    output.flush(); // Writes the remaining data to the file
    output.close();
    exit();
  }else if(key == 'P' || key == 'p'){
    page += 1;
    page = page % 2;
  }else if(key == CODED){
    if(keyCode == UP){
      if(set_humidity < 90){
        set_humidity += 10;
        String temp = Integer.toString(humidity);
        if(motor){
          temp += "1";
        }else{
          temp += "0";
        }
      }
    }else if(keyCode == DOWN){
      if(set_humidity > 50){
        set_humidity -= 10;
        String temp = Integer.toString(humidity);
        if(motor){
          temp += "1";
        }else{
          temp += "0";
        }
      }
    }
    else if(keyCode == RETURN){
      record = !record;
    }
  }
}
