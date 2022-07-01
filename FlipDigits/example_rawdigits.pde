/**
 * RAW digit mode
 *
 * Write a single character
 * cast_set_raw_digit(x, y, char);
 *
 * Write a  sentence
 * cast_write_raw_text(x, y, String);
 * 
 * Note: Keep in mind x & x begin at zero. 
 */
void example_rawdigits() {
  // Put display into RAW mode
  display_mode_raw = true;
  
  // Clear buffer
  cast_clear_buffer();

  // Write a single character
  cast_set_raw_digit(2, 1, '8');
  
  // Writing a sentence
  cast_write_raw_text(2, 3, "Hello world 1 2 3");
  
  // Animating
  // Switching characters
  cast_set_raw_digit(2, 5, (frameCount % 20) < 10 ? '-' : '_');
  
  // Scroll string
  int x = round((frameCount / 6.0) % display_digits_w);
  cast_write_raw_text(x, 10, "Hello world");
  
  // Drop
  int y = round((frameCount / 10.0) % display_digits_h);
  cast_write_raw_text(display_digits_w - 4, y, "Drop");
}
