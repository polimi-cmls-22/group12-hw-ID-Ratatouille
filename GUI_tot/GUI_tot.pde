import oscP5.*;

import netP5.*;

//import java.util.*;
//import java.util.Map.Entry;

OscP5 oscP5;
NetAddress myRemoteLocation;
NetAddress Supercollider;

int index_a = 0;
int index_b = 0;
int index_c = 0;

float lightLevel = 0.5;
float coordinateX = 750;
float coordinateY = 480;
float cutOff;
float volume;
float lfo;
String LFOfreq;

float posX = 750+5;
float posY = 480+55;

float accX, accY;

PImage sfera1, sfera2, sfera3, sfera4, sfera5, sfera6, sfera7;
int sfera1X,sfera2X,sfera3X,sfera4X,sfera5X,sfera6X,sfera7X;

color light = color(133,219,252);
color medium = color(8,145,255);
color dark = color(13,22,46);
color sky = medium;


PShape s;
int num = 120;
int numFrames = 4;  // The number of frames in the animation
int numFrames_back = 18;
int currentFrame = 0;
PImage radar;
PImage scouter;
PImage titol;
PImage scouter_green;
PImage[] images = new PImage[numFrames];
PImage[] images_back = new PImage[numFrames_back];
//PImage imgSmoke;
float mx[] = new float[num];
float my[] = new float[num];
 //mx[0] = 750-80;
 //my[0] = 470-80;
int sfera = 0;

void setup(){
  // create window
  size (1500, 900, P3D);
  oscP5 = new OscP5(this,57121);
  
  myRemoteLocation = new NetAddress("192.168.1.201", 57121);
  //iphone 172.20.10.3
  //poli 10.169.151.34
 
  
  Supercollider = new NetAddress("127.0.0.1", 57120);

  
  sfera1X = 435;
  sfera2X = sfera1X + 1*90;
  sfera3X = sfera1X + 2*90;
  sfera4X = sfera1X + 3*90;
  sfera5X = sfera1X + 4*90; 
  sfera6X = sfera1X + 5*90;
  sfera7X = sfera1X + 6*90;
  sfera1 = loadImage("sfera1.png");
  sfera2 = loadImage("sfera2.png");
  sfera3 = loadImage("sfera3.png");
  sfera4 = loadImage("sfera4.png");
  sfera5 = loadImage("sfera5.png");
  sfera6 = loadImage("sfera6.png");
  sfera7 = loadImage("sfera7.png");
  
  noStroke();
  
  frameRate(120);
  //imgSmoke = loadImage("Smoke-Effect-Free-PNG-Image.png");

 
  images_back[0]  = loadImage("sfondo1.PNG");
  images_back[1]  = loadImage("sfondo2.PNG");
  images_back[2]  = loadImage("sfondo3.PNG");
  images_back[3]  = loadImage("sfondo4.PNG");
  images_back[4]  = loadImage("sfondo5.PNG");
  images_back[5]  = loadImage("sfondo6.PNG");
  images_back[6]  = loadImage("sfondo7.PNG");
  images_back[7]  = loadImage("sfondo8.PNG");
  images_back[8]  = loadImage("sfondo9.PNG");
  images_back[9]  = loadImage("sfondo10.PNG");
  images_back[10]  = loadImage("sfondo11.PNG");
  images_back[11]  = loadImage("sfondo12.PNG");
  images_back[12]  = loadImage("sfondo13.PNG");
  images_back[13]  = loadImage("sfondo14.PNG");
  images_back[14]  = loadImage("sfondo15.PNG");
  images_back[15]  = loadImage("sfondo16.PNG");
  images_back[16]  = loadImage("sfondo17.PNG");
  images_back[17]  = loadImage("sfondo18.PNG");
  
  images[0]  = loadImage("Goku_0000_Livello-4.png");
  images[1]  = loadImage("Goku_0001_Livello-3.png"); 
  images[2]  = loadImage("Goku_0002_Livello-2.png");
  images[3]  = loadImage("Goku_0003_Livello-1.png");
  
  radar = loadImage("radar.png");
  scouter = loadImage("scouter.png");
  titol = loadImage("titolo.png");
  scouter_green = loadImage("scouter_green.png");

}

