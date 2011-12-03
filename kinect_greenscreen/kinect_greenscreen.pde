import SimpleOpenNI.*;
import processing.video.*;

AlbumCover a;
String api_key = "5eb8478b6d02dcb40022b7b32ade5055";
 
SimpleOpenNI  context;

int offset;

Movie myMovie;

void setup()
{
  // instantiate a new context
  context = new SimpleOpenNI(this);
 
  // enable depth image generation 
  context.enableRGB();
  context.enableDepth();
 
  // enable scene analyser
  context.enableScene();
 
  // create a window the size of the scene
  size(context.sceneWidth(), context.sceneHeight()); 
  // align depth data to image data
  context.alternativeViewPointDepthToImage();
  //calculateOffset();
  //println(offset);
  offset = 0;
  
  // initialise class with artist name and api_key
  //a = new AlbumCover("The Beatles",api_key);
  
  //a.setImageDimensions(width,height);
  
  //a.loadAlbum();
  
  myMovie = new Movie(this, "whitesnake.mov");
  myMovie.play();
 
}
 
void draw()
{
  PImage userScene = createImage(width, height, RGB);
  PImage maskedImage = createImage(width, height, RGB);
  
  // update the camera
  context.update();
 
// background(100, 150, 27);
  // draw scene Image
  //image(a.getCover(),0,0); 
 image(myMovie, 0, 0);
   
  // gives you a label map, 0 = no person, 0+n = person n
   int[] map = context.sceneMap();
 
  // set foundPerson to false at beginning of each frame
  boolean foundPerson = false;
  
 
  // go through all values in the array
  //for (int i=0; i<map.length; i++)
  int loc1,loc2;

  for (int x = 0;x < (width-offset);x++)
  {
    for (int y = 0;y < height;y++)
    {
      loc1 = x + y*width;
      loc2 = (x+offset) + y*width;
      // if something in the foreground has been identified
      if(map[loc2] > 0){
       // change the flag to true
       //foundPerson = true;
       userScene.pixels[loc1] = 255;
     }
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

    
  context.convertRealWorldToProjective(offsetVectorP,offsetVectorW); 
  
  //offset = offsetVectorP.x;
  
  println(offsetVectorP.x);
  println(offsetVectorP.y);
  println(offsetVectorP.z);
  
}


void keyPressed()
{
  if (key == 32)
  {
   a.loadAlbum();
  }
   //background(0);
   //image(a.getCover(),0,0);
}

void movieEvent(Movie m) {
  m.read();
}
