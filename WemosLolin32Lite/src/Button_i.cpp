#include <Arduino.h>

#include "Button_i.h"

Button_i::Button_i(int pin)
    : state(false) 
{
    pinMode(pin, INPUT);
    bouncer = Bounce();
    bouncer.attach(pin);
    bouncer.interval(5);
}

int Button_i::Read() {
    bouncer.update();
    return bouncer.read();
}

bool Button_i::IsPressed() {
    int buttonRead = Read();
    if (buttonRead == HIGH && state == false){
        state = true;
        return true;
    }
    else if (buttonRead == LOW)
      state = false;
    return false;
}