public class Particle {
  PVector position = new PVector();
  PVector prevPosition = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  float maxSpeed = 4; 
  
  float hue;
  float hueDirection;
  float lowerColor = 0;
  float higherColor = 1;
  
  Particle() {
    position = position.set(random(width), random(height));
    velocity = velocity.set(0,0);
    acceleration.set(0,0);
    prevPosition = position.copy();
    
    colorMode(HSB, 100);
    hue = random(lowerColor,higherColor);
    hueDirection = 0.025;
  }
  
  public void update() {
    position = PVector.add(position, velocity);
    velocity = PVector.add(velocity, acceleration);
    velocity.limit(this.maxSpeed);
    acceleration = PVector.mult(acceleration, 0);
    
    colorMode(HSB, 100);
    hue += hueDirection;
    stroke(hue,100,100,5);
  }
  
  public void applyForce(PVector force) {
    acceleration = PVector.add(acceleration, force);
  }
  
  public void follow(PVector[] flowField) {
    int x = floor(this.position.x / scale);
    int y = floor(this.position.y / scale);
    int index = 0;
    
    if (x + y * cols < frameSize) {
      index = x + y * cols;
    }
    
    PVector force = flowField[index];
    this.applyForce(force);
  }
  
  public void updatePrev() {
    this.prevPosition.x = position.x;
    this.prevPosition.y = position.y;
  }
  
  public void edges() {
    if (position.x > width) { 
      position.x = 0;
      updatePrev();
    }
    if (position.x < 0) {
      position.x = width;
      updatePrev();
    }
    if (position.y > height) { 
      position.y = 0;
      updatePrev();
    }
    if (position.y < 0) {
      position.y = height;
      updatePrev();
    }
  }
  
  public void updateColor() {
    if (hue >= higherColor + 15) {
      this.hue = higherColor + 15;
      hueDirection = -hueDirection;
    }
    if (hue <= lowerColor) {
      this.hue = lowerColor;
      hueDirection = -hueDirection;
    } 
  }
  
  public void show() {
    //point(position.x, position.y);
    line(this.position.x, this.position.y, this.prevPosition.x, this.prevPosition.y);
    this.updatePrev();
  }
  
}
