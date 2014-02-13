                    //*******************Carbon Dioxide Emission Visualization*******************//
                    //*****************by DEEPAK GOPINATH******************//
                    
                    //************* Project 2 - Navigable Info ***************//
                    //********************  LMC 6310 ***********************//




import shapes3d.utils.*; // For rendering the earth
import shapes3d.animation.*;
import shapes3d.*;

// ATTENTION: YOU NEED TO HAVE SHAPES3D.JAR IN YOUR CODE FOLDER
//Declaration of variables

Ellipsoid earth;
int earthRad = 90;

String currentCountry = "";
String previousCountry = "";
int countryCounter = -1;

int noOfCountries = 209;
int noOfYears = 53;

float [][] dataCO2PerCapita = new float[noOfCountries][noOfYears]; // ARRAY TO HOLD CO2 DATA AND LATITUDE LONGITUDE DATA
float [][] latLong = new float[noOfCountries][2];
float [][] dataCO2Total = new float[noOfCountries][noOfYears];

float zoomFactor = 2.5;
float cameraDist = 280;

ArrayList <ParticleSystem> ps; // FOR SMOKE LIFE EFFECT
ArrayList <ParticleSystem> ps2;

ParticleSystem eachPS; // USED IN FOR LOOPS TO KEEP TRACK OF SMOKE EFFECTS

float theta  = 0;
float phi = 0;
float thetaInc = 0;
float phiInc = 0;
float lati;
float longi;

float longiInc = 180; // Longitude phase shift to correct for 3d geometry.
int yearSelected = 1960; //starting year
float histLength = 0; // starting histlength

ArrayList yearlyNewsList = new ArrayList();

int readStatus = 0; //for the marquee
int selectNewsItemForCurrentYear = 0;
int lengthOfString = 0;
int index = 0;
String eachNewsItem;

int CO2TotalSelect = 0;
int CO2PerCapita = 1;
int smokeMode = 0;
int switchMode = 0;
int darkFuture = 0;
int scaleFactor = 12000;
int startFlag;
PImage img; // FOR THE SMOKE PARTICLE

String currentCountryData = "";
String enteredCurrentText = "";
String savedText = "";
ArrayList countryList = new ArrayList();


Ellipsoid AddEllipsoid(int nbrSlices, int nbrSegments, String textureFile, float radius)
{
  Ellipsoid aShape = new Ellipsoid(this, nbrSlices, nbrSegments);
  aShape.setTexture(textureFile);
  aShape.drawMode(Shape3D.TEXTURE);
  aShape.setRadius(radius);
  return aShape;
  
}

void setup()
{
  size(1024,768, P3D);
  background(0);
  frameRate(60);
  stroke(255);
  strokeWeight(1);
  earth = AddEllipsoid(14,14,"Earth.jpg",earthRad); //MAKE THE EARTH
  
  loadCarbonDioxideData(); //LOAD DATA FROM XML
  loadCO2TotalData();
  loadLatLongData();
  loadCountryData();
  loadNewsItems();
  
  ps = new ArrayList();
  ps2 = new ArrayList();
  tweakImage();
  for (int i=0; i<noOfCountries; i++) // MAKE SMOKE FOR EACH COUNTRY AND EACH KIND OF DATA POINT USING DATA FROM 1960 AS DEFAULT
  {
    ps.add(new ParticleSystem(7 + (int)random(6), new PVector(earthRad + 5*dataCO2PerCapita[i][yearSelected - 1960],0), img));
    ps2.add(new ParticleSystem(7 + (int)random(6), new PVector(earthRad + dataCO2Total[i][yearSelected - 1960]/scaleFactor,0), img));
  }
   textAlign(LEFT);
   textSize(18);
  
}

void tweakImage()
{
   img = loadImage("textureEvenSmaller.png");
   img.filter(BLUR);  
}
void draw()
{
  background(0);
  
  if(startFlag == 0)
  {
   displayFirstPage();
  }else if(startFlag == 1)
  {
    displaySecondPage();
  } else if(startFlag > 1) {
  
  readNews();
  drawSelectorButtons();
  text("Current Year:", 810, 125);
  text(yearSelected, 950, 125);
  
  theta = theta + thetaInc; // keeping track of rotation. these angle info is used to position the camera properly.
  phi = phi + phiInc;
  checkAngles(); //check bounds for angles.
  
  pushMatrix();
  translate(width/2,height/2, 0);
  directionalLight(255, 255,255, 0, 0, -1); // Set up some directional lighting. White Light shining from -z direction
  lightSpecular(204, 204, 204);
  directionalLight(255, 255, 255, 0, 1, -1);  
  lightSpecular(202, 202, 202);
  
  for(int i=0; i<noOfCountries; i++)
  {
    lati = radians(latLong[i][0]);
    longi = radians(latLong[i][1] + longiInc);
    
    if(CO2TotalSelect == 1){
      eachPS = (ParticleSystem)ps2.get(i);
    }else if(CO2PerCapita == 1){
       eachPS = (ParticleSystem)ps.get(i);
    }
    beginCamera();
    camera(cameraDist*zoomFactor*sin(theta)*abs(cos(phi)), cameraDist*zoomFactor*sin(phi), cameraDist*zoomFactor*cos(theta)*abs(cos(phi)), 0 ,0 ,0, 0, 1, 0);
    
    if(CO2PerCapita == 1)
      { 
        histLength =   5*dataCO2PerCapita[i][yearSelected - 1960]; // Scale data point by multiplying by 5. 
      }else if (CO2TotalSelect == 1)
      {
        histLength = dataCO2Total[i][yearSelected - 1960]/scaleFactor;
      }
   
      fill(255);
      if(darkFuture != 1)
      {
        earth.draw();
      }
      pushMatrix();
      rotateY(longi); //Get to the correct country
      rotate(-lati);

      if(smokeMode == 1){
        if(switchMode == 1)
        {
          eachPS.changeOrigin(new PVector(histLength,0));
        }
        eachPS.run(histLength);
        for(int k =0 ; k< 2; k++)
        {
        eachPS.addParticle();
        }
      }
      
      translate(earthRad+histLength/2,0,0); //translate after writing the text. // So that the histogram gets drawn properly  
      fill(random(200) + 55,0,0);
      stroke(255,0,0);
      strokeWeight(0.2);
      box(histLength, 3,3);
      popMatrix();
    endCamera();
   
  }
  if(switchMode == 1)
  {
    switchMode = 0;
  }
  popMatrix();
  
  thetaInc *= 0.5; // decelerate rotating angles for camera
  phiInc *= 0.5;
  if(mousePressed){
     
     thetaInc -= (mouseX-pmouseX)*0.01;
     phiInc -= (mouseY-pmouseY)*0.01;
   }
  }
}

void checkAngles()
{
  if(phi >= PI/2)
  {
    phi = PI/2 - 0.01;
  }else if(phi <= -PI/2)
  {
    phi = -PI/2 + 0.01;
  }
}


