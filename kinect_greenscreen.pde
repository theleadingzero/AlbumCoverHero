import SimpleOpenNI.*;
 
SimpleOpenNI  context;

float offset;

void setup()
{
  // instantiate a new context
  context = new SimpleOpenNI(this);
 
  // enable depth image generation 
  context.enableRGB();
 
  // enable scene analyser
  context.enableScene();
 
  // create a window the size of the scene
  size(context.sceneWidth(), context.sceneHeight()); 
  
  calculateOffset();
  println(offset);
}
 
void draw()
{
  PImage userScene = createImage(width, height, RGB);
  PImage maskedImage = createImage(width, height, RGB);
  
  // update the camera
  context.update();
 
 background(100, 150, 27);
  // draw scene Image
   
 
  // gives you a label map, 0 = no person, 0+n = person n
   int[] map = context.sceneMap();
 
  // set foundPerson to false at beginning of each frame
  boolean foundPerson = false;
 
  // go through all values in the array
  for (int i=0; i<map.length; i++){
     // if something in the foreground has been identified
     if(map[i] > 0){
       // change the flag to true
       //foundPerson = true;
       userScene.pixels[i] = 255;
     }
   }
   
   maskedImage = context.rgbImage();
   maskedImage.mask(userScene);
   image(maskedImage, 0, 0);
   //if (foundPerson)
     //println("Found Person");
 
}

void calculateOffset() {
  PVector offsetVectorW = new PVector();
  PVector offsetVectorP = new PVector();
  
  offsetVectorW.x = 800;
  offsetVectorW.y = 50;
  offsetVectorW.z = 80;
  
  context.convertRealWorldToProjective(offsetVectorW, offsetVectorP); 
  
  offset = offsetVectorP.x;
  
  println(offsetVectorP.x);
  println(offsetVectorP.y);
  println(offsetVectorP.z);
}
