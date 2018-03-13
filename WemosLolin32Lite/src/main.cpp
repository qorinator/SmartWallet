#include <Arduino.h>

#include "EDP_i.h"
#include "Button_i.h"
#include "LED_i.h"
#include "BitmapGraphics.h"

int pinButtonUp = 27;
int pinLEDExternal = 26;

EDP_i display;
Button_i buttonUp(pinButtonUp);
LED_i led(pinLEDExternal);

void setup() {
    Serial.begin(9600);
}

int buttonRead = 0;
bool buttonState = true;
int pageCounter = 0;
int maxPage = 5;
void loop() {
    if (buttonUp.IsPressed()) {
        led.TurnOn();
        switch(pageCounter) {
            case 0 : 
                display.Update(gImage_barcodeAh);
                break;
            case 1 : 
                display.Update(gImage_barcodeHM_it2);
                break;
            case 2 : 
                display.Update(gImage_barcodeGM);
                break;
            case 3 :
                display.Update(gImage_albertheijn_withname2);
                break;
            case 4 :
                display.Update(gImage_barcodeHM_it2_blackbox);
                break;
            case 5 :
                display.Update(gImage_barcodeHM_highreso);
                break;
        }
        pageCounter += 1;
        if (pageCounter > maxPage)
            pageCounter = 0;
        delay(10);
        led.TurnOff();
    }
    // buttonRead = buttonUp.Read();
    // if (buttonRead == HIGH && buttonState == true) {
    //     led.TurnOn();
    //     switch(pageCounter) {
    //         case 0 : 
    //             display.Update(gImage_albertheijnwithname);
    //             break;
    //         case 1 : 
    //             display.Update(gImage_albertheijn_withname2);
    //             break;
    //         case 2 : 
    //             display.Update(gImage_albertheijnbarcode);
    //             break; 
    //     }
    //     pageCounter += 1;
    //     if (pageCounter > maxPage)
    //         pageCounter = 0;
    //     delay(100);
    //     led.TurnOff();
    //     buttonState = false;
    // }
    // else if (buttonRead == LOW){
    //     buttonState = true;
    // }   
}