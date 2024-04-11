import processing.serial.*;

Serial myPort;
int port = 0;
PrintWriter output;
int humidity = 0;
int humidity_pre = 0;
int time = 40;
int shift = time;
int set_humidity = 50;
int page = 0;
int set_position = 90;
int bpm = 1;
Boolean motor = false;
Boolean state = false;
Boolean record = false;

void setup(){
  size(700, 400);
  windowResize(700, 400);
  frameRate(30);
  background(0x20);
  
  noStroke();
  fill(0x25);
  rect(20, 20, 500, 360, 7);
  
  stroke(255, 255, 255);
  line(40, 342 , 480, 342);
  
  output = createWriter("positions.txt");
  /*
  try {
    println(Serial.list()[0]);
    myPort = new Serial(this, Serial.list()[0], 9600);
  }catch(RuntimeException e) {
    println("Error setup port 001");
  }
  */
  
}

void draw(){
  if(page == 0){
    noStroke();
    fill(0x20);
    rect(520, 0, 180, 400, 7);

    fill(255, 255, 255);
    textSize(15);                                               
    text("Setup Humidity", 560, 40);
    
    noStroke();
    if(!state){
      fill(0x35);
    }else{
      fill(0x25);
    }
    rect(570, 50, 80, 80, 10);
    
    fill(255, 255, 255);
    textSize(30);
    text(Integer.toString(set_humidity) + " %", 580, 100);
    
    fill(255, 255, 255);
    textSize(15);                                               
    text("BPS", 595, 160);
    
    noStroke();
    if(state){
      fill(0x35);
    }else{
      fill(0x25);
    }
    rect(570, 170, 80, 80, 10);
    
    fill(255, 255, 255);
    textSize(30);
    text(Integer.toString(bpm), 600, 220);
    
    noStroke();
    if(state){
      fill(0x35);
    }else{
      fill(0x25);
    }
    rect(570, 260, 80, 80, 10);
    if(motor){
      fill(0, 255, 0);
      textSize(30);
      text("ON", 590, 310);
    }else{
      fill(255, 0, 0);
      textSize(30);
      text("OFF", 586, 310);
    }  
    
    fill(0x60);
    textSize(15);
    text("Record:", 575, 370);
    if(record){
      fill(50, 200, 50);
      textSize(15);
      text("ON", 625, 370);
    }else{
      fill(200, 50, 50);
      textSize(15);
      text("OFF", 625, 370);
    }

    shift = time + 2;
    noStroke();
    fill(0x25);
    quad(shift-1, 20 ,shift+30,20, shift+30,341, shift-1,340);
    
    fill(150, 255, 150);
    textSize(15);
    text(Integer.toString(humidity), shift + 1, 340 - 3*(humidity));
    
    stroke(150, 255, 150);
    line(time, 340 - 3*(humidity_pre), shift, 340 - 3*(humidity));
    humidity_pre = humidity;
    time = shift;

    
    if(shift >= 480){
      /*
      noStroke();
      fill(0x25);
      rect(20, 20, 500, 360, 7);
      
      */
      noStroke();
      fill(0x25);
      quad(shift-1, 20 ,shift+30,20, shift+30,341, shift-1,341);
      
      stroke(255, 255, 255);
      line(40, 342 , 480, 342);
      
      time = 40;
    }
  }else if(page == 1){
    set_position = 90;
    noStroke();
    fill(0x20);
    rect(0, 0, 700, 400, 0);
    
    fill(255, 255, 255);
    textSize(25);
    text("Serial port :", 270, set_position);
    
    for(int i=0;i<Serial.list().length;i++){
      set_position += 30;
      fill(255, 255, 255);
      textSize(18);
      text(Integer.toString(i+1)+"  "+Serial.list()[i], 300, set_position);
    }
  }
  
  if(record){
    output.println(Integer.toString(hour())+":"+Integer.toString(minute())+":"+Integer.toString(second())+" "+Integer.toString(humidity));
  }
}

void serialEvent(Serial myPort){
    try{
      String inString = myPort.readStringUntil('\n');
      println(inString);
      if (inString != null) 
      {
        inString = trim(inString);
        humidity = Integer.parseInt(inString);
        if(humidity>110){
          humidity = 100;
        }else if(humidity<=0){
          humidity = 0;
        }
      }
    }catch(RuntimeException e) {
      println(e);
    }
}

void keyPressed(){
  //println(key);
  if(page == 1){
    try{
      if(key == '1'){
        myPort = new Serial(this, Serial.list()[0], 9600);
        println("port setup");
        port = 1;
      }else if(key == '2'){
        myPort = new Serial(this, Serial.list()[1], 9600);
        println("port setup");
        port = 2;
      }else if(key == '3'){
        myPort = new Serial(this, Serial.list()[2], 9600);
        println("port setup");
        port = 3;
      }else if(key == '4'){
        myPort = new Serial(this, Serial.list()[3], 9600);
        println("port setup");
        port = 4;
      }else if(key == '5'){
        myPort = new Serial(this, Serial.list()[4], 9600);
        println("port setup");
        port = 5;
      }else if(key == '6'){
        myPort = new Serial(this, Serial.list()[5], 9600);
        println("port setup");
        port = 6;
      }else if(key == '7'){
        myPort = new Serial(this, Serial.list()[6], 9600);
        println("port setup");
        port = 7;
      }else if(key == '8'){
        myPort = new Serial(this, Serial.list()[7], 9600);
        println("port setup");
        port = 8;
      }
    }catch(RuntimeException e){
      //println(e);
      if(port != 0 ){
        println("Error setup port 001 : port already setup");
      }else{
        println("Error setup port 002");
      }
    }
  }
  if(key == ' '){
    //println("space");
    motor = !motor;
    String temp = Integer.toString(set_humidity)+"|"+Integer.toString(bpm);
    if(motor){
      temp += "/1!\n";
    }else{
      temp += "/0!\n";
    }
    if(port != 0){
      myPort.write(temp);
    }else{
        println("Error setup port 002");
    }
    println(temp);
  }else if(key == 'r' || key == 'R' || key == '\n'){
    record = !record;
  }else if(key == ESC){
    output.flush(); // Writes the remaining data to the file
    output.close();
    exit();
  }else if(key == 'P' || key == 'p'){
    page += 1;
    page = page % 2;
    noStroke();
    fill(0x25);
    rect(20, 20, 500, 360, 7);
    
    stroke(255, 255, 255);
    line(40, 342 , 480, 342);
  }else if(key == CODED){
    if(keyCode == UP){
      if(!state){
        if(set_humidity < 90){
          set_humidity += 10;
        }
      }else{
        if(bpm<6){
          bpm += 1;
        }
      }
      String temp = Integer.toString(set_humidity)+"|"+Integer.toString(bpm);
      if(motor){
        temp += "/1!\n";
      }else{
        temp += "/0!\n";
      }
      if(port != 0){
        myPort.write(temp);
      }else{
        println("Error setup port 002");
      }
      println(temp);
    }else if(keyCode == DOWN){
      if(!state){
        if(set_humidity > 50){
          set_humidity -= 10;
        }
      }else{
        if(bpm>1){
          bpm -= 1;
        }
      }
      String temp = Integer.toString(set_humidity)+"|"+Integer.toString(bpm);
      if(motor){
        temp += "/1!\n";
      }else{
        temp += "/0!\n";
      }
      if(port != 0){
        myPort.write(temp);
      }else{
        println("Error setup port 002");
      }
      println(temp);
    }else if(keyCode == LEFT){
      state = false;
    }else if(keyCode == RIGHT){
      state = true;
    }
  }
}