void oscEvent(OscMessage theOscMessage)
{
  theOscMessage.print();
   if(theOscMessage.checkAddrPattern("/light") == true)
   { 
     int valueLight = theOscMessage.get(0).intValue();
     lightLevel = map(valueLight, 0, 1023, 0, 1);
     //println("received value from SC" + lightLevel);
     
   } else if (theOscMessage.checkAddrPattern("/cutOff") == true)  { 
     cutOff = theOscMessage.get(0).floatValue();
     //println("received value from SC  " + cutOff);
   } else if (theOscMessage.checkAddrPattern("/xAxis") == true)  {
    int valueX = theOscMessage.get(0).intValue();
     accX = map(valueX, 107, 310, 200, 1265);
     coordinateX = accX;
   } else if (theOscMessage.checkAddrPattern("/yAxis") == true)  {
      int valueY = theOscMessage.get(0).intValue(); // from serial we get a string, turn it into integer
      lfo = valueY;
      accY = map(valueY, 111, 313, 220, 780);
      coordinateY = accY;
   }  else if (theOscMessage.checkAddrPattern("lfofreq") == true)  {
      lfo = theOscMessage.get(0).floatValue(); // from serial we get a string, turn it into integer
   } else if (theOscMessage.checkAddrPattern("/master") == true)  {
      volume = theOscMessage.get(0).floatValue(); // from serial we get a string, turn it into integer
   };

}


