import processing.net.*;
int[][] cast_buffer;

/**
 * Cast
 *
 * This code casts the processed digit data to the FlipDigit panels over ETH using an ETH->Serial converter.
 */


/**
 * Setup casting
 *
 * - Creates casting buffer.
 * - If casting is enabled, connected to the ETH-Serial converters.
 */
void cast_setup() {
  // Create buffers
  cast_create_buffer();
  
  // Cast data
  if (!castData) return;
  
  // Connect to each network adapter
  for (int i = 0; i < adapters.length; i++) {
    String[] adapterAddress = split(adapters[i], ':');
    clients[i] = new Client(this, adapterAddress[0], int(adapterAddress[1]));
  }
}


/**
 * Create empty buffer array.
 */
void cast_create_buffer() {
  cast_buffer = new int[display_digits_h][display_digits_w];
}


/**
 * Process frame image
 */
void cast_processFrameData() {
  stages_processFrameData();
  cast_build_buffer();
}


/**
 * Clear cast buffer
 */
void cast_clear_buffer() {
  for (int x = 0; x < cast_buffer.length; x++) {
    for (int y = 0; y < cast_buffer[x].length; y++) {
      cast_buffer[x][y] = 0x00;
    }
  }
}


/**
 * Write raw strings.
 */
void cast_write_raw_text(int x, int y, String text) {
  int posX = x;
  for (char character : text.toCharArray()) {
    cast_set_raw_digit(posX, y, character);
    posX++;
  }
}


/**
 * Write a single raw character into the buffer.
 */
void cast_set_raw_digit(int x, int y, char character) {
  if (x < 0 || x >= display_digits_w || y < 0 || y >= display_digits_h) return;
  
  cast_buffer[y][x] = rawCharacterCodes.get(str(character).toLowerCase(), 0x00);
}


/**
 * Build buffer with image data.
 */
void cast_build_buffer() {
  // RAW mode
  if (display_mode_raw) return;
  
  // Image mode
  for (int x = 0; x < display_digits_w; x++) {
    for (int y = 0; y < display_digits_h; y++) {
      cast_buffer[y][x] = cast_convertImage(x, y);
    }
  }
}


/**
 * Cast data to display
 */
void castTick() {
  // Only if casting is enabled.
  if (!castData) return;
 
  // Push data to all adapters
  for (int adapter = 0; adapter < adapters.length; adapter++) {
    // Each panel connected to adapter
    for (int panelId = 0; panelId < adapter_panels.length; panelId++) {
      // TODO only cast if panels data has changed
      
      // If panel is not connected
      if (clients[adapter].ip() == null) break;
      
      // Send data
      clients[adapter].write(0x80);
      clients[adapter].write((colVideoSync) ? 0x84 : 0x83);
      clients[adapter].write(adapter_panels[panelId]);

      clients[adapter].write(cast_panel_buffer(adapter, panelId));

      clients[adapter].write(0x8F); // Closure
    }
  }
  
  // Video sync update
  if (colVideoSync) {
    for (int adapter = 0; adapter < adapters.length; adapter++) {
      
      // If panel is not connected
      if (clients[adapter].ip() == null) break;
      
      clients[adapter].write(0x80);
      clients[adapter].write(0x82);
      clients[adapter].write(0x8F);
    }
  }
}


/**
 * Process panels buffer.
 */
byte[] cast_panel_buffer(int adapter, int panelId) {
  // Create panel buffer
  byte[] panelBuffer = new byte[7 * 4];
  
  // Populate panel buffer
  int panel_x = adapter * 7;
  int panel_y = panelId * 4;
  
  for (int i = 0; i < 7 * 4; i++) {
    int index_x = i % 7;
    int index_y = floor(i / 7);
    panelBuffer[i] = byte(cast_get_digit(panel_x + index_x, panel_y + index_y));
  }
  
  // Return 7x4 digits
  return panelBuffer;
}


/**
 * Convert image data into 7-segment pixels
 */
int cast_convertImage(int x, int y) {
  String binaryString = "";  
  
  // Dir, x, y
  int[][] checkMap = {
    {1, 0, 0}, // a
    {0, 1, 0}, // b
    {0, 1, 1}, // c
    {1, 0, 2}, // d
    {0, 0, 1}, // e
    {0, 0, 0}, // f
    {1, 0, 1}, // g
  };

  // Load staged images
  stages_screen_v.loadPixels();
  stages_screen_h.loadPixels();

  // Set each segment
  for (int i = 0; i < 7; i++) {
    int val = 0;
    if (checkMap[i][0] == 0) {
      // Vertical
      int index = (x * 2) + (checkMap[i][1]) + (((y * 2) + checkMap[i][2]) * stages_screen_v.width);
      val = stages_screen_v.pixels[index];
    }
    else if (checkMap[i][0] == 1) {
      // Horizontal
      int index = x + (((y * 3) + checkMap[i][2]) * stages_screen_h.width);
      val = stages_screen_h.pixels[index]; 
    }

    // Set segment binary
    binaryString += (brightness(val) > 127) ? 1 : 0;
  }

  // Return number 0-127
  return Integer.parseInt(binaryString, 2);
}


/**
 * Get digits value.
 */
int cast_get_digit(int x, int y) {
  return cast_buffer[y][x];
}
