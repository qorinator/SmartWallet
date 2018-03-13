/**
 * This is an interface class to the e-Paper Display (EDP)
 **/
#ifndef _EDP_I_h
#define _EDP_I_h

#include <GxEPD.h>
#include <GxGDEP015OC1/GxGDEP015OC1.h>
#include <GxIO/GxIO_SPI/GxIO_SPI.h>
#include <GxIO/GxIO.h>


class EDP_i {
    public:
        EDP_i();
        void Update(const uint8_t* bitmap);
    private:
        int _pinSPIBusy;
        GxIO_Class _io;
        GxEPD_Class _display;
};

#endif //_EDP_I_h