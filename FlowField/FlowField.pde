//Classic: increment = 0.1, scale = 20, forceMag = 1
//Hair: increment = 0.1, scale = 20, forceMag = 0.1
//Art: increment = 0.01, scale = 20, forceMag = 0.5
//Art #2: increment = 0.01, scale = 10, forceMag = 0.5

//-----Set initial variables-----//

//Helps calculate array sizes and loop controls
int initWidth = 1200;
int initHeight = 800;
int numParticles = 10000;

//Range between 1 and 0.01 seems to yield best results. Results dependent upon scale value. 
float increment = 0.01;

//Zooms in and out of pattern. Higher values zoom into scene and are less computationally intensive. Lower values zoom out and are more computationally intensive. SCALE VALUE OF 1 IS UNSTABLE.
float scale = 3;

//Determines how forcefully the particles will adhere to the flow field lines. 
float forceMagnitude = 0.5;

//Declare variables to be used later
float zoff;
int cols = floor(initWidth / scale);
int rows = floor(initHeight /  scale);
int frameSize = cols * rows;

//Initialize vector field
PVector[] flowField;

//Declare particle array
Particle[] particles = new Particle[numParticles];

//-------------------------------//

void setup() {
  size(1200,800);
  frameRate(144);
  background(0);
  
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle();
  }

  flowField = new PVector[cols * rows]; 
}

void draw() {
  //background(0, 1);
  //stroke(255, 99);
  System.out.println(frameRate);
  float yoff = 0;
  for (int j = 0; j < rows; j++) {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      int index = (i + j * cols);
      
      float angle = noise(xoff, yoff, zoff) * (2*PI);
      PVector vector = PVector.fromAngle(angle);
      vector.setMag(forceMagnitude);
 
      flowField[index] = vector;
      
      xoff += increment;
           
      push();
      translate(i * scale, j * scale);
      rotate(vector.heading());
      //line(0,0,scale,0);
      pop();
      
    }
    yoff += increment;
    //zoff += 0.0001; 
  }
  //strokeWeight(1);
  for (int i = 0; i < numParticles; i++) {
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].updateColor();
    particles[i].edges();
    particles[i].show();
  }
  //strokeWeight(1);
  
  
}

void takeScreenshot() {
  saveFrame();
}
