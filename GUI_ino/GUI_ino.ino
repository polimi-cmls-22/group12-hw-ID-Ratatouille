int sensorLow = 1023;
int sensorHigh = 0;
int light = 0;
int volume = 0;
float X=1.604; 
float gx=0.799;

float Y=1.752; 
float gy=0.788; 

float Z=1.343; 
float gz=0.803;

float val_x, val_y, val_z;
int serial_x;
int serial_y;

void setup() {
  Serial.begin(9600);

  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);
  
  while(millis()<5000)
  {
     light = analogRead(A5);
     if (light > sensorHigh) {
        sensorHigh = light;
      }
      // record the minimum sensor value
      if (light < sensorLow) {
        sensorLow = light;
      }
  }
    digitalWrite(LED_BUILTIN, LOW);    
}

void loop() {
  int x,y,z;
  x=analogRead(0);
  y=analogRead(1);
  z=analogRead(2);
  volume = analogRead(A3);
  val_x = (x*5/1024.0 - X)/gx;
  serial_x = (2+ val_x)*100;
  val_y = (y*5/1024.0 - Y)/gy;
  serial_y = (2+ val_y)*100;    
  light = analogRead(A5);
  Serial.print(light);
  Serial.print("a");
  Serial.print(serial_x);
  Serial.print("b");
  Serial.print(serial_y);
  Serial.print("c");
  Serial.print(volume);
  Serial.println("d");
  delay(100);
}
