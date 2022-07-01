/**
 * Display settings
 */
boolean castData = false;                           // Enable casting to FlipDigit displays
int display_fps = 30;                              // FPS 1-60 (recommended 30-40fps with a good serial converter and a baudrate of 57600)
int display_panels_w = 4;                          // Number of 7x4 panels wide
int display_panels_h = 4;                          // Number of 7x4 panels tall
int display_segmentSize_w = 5;
int display_segmentSize_h = 7;
int display_previewDigitSize_w = 52 / 2;
int display_previewDigitSize_h = 80 / 2;
int display_previewDigitSize_scale = 2;            // If you have a really big display you may need to make the preview smaller
int display_digits_w = display_panels_w * 7;
int display_digits_h = display_panels_h * 4;
int display_width = display_digits_w * display_previewDigitSize_w;
int display_height = display_digits_h * display_previewDigitSize_h;
boolean colVideoSync = true;                      // This use the FlipDigit panels "No refresh" mode followed by a "Refresh all" command. Highly recommended
boolean display_mode_raw = false;

// Network settings
// RS485 converters
String[] adapters = {
  "192.168.1.100:5003",
  "192.168.1.100:5002",
  "192.168.1.100:5001",
  "192.168.1.100:5000",
};
byte[] adapter_panels = {
  1, 2, 3, 4
};

Client[] clients = new Client[adapters.length];


/**
 * Below are the bytes for raw character output
 */
IntDict rawCharacterCodes;
void setRawCharacters() {
  rawCharacterCodes = new IntDict();
  rawCharacterCodes.set("0", 0x7E);
  rawCharacterCodes.set("1", 0x30);
  rawCharacterCodes.set("2", 0x6D);
  rawCharacterCodes.set("3", 0x79);
  rawCharacterCodes.set("4", 0x33);
  rawCharacterCodes.set("5", 0x5B);
  rawCharacterCodes.set("6", 0x5F);
  rawCharacterCodes.set("7", 0x70);
  rawCharacterCodes.set("8", 0x7F);
  rawCharacterCodes.set("9", 0x7B);
  
  rawCharacterCodes.set("a", 0x77);
  rawCharacterCodes.set("b", 0x1F);
  rawCharacterCodes.set("c", 0x0D);
  rawCharacterCodes.set("d", 0x3D);
  rawCharacterCodes.set("e", 0x4F);
  rawCharacterCodes.set("f", 0x47);
  rawCharacterCodes.set("g", 0x5E);
  rawCharacterCodes.set("h", 0x17);
  rawCharacterCodes.set("i", 0x04);
  rawCharacterCodes.set("j", 0x3C);
  rawCharacterCodes.set("k", 0x57); // unusable
  rawCharacterCodes.set("l", 0x0E);
  rawCharacterCodes.set("m", 0x54); // unusable
  rawCharacterCodes.set("n", 0x15);
  rawCharacterCodes.set("o", 0x1D);
  rawCharacterCodes.set("p", 0x67);
  rawCharacterCodes.set("q", 0x73);
  rawCharacterCodes.set("r", 0x05);
  rawCharacterCodes.set("s", 0x5B);
  rawCharacterCodes.set("t", 0x0F);
  rawCharacterCodes.set("u", 0x1C);
  rawCharacterCodes.set("v", 0x3A); // unusable
  rawCharacterCodes.set("w", 0x2A); // unusable
  rawCharacterCodes.set("x", 0x37); // unusable
  rawCharacterCodes.set("y", 0x3B);
  rawCharacterCodes.set("z", 0x6D);
  
  rawCharacterCodes.set("-", 0x01);
  rawCharacterCodes.set("_", 0x08);
  rawCharacterCodes.set("=", 0x09);
}
