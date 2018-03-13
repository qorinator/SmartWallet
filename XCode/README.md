# Functionality Requirement


### 1. Scan Barcodes
* UPC-E
* Code 39 
* Code 39 mod 43
* Code 93
* Code 128
* EAN-8
* EAN-13
* Aztec
* PDF417
* ITF14
* Interleaved 2 0f 5 codes
* DataMatrix
* QR

No further research has been done on which code is necessary.

### 2. Convert Barcode to bitmap file
* Bitmap pixel maximum width and height
    * 1.54 width = 200 height = 200
### 3. Store bitmap files along with necessary information
* store name
    * character length
* store logo
    * logo pixel dimension?

### 4. Convert bitmap file to c array

### 5. Send c array WemosLolin32lite via bluetooth