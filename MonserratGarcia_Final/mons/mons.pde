//Biblioteca pd
import oscP5.*;
import netP5.*;
OscP5 oscP5;

//IP
NetAddress myRemoteLocation;

//Variables que activan los colores de las figuras
float r;
float g; 
float b; 
float a; 

float s;
float d;
float f;
float h;

//Variables que activan el tamaño y la posición de las figuras
float diam;
float x;
float y;

void setup () {
  stroke (x); //Lineas de la figura
  size (500,500); //tamaño de la pantalla
  background (a); //fondo negro
  smooth (500); //suavizado de las figurass
  
  frameRate(15);
  //puerto a escuchar
  oscP5 = new OscP5(this,12001); //conexión a pd
  
  //Dirección
  myRemoteLocation = new NetAddress("192.168.1.254",12001); //conexión por medio de IP
}

void draw () {

  //POsición ranodm de las figuras
  x = random (width);
  y = random (height);
  
  //figuras
  fill (r, g, b, a);
  triangle (x, y, x, x, y, x);
  ellipse (x,y,x,x);
}

void mousePressed() {
  /* create a new osc message object */
  OscMessage myMessage = new OscMessage("/mouseX");
  myMessage.add(mouseX);/* add a string to the osc message */
  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}
  //Recibe la función al puerto
void oscEvent(OscMessage theOscMessage) {  
  //si el mensaje está etiquetado como "/a"
  if (theOscMessage.checkAddrPattern("/a") == true) {
    //asigna el valor entero a la variable a
    a = theOscMessage.get(0).intValue();
  r = 255;
  g = 150;
  b = 50;
  a = 50; //transparecia 
  }
  
    if (theOscMessage.checkAddrPattern("/s") == true) {
    //asigna el valor entero a la variable S
    s = theOscMessage.get(0).intValue();
  r = 0;
  g = 255;
  b = 0;
  a = 50;
  }
  
   if (theOscMessage.checkAddrPattern("/d") == true) {
    //asigna el valor entero a la variable D
    d = theOscMessage.get(0).intValue();
  r = 0;
  g = 0;
  b = 255;
  a = 50;
  }
  
   if (theOscMessage.checkAddrPattern("/f") == true) {
    //asigna el valor entero a la variable F
    f = theOscMessage.get(0).intValue();
  r = 255;
  g = 255;
  b = 0;
  a = 50;
  }
  
  if (theOscMessage.checkAddrPattern("/h") == true) {
    //asigna el valor entero a la variable H
    h = theOscMessage.get(0).intValue();
  r = 255;
  g = 0;
  b = 0;
  a = 50;
  }
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
