// Each smoke particle is approximated with an image. Gave me denser textures for fewer number of particles in each particle system. 

class Particle{

  PVector loc;
  PImage img;
  PVector vel;
  float lifespan;
  float vxInc ;
  
  Particle(PVector v, PImage img_)
  {
    vxInc = 9.0;
    float vx = abs(randomGaussian()*0.3) + vxInc;
    float vy = randomGaussian()*0.2;
    loc = v.get();
    img = img_;
    vel = new PVector(vx, vy);
    lifespan = 50.0;
  }

  void run()
  {
    update();
    render();
  }
  
  void update()
  {
    loc.add(vel);
    lifespan -= random(1);   
  }
  void render()
  {
    imageMode(CENTER);
    tint(255, lifespan);
    image(img, loc.x, loc.y);
    tint(255,255);
  }
  
  boolean isDead()
  {
    if(lifespan <=0.0) {
      return true;
    }else {
      return false;
    }
  }
  
  void updatevxInc(float heightOfSmoke)
  {
   float tempVxInc  = heightOfSmoke*0.1;
   vel.x = vel.x - vxInc + tempVxInc;
   vxInc = tempVxInc;
  }
  
}
