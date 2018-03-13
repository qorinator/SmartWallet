#ifndef BitmapManager_h
#define BitmapManager_h

#include<List>

class BitmapManager {
    public:
        BitmapManager();
    private:
        std::list<const uint8_t*> bitmapFile;
};

#endif