void draw(){

  background(#4FB727);

  noStroke();
  color sky = lerpColor(dark, light, lightLevel);
  fill(sky);
  rect(0, 0, 1500, 900);
  
  image(sfera1, sfera1X, 20, 80 , 80);
  image(sfera2, sfera2X, 20, 80 , 80);
  image(sfera3, sfera3X, 20, 80 , 80);
  image(sfera4, sfera4X, 20, 80 , 80);
  image(sfera5, sfera5X, 20, 80 , 80);
  image(sfera6, sfera6X, 20, 80 , 80);
  image(sfera7, sfera7X, 20, 80 , 80);
  
  if(frameCount%6==1){
  currentFrame = (currentFrame+1); 
  } 

  image(images_back[currentFrame % numFrames_back], 0, 60, 1500, 840);
  
  int which = frameCount % num;
  mx[which] = coordinateX;
  my[which] = coordinateY;
 
  noStroke();
  image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
   
   if (sfera == 1)
    {tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
    } else if (sfera == 2)
    {tint(229, 154, 14);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
    } else if (sfera == 3)
    {tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
    } else if (sfera == 4)
    {tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
    } else if (sfera == 5)
    {tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
    } else if (sfera == 6)
    {tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
    } else if (sfera == 7)
    {tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    } else{
    noTint();
   }
             
    
 if ((mouseX > sfera1X && mouseX < sfera2X) && (mouseY > 50 && mouseY < 100) )  {
    noTint();
    image(sfera1, sfera1X, 20, 80 , 80);
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
  } else if ((mouseX > sfera2X && mouseX < sfera3X) && (mouseY > 50 && mouseY < 100) )  {
    noTint();
    image(sfera2, sfera2X, 20, 80 , 80);
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    tint(229, 154, 14);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
  } else if ((mouseX > sfera3X && mouseX < sfera4X) && (mouseY > 50 && mouseY < 100) )  {
    noTint();
    image(sfera3, sfera3X, 20, 80 , 80);  
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
  } else if ((mouseX > sfera4X && mouseX < sfera5X) && (mouseY > 50 && mouseY < 100) )  {
    noTint();
    image(sfera4, sfera4X, 20, 80 , 80);
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
  } else if ((mouseX > sfera5X && mouseX < sfera6X) && (mouseY > 50 && mouseY < 100) )  {
    noTint();
    image(sfera5, sfera5X, 20, 80 , 80); 
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
  } else if ((mouseX > sfera6X && mouseX < sfera7X) && (mouseY > 50 && mouseY < 100) )  {
    noTint();
    image(sfera6, sfera6X, 20, 80 , 80);
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    image(sfera7, sfera7X, 20, 80 , 80);
  } else if ((mouseX > sfera7X && mouseX < 1055) && (mouseY > 50 && mouseY < 100) )  {
    noTint();
    image(sfera7, sfera7X, 20, 80 , 80);
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    tint(229, 154, 14);
    image(sfera2, sfera2X, 20, 80 , 80);
    image(sfera3, sfera3X, 20, 80 , 80);
    image(sfera4, sfera4X, 20, 80 , 80);
    image(sfera5, sfera5X, 20, 80 , 80);
    image(sfera6, sfera6X, 20, 80 , 80);
    image(sfera1, sfera1X, 20, 80 , 80);
    } else {
    noTint();
    image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    };
   
    for (int i = 0; i < num; i++) {
    // which+1 is the smallest (the oldest in the array)
    int index = (which + num -  i) % num;
    
    posX = mx[index]+5;
    posY = my[index]+55;
    
    //tint(247, 190, 32, 50*(num-1-i)) ;
    //image(imgSmoke,posX -10 + 3*i, posY -10 + 2*i, 30 + 10*(i+1)/2, 30 + 10*(i+1)/2);
    
    fill(247, 190, 32,2*(num-1-i)-15) ;
    ellipse(posX + 3*i, posY + i, 15 + 3*(i+1)/2, 15 + 3*(i+1)/2);
    
    noTint();
    //image(images[currentFrame % numFrames], mx[which]-80, my[which]-80, 160, 160);
    }
  
  image(radar,1350,750,150,150);
  image(radar,0,750,150,150);
  image(scouter,1200,-65,300,300);
  image(titol,-40,-60,titol.width/5,titol.height/5);
  
  image(scouter_green,10,100,scouter_green.width/11+20,scouter_green.height/11+20);

  
  
  textSize(25);
  fill(255);
  text("PAN\n", 1350+50, 750+75);
  text("+1", 1350+55, 750+105);
  text("PAN\n", 50, 750+75);
  text("-1", 55, 750+105);
  
  textSize(40);
  fill(250, 255, 114);
  
  text(nfc(volume,2),1220,50);
  
  textSize(25);
  fill(250, 255, 114);
  
  text(nfc(lfo,2),130,205);
  text(nfc(cutOff,1), 123, 243);
  
    
}

void mousePressed(){
  if ((mouseX > sfera1X && mouseX < sfera2X) && (mouseY > 50 && mouseY < 100) )  {
    print("sfera1 ");
    sfera = 1;
  } else if ((mouseX > sfera2X && mouseX < sfera3X) && (mouseY > 50 && mouseY < 100) )  {
    print("sfera2 ");
    sfera = 2;
  } else if ((mouseX > sfera3X && mouseX < sfera4X) && (mouseY > 50 && mouseY < 100) )  {
    print("sfera3 ");
    sfera = 3;    
  } else if ((mouseX > sfera4X && mouseX < sfera5X) && (mouseY > 50 && mouseY < 100) )  {
    print("sfera4 ");
    sfera = 4;
  } else if ((mouseX > sfera5X && mouseX < sfera6X) && (mouseY > 50 && mouseY < 100) )  {
    print("sfera5 ");
    sfera = 5;
  } else if ((mouseX > sfera6X && mouseX < sfera7X) && (mouseY > 50 && mouseY < 100) )  {
    print("sfera6 ");
    sfera = 6;
  } else if ((mouseX > sfera7X && mouseX < 1055) && (mouseY > 50 && mouseY < 100) )  {
    print("sfera7 ");
    sfera = 7; 
  }
  
  OscMessage myMessage = new OscMessage("/sferaScelta");
  myMessage.add(sfera);
  oscP5.send(myMessage, Supercollider); 
  myMessage.print();
}
