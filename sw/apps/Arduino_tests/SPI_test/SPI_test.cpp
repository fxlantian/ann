
#include "SPI.h"

#include <main.cpp>


int y;

void setup()
{
  //Serial.begin(781250);
  SPI.begin();
}

void loop()
{
  SPISettings mySettings(5000000, MSBFIRST, SPI_MODE0);
  SPI.beginTransaction(mySettings);
  y=SPI.transfer(0x9F);
  Serial.print("Received=");
  Serial.print(y);
  Serial.print("\tExpected=");
//  Serial.println("28");
  Serial.print("28\n");
  SPI.endTransaction();
  delay(1);

  if (y == 28)
    exit(0);
  else
    exit(1);
}
