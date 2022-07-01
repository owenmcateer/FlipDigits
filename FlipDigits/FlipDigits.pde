/**
 * FlipDigit Processing controller
 *
 * Author: Owen McAteer
 * Website: https://github.com/owenmcateer/FlipDigits
 * Licence: GNU General Public License v3.0
 * 
 * Required libraries:
 * - HTTP Requests for Processing (Rune Madsen, Daniel Shiffman)
 * - Video | The Processing Foundation
 * - Net | The Processing Foundation
 */
import http.requests.*;
import processing.video.*;


void setup() {
  // The canvas size depends on the size of your display.
  // width = display_previewDigitSize_w * digits wide + 200
  // height = display_previewDigitSize_y * digits tall + 40
  size(930, 680);
  
  pixelDensity(1);
  frameRate(display_fps);
  colorMode(RGB, 255, 255, 255, 1);
  
  // Core setup functions
  cast_setup();
  stages_setup();
  ui_setup();
  
  // Add your own setup calls here if needed.
  //example_video_load();
}

void draw() {
  // Between beginDraw/endDraw you can draw whatever you want to virtualDisplay(PGraphics)
  virtualDisplay.beginDraw();
  
  // Your animations codes goes here or try these examples
  // Simple animations
  //example_animation();
  
  // Blips
  example_blips();
  
  // Text
  //example_text("Testing 1 2 3", false, true);
  
  // Video player
  //example_video();
  
  // RAW digit mode
  //example_rawdigits();
  
  // End drawing
  virtualDisplay.endDraw();
  
  // Preview frame render
  ui_renderPreview();
  
  // Process frame
  cast_processFrameData();
  
  // Cast to display
  castTick();
}
