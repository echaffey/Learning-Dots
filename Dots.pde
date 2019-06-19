class Dot{
  
  PVector pos;
  PVector acc;
  PVector vel;
  
  Brain brain;
  
  boolean reachedGoal;
  boolean hitBarrier;
  
  float fitness;
  float maxFitness;

  
  Dot(int maxSteps){
    pos = new PVector(width/2,height-10);
    acc = new PVector(0,0);
    vel = new PVector(0,0);
    
    brain = new Brain(maxSteps);
    fitness = 0;
    maxFitness = 0;
    reachedGoal = false;
    hitBarrier = false;
  }
  
  void show(){
    fill(0);
    ellipse(pos.x,pos.y,4,4);
  }
  
  void move(){
    
    if(brain.isAlive()){
      
      if(brain.getMaxStep() > brain.getStep()){
        acc = brain.getDir();
        brain.nextStep();
      }else{
        brain.setAlive(false);
      }
   
    
      vel.add(acc);
      vel.limit(5);
      pos.add(vel);
    }
  }
  
  void update(){
    move();
    
    if(pos.x<2 || pos.y < 2 || pos.x >width-2 || pos.y > height-2){
      brain.setAlive(false);
    }
    else if(dist(pos.x,pos.y,goal.x,goal.y)<7){
      brain.setAlive(false);
      reachedGoal = true;
    }
    //bottom
    else if((pos.x<width-160) && (pos.y > 3*height/5) && (pos.y < (3*height/5)+15)){
      brain.setAlive(false);
      hitBarrier = true;
    }
    //top
    else if((pos.x<width) && (pos.x>160) && (pos.y > height/3) && (pos.y < (height/3)+15)){
      brain.setAlive(false);
      hitBarrier = true;
    }
    
    calcFitness();
  }
  
  void calcFitness(){
    if(reachedGoal){
      fitness = 1.0/16.0 + 10000.0/(float)(brain.getStep()*brain.getStep());
    }
    float distGoal = dist(pos.x,pos.y,goal.x,goal.y);
    fitness = 1.0/(distGoal*distGoal);
    
    if (fitness > maxFitness)
    {
      maxFitness=fitness;
    }
  }
  
  float getFitness(){
    return maxFitness;
  }
  
  boolean isAlive(){
    return brain.isAlive();
  }
  
  boolean reachedGoal(){
    return reachedGoal;
  }
  
  void reachedGoal(boolean state){
    reachedGoal = state;
  }
  
  Brain getBrain(){
    return brain;
  }
  
  void setBrain(Brain newBrain){
    brain = newBrain;
  }
  
  Dot getBaby(){
    Dot baby = new Dot(brain.getMaxStep());
    baby.setBrain(brain.clone());
    return baby;
  }
  
}
