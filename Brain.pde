class Brain{
  
  PVector[] dir;
  private int step;
  private int maxStep;
  float mutationRate;
  
  boolean alive;
  
  Brain(int size){
    this.dir = new PVector[size];
    this.maxStep = size;
    alive = true;
    randomize();
  }
  
  void randomize(){
    for(int i = 0; i < dir.length; i++){
      float angle = random(2*PI);
      this.dir[i] = PVector.fromAngle(angle);
    }
  }
  
  PVector getDir(){
    return this.dir[this.step];
  }
  
  PVector[] getDirArr(){
    return dir;
  }
  
  void setDirArr(PVector[] arr){
    dir = arr;
  }
  
  int getStep(){
    return this.step;
  }
  
  void setMaxStep(int max){
    maxStep = max;
  }
  
  void resetStep(){
    step = 0;
  }
  
  void nextStep(){
    if(alive){
      this.step++;
    }
  }
  
  int getMaxStep(){
    return this.maxStep;
  }
  
  boolean isAlive(){
    return alive;
  }
  
  void setAlive(boolean state){
    alive = state;
  }
  
  Brain clone(){
    Brain clone = new Brain(dir.length);
    for(int i = 0; i < dir.length; i++){
      clone.dir[i] = this.dir[i].copy();
    }
    return clone;
  }
  
  void mutate(){
    //1% chance to mutate directions
    mutationRate = 1.0/sqrt(maxStep);
    //float mutationRate = 0.04;
    
    for(int i = 0;i<dir.length;i++){
      float rand = random(1);
      if(rand < mutationRate){
        float randomAngle = random(2*PI);
        dir[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
  
  
}
