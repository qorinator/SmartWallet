/**
 * This is an interface class to the button
 **/

#ifndef BUTTON_I_h
#define BUTTON_I_h

#include <Bounce2.h>

class Button_i {
    public:
        Button_i(int pin);
        bool IsPressed();
        int Read();
    private:
        Bounce bouncer;
        bool state;
};


#endif