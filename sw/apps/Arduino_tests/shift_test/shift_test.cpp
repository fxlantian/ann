
#include <main.cpp>

volatile uint8_t x;

void setup()
{
  Serial.begin(781250);
  pinMode(6,OUTPUT);	//used to intiate test bench stimulus (for simulation only)
  pinMode(1,OUTPUT);
  pinMode(2,OUTPUT);
  pinMode(3,INPUT);
  pinMode(4,OUTPUT);   
}

void loop()
{
  shiftOut(1, 2, 0, 5);
  digitalWrite(6, HIGH);
  x=shiftIn(3, 4, 0);
  Serial.print("Recieved\t");
  Serial.print(x);
  Serial.print("\texpected\t");
//  Serial.println("147");
  Serial.print("147\n");

  delay(1);

  exit(0);	//to end simulation properly

}



