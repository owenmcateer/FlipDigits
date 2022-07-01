/**
 * Example: Animations
 *
 * Simple animations of shapes moving to get an idea
 * of how to animation to the virtualDisplay.
 * Anything you can do to PGraphics you can do here.
 */
void example_animation() {
  // Styles
  virtualDisplay.background(0);
  virtualDisplay.stroke(255);
  virtualDisplay.strokeWeight(2);
  virtualDisplay.fill(255);
  
  // Spinning line
  virtualDisplay.push();
  virtualDisplay.translate(virtualDisplay.width / 2, virtualDisplay.height / 2);
  virtualDisplay.rotate(frameCount / 10.0);
  virtualDisplay.line(-virtualDisplay.width, 0, virtualDisplay.width, 0);
  virtualDisplay.pop();
  
  // Back 'n forth
  virtualDisplay.ellipse(map(cos(frameCount / 10.0), -1, 1, 0, virtualDisplay.width), 10, 20, 20);
  
  // Bouncing ball
  float phase = (frameCount / 50.0) % 1.0;
  virtualDisplay.ellipse(phase * virtualDisplay.width, easeOutBounce(phase, 0, 1, 1) * virtualDisplay.height - 20, 40, 40);
}


// Bounce ease curve function
float easeOutBounce(float t, float b, float c, float d) {
  if ((t/=d) < (1/2.75)) {
    return c*(7.5625*t*t) + b;
  } else if (t < (2/2.75)) {
    return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
  } else if (t < (2.5/2.75)) {
    return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
  } else {
    return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
  }
}
