PImage[] previewSegments;
String ui_debug_text = null;
PFont font_OpenSans;
long ui_start_time;


/**
 * Preload required assets.
 * - Load the 127 possible digit arrangements into memory for the UI preview display.
 * - Font files
 */
void ui_setup() {
  // Runtime
  ui_start_time = millis();
  
  // Preview sizing
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

  // Runtime
  long elapsed_time = millis() - ui_start_time;
  // Format the time as HH:MM:SS
  int hours = (int) (elapsed_time / (1000 * 60 * 60));
  int minutes = (int) ((elapsed_time - (hours * 1000 * 60 * 60)) / (1000 * 60));
  int seconds = (int) ((elapsed_time - (hours * 1000 * 60 * 60) - (minutes * 1000 * 60)) / 1000);
  String formatted_time = String.format("%02d:%02d:%02d", hours, minutes, seconds);
  text("Runtime: " + formatted_time, 0, 70);
  
  stroke(0);
  line(0, 85, 140, 85);
  noStroke();

  // Virtual displays
  text("Virtual screen", 0, 120);
  image(virtualDisplay, 0, 130);

  text("X-aligned segments", 0, 270);
  image(stages_screen_v, 0, 280);

  text("Y-aligned segments", 0, 340);
  image(stages_screen_h, 0, 350);

  // Network adapters
  text("Network adapters:", 0, 420);
  for (int i = 0; i < adapters.length; i++) {
    text(adapters[i], 15, 440 + i * 20);

    fill(212, 15, 15);
    try {
      if (clients[i].ip() != null) {
        fill(18, 222, 45);
      }
    } catch(NullPointerException e) {}
    
    ellipse(6, 435 + i * 20, 7, 7);
    fill(0);
  }

  stroke(0);
  line(0, 520, 140, 520);
  noStroke();

  // Debug text
  text("Debug msg:", 0, 540);
  if (ui_debug_text != null) {
    text(ui_debug_text, 0, 560);
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
