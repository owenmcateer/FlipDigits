/**
 * Text
 * 
 * You can write text to the display and have it scroll.
 * Just keep in mind for it to be readable it needs to be quite large.
 */
void example_text(String copy, boolean bg, boolean scrolling) {
  // Color
  if (bg) {
    virtualDisplay.background(255);
    virtualDisplay.fill(0);
    virtualDisplay.stroke(0);
  }
  else {
    virtualDisplay.background(0);
    virtualDisplay.fill(255);
    virtualDisplay.stroke(255);
  }

  // Text style
  virtualDisplay.noStroke();
  virtualDisplay.rectMode(CORNER);
  virtualDisplay.textAlign(LEFT, CENTER);
  virtualDisplay.textFont(font_OpenSans);
  virtualDisplay.textSize(70);
  virtualDisplay.textLeading(70);

  // Text effects
  float effectPosition_x = 0.0;
  float effectPosition_y = 40.0;
  float textBounds = textWidth(copy);
  
  if (scrolling) {
    effectPosition_x = (frameCount * -2) % (textBounds + virtualDisplay.width);
    effectPosition_x += virtualDisplay.width;
  }
  
  // Write text
  virtualDisplay.text(
    copy,
    effectPosition_x,
    effectPosition_y
  );
}
