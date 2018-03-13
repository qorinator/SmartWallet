#include <Arduino.h>

#include "LED_i.h"

#define ON true
#define OFF false


LED_i::LED_i(int pin)
    : _pin(pin)
{
    pinMode(_pin, OUTPUT);
    TurnOn();
    delay(10);
    TurnOff();
}

void LED_i::TurnOff() {
    if (_pin == LED)
        digitalWrite(_pin, HIGH);
    else
        digitalWrite(_pin, LOW);
}

void LED_i::TurnOn() {
     if (_pin == LED)
        digitalWrite(_pin, LOW);
    else
        digitalWrite(_pin, HIGH);
}