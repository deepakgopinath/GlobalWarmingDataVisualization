class ParticleSystem
{
   ArrayList<Particle>particles; // List to hold the smoke particles
   PVector origin; // The origin of each smoke system
   PImage img; // the image to be used for each smoke particle
   
   ParticleSystem(int num, PVector v, PImage img_)
   {
     particles = new ArrayList<Particle>();
     origin = v.get();
     img = img_;
     for(int i= 0; i<num ; i++)
     {
       particles.add(new Particle(origin, img));
     }
   }
   
   void run(float heightOfSmoke)
   {
     
     for(int i=particles.size()-1; i>=0; i--)
     {
       Particle p = (Particle)particles.get(i);
       p.updatevxInc(heightOfSmoke*0.1); // Change the smoke height velocity depending on the data value for each smoke plume.
       p.run();
       if(p.isDead())
       {
         particles.remove(i); // to bring about the smoke fade effect
       }
     }    
   }
   
   void addParticle()
   {
    particles.add(new Particle(origin,img)); // Keep adding particles so that the smoke is kept alive.
   }
   
   void changeOrigin(PVector newOrigin)
   {
     origin = newOrigin.get();  
   }
  
}
