#include "EDP_i.h"

#include <GxGDEP015OC1/GxGDEP015OC1.cpp>
#include <GxIO/GxIO_SPI/GxIO_SPI.cpp>
#include <GxIO/GxIO.cpp>

EDP_i::EDP_i()
    : _pinSPIBusy(0)
    , _io(SPI, SS, SPIDC, SPIRST)
    , _display(_io, SCK, _pinSPIBusy)
{
    _display.init();
}

void EDP_i::Update(const uint8_t* bitmap) {
    _display.drawExampleBitmap(bitmap, 0, 0, 200, 200, GxEPD_BLACK);
    _display.update();
    delay(100);
}