#ifndef LED_I_h
#define LED_I_h

class LED_i {
    public:
        LED_i(int pin);
        void TurnOn();
        void TurnOff();
    private:
        int _pin;
};

#endif