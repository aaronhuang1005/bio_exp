import processing.serial.*;

Serial myPort;
PrintWriter output;
int humidity = 0;
int set_humidity = 50;
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
    println("Error");
  }
  
}

void draw(){
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
      fill(20, 30, 2);
      textSize(15);
      text("ON", 670, 380);
    }else{
      fill(30, 20, 20);
      textSize(15);
      text("OFF", 670, 380);
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
