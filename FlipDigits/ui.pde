PImage[] previewSegments;
String ui_debug_text = null;
PFont font_OpenSans;


/**
 * Preload required assets.
 * - Load the 127 possible digit arrangements into memory for the UI preview display.
 * - Font files
 */
void ui_setup() {
  previewSegments = new PImage[128];
  for (int i = 0; i < previewSegments.length; i++) {
    previewSegments[i] = loadImage("segments/segment-" + str(i) + ".png");
  }

  // Preload require fonts
  font_OpenSans = createFont("data/fonts/OpenSans-Regular.ttf", 42);
}


/**
 * Processing window UI
 * 
 * Very much inspired by the amazing FLIPDIGITS PLAYER by @ksawerykomputery
 * https://ksawerykomputery.pl/tools/flipdigits-player
 *
 * This UI gives a preview of the 7-segment display and important stats.
 */
void ui_renderPreview() {  
  // Preview styling
  background(239);
  noFill();
  stroke(84);
  strokeWeight(1);
  fill(39);
  translate(20, 20);

  // Draw digits
  for (int x = 0; x < display_digits_w; x++) {
    for (int y = 0; y < display_digits_h; y++) {
      rect(
        x * display_previewDigitSize_w, 
        y * display_previewDigitSize_h, 
        display_previewDigitSize_w, 
        display_previewDigitSize_h
        );

      int binaryNum = cast_get_digit(x, y);
      ui_drawDigit(
        binaryNum, 
        x * display_previewDigitSize_w, 
        y * display_previewDigitSize_h
        );
    }
  }

  // FlipDigit
  translate(display_width + 20, 10);
  textFont(font_OpenSans);
  textSize(14);
  fill(0);
  noStroke();
  textSize(20);
  text("FlipDigit", 0, 10);
  stroke(0);
  line(0, 25, 140, 25);
  noStroke();

  // FPS
  textSize(14);
  text("FPS: " + round(frameRate * 100) / 100, 0, 50);
  stroke(0);
  line(0, 65, 140, 65);
  noStroke();

  // Virtual displays
  text("Virtual screen", 0, 100);
  image(virtualDisplay, 0, 110);

  text("X-aligned segments", 0, 250);
  image(stages_screen_v, 0, 260);

  text("Y-aligned segments", 0, 320);
  image(stages_screen_h, 0, 330);

  // Network adapters
  text("Network adapters:", 0, 400);
  for (int i = 0; i < adapters.length; i++) {
    text(adapters[i], 15, 420 + i * 20);
    
    fill(212, 15, 15);
    if (castData) {
      fill(18, 222, 45);
    }
    ellipse(6, 415 + i * 20, 7, 7);
    fill(0);
  }

  stroke(0);
  line(0, 500, 140, 500);
  noStroke();

  // Debug text
  text("Debug msg:", 0, 520);
  if (ui_debug_text != null) {
    text(ui_debug_text, 0, 520);
  }

  // RAW byte data being cast (not recommended, but fun to see)
  // You'll need to resize the canvas to see it below the preview display.
  /*
  resetMatrix();
  translate(20, display_height + 20);
  for (int i = 0; i < cast_buffer.length; i++) {
    text(join(nf(cast_buffer[i], 0), ", "), 0, i * 20);
  }
  */
}


/**
 * Draw single digit in preview
 */
void ui_drawDigit(int num, int x, int y) {
  image(
    previewSegments[num], 
    x, 
    y, 
    display_previewDigitSize_w, 
    display_previewDigitSize_h
  );
}
