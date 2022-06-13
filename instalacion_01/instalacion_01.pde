import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import processing.sound.*;

SoundFile file;

Capture cam;
OpenCV opencv;
String[] cameras = Capture.list();


PImage img;

int timer;
int counter;

float barra =0;

boolean gg = false;
void setup() {
 // fullScreen();
 
 file = new SoundFile(this, "audio1.wav");
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an
    // element from the array returned by list():
    //cam = new Capture(this, cameras[0]);
    //cam = new Capture(this, 640/2, 480/2);
      cam = new Capture(this, "pipeline:autovideosrc");
    cam.start();
  }

  counter =0;
  timer = millis();
  size(1920,1080, P2D);
  img = loadImage("imgs/imggg.jpg");

  opencv = new OpenCV(this, 640,480);
  opencv.loadCascade(OpenCV.CASCADE_EYE);
}

void draw() {
 // background(0);
  //fill(0,0,0);
  //rect(0,0,width,height);
  frameRate(30);
  //scale(2);
  opencv.loadImage(cam);
 // tint(255, 50);
  image(cam, 0, 0, 1920,1080);



  // println(second());



  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();

  for (int i =0; i < faces.length; i++) {
    rect(map(faces[i].x,0,640,0,1920), map(faces[i].y,0,480,0,1080), faces[i].width, faces[i].height);
  }

  if ( faces.length== 0) {
   // tint(255, 255);
    image(cam, 0, 0, 1920, 1080);
    //tint(255, 50);
    //que aparezca un texto
    //que aparezca la misma imagen modificada
    //que pase otra cosa
    //que se reprodusca un sonido
    //saveFrame("imgs/imggg.jpg");
    //img = loadImage("imgs/imggg.jpg");
    //img.resize(640/2, 480/2);

    
    if (millis() > timer + 60000) {
      println(counter);

      counter++;
      timer =millis();
    }
    barra += 1/frameRate;
  }
  textSize(25);
  text("cubrite los ojos durante " + str(60-(int)barra) + " segundos", 20, 500);

  if (barra > 60) {
    barra =0;
    gg = true;
  }
    if (barra > 5) {
    gg =true;
    
    
    
   // println("sound.play");
  }


  if (gg == true && !file.isPlaying()) {
    file.play();
  }



  //barra =0;
}




void captureEvent(Capture c) {

  c.read();
}
