PGraphics virtualDisplay;
PImage stages_screen_v;
PImage stages_screen_h;


/**
 * To convert an XY pixel image into 7-segment digits I used a technique
 * inspired by @ksawerykomputery that creates two virtual images.
 * One for all X-aligned segments and a second for all Y-aligned segments.
 * The pixel image is scaled to fit these two images, processed and then
 * combined for the resulting 7-segment image.
 * See cast_convertImage() for where this pixel-to-segment mapping happens.
 * 
 * More reading:
 * - https://ksawerykomputery.pl/tools/flipdigits-player
 * - https://flipdots.com/en/xy7-flip-digits-panels/
 */
void stages_setup() {
  // Create virtual stages
  virtualDisplay = createGraphics(
    display_segmentSize_w * display_digits_w,
    display_segmentSize_h * display_digits_h
  );
  stages_screen_v = new PImage(
    display_digits_w * 2,
    display_digits_h * 2
  );
  stages_screen_h = new PImage(
    display_digits_w,
    display_digits_h * 3
  );
  
  // Set raw character list
  setRawCharacters();
}


/**
 * Scales the pixel stage image onto the X&Y aligned segments images before processing.
 */
void stages_processFrameData() {
  // V (2x2)
  stages_screen_v.copy(virtualDisplay, 0, 0, virtualDisplay.width, virtualDisplay.height, 0, 0, display_digits_w * 2, display_digits_h * 2);
  // H (1x3)  
  stages_screen_h.copy(virtualDisplay, 0, 0, virtualDisplay.width, virtualDisplay.height, 0, 0, display_digits_w, display_digits_h * 3);
}
