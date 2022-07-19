Movie video_movie;

/**
 * Video player
 *
 * Playback of video files is easy using the Processing Video library.
 * For the best result you should resize your video to be:
 * Width: virtualDisplay.width
 * Height: virtualDisplay.height
 * Format: MP4 / H.264
 * Colour: Grayscale / black&white
 */
void example_video_load() {
  video_movie = new Movie(this, "videos/BadApple.mp4");
  video_movie.loop();
  video_movie.jump(0);
  video_movie.volume(0.0);
}

// Video render tick
void example_video() {
  // Play video
  if (video_movie.available()) {
    video_movie.read();

    // Loop video
    if (video_movie.time() > video_movie.duration() - 0.1) {
      video_movie.jump(0);
    }

    // Debug text
    ui_debug_text = round(video_movie.time() * 100.0) / 100.0 + " / " + round(video_movie.duration() * 100.0) / 100.0 + "s";
  }

  // Draw image
  virtualDisplay.image(video_movie, 0, 0, virtualDisplay.width, virtualDisplay.height);

  // Threshold
  float video_threshold = 0.5;
  virtualDisplay.filter(THRESHOLD, video_threshold);
}
