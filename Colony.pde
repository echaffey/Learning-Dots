class Colony{
  
  Dot[] pop;
  Dot bestDot;
  int popSize;
  int generation;
  int maxStep;
  float avgX, avgY;
  
  Colony(int size){
    popSize = size;
    pop = new Dot[size];
    bestDot = new Dot(800);
    maxStep = 0;
    avgX = 0;
    avgY = 0;
    
    for(int i = 0; i < size; i++){
      pop[i] = new Dot(800);
    }
  }
  
  void update(){
    if(allDead()){
      calcFitness(); //<>//
      naturalSelection();
      mutate();
      //System.out.println(bestDot.getBrain().getStep());
      
      System.out.println(maxStep);
    }
    
    int counter = 0;
    
    for(int i = 0; i < pop.length; i++){
      if(pop[i].isAlive()){
        avgX += pop[i].pos.x;
        avgY += pop[i].pos.y;
        counter+=1;
      }
      pop[i].update();
      pop[i].show();
    }
    avgX = avgX/counter;
    avgY = avgY/counter;
    //System.out.println("X: "+avgX+" Y: "+avgY);
  }
  
  void mutate(){
    for(int i = 0; i < pop.length; i++){
      pop[i].getBrain().mutate();
    }
  }
  
  void calcFitness(){ //<>//
    for(int i = 0; i < pop.length; i++){
      pop[i].calcFitness();
      
      //find best dot by fitness
      if(pop[i].getFitness() > bestDot.getFitness()){
        bestDot = pop[i];
        if(bestDot.reachedGoal){
          maxStep = bestDot.getBrain().getStep();
        }
      }
    }
  }
  
  void naturalSelection(){
    //select parent based on fitness
    //get baby from them
    Dot[] newDots = new Dot[popSize]; //<>//
    newDots[0] = bestDot.getBaby();
    
    for(int i=0; i<popSize; i++){
      Dot parent = selectParent();
      newDots[i] = parent.getBaby();
      if(maxStep>0){
        newDots[i].getBrain().setMaxStep(maxStep);
      }
      
      //System.out.println(bestDot.getBrain().getMaxStep());
    }
    
    pop = newDots;
    generation++;
  }
  
  Dot selectParent(){
    //get best dot and make it parent of new dots
    float rand = random(calculateFitnessSum());
    float runningSum = 0;

    for(int i = 0; i < popSize; i++){
      runningSum += pop[i].getFitness();
      if(runningSum > rand){  
        return pop[i];
      }
    }
    return null;
  }
  
  float calculateFitnessSum(){
    float sum = 0;
    for(int i = 0; i < popSize; i++){
      pop[i].calcFitness();
      sum += pop[i].getFitness();
    }
    return sum;
  }
  
  boolean allDead(){
    for(int i = 0; i<pop.length;i++){
      if(pop[i].isAlive()){
        return false;
      }
    }
    return true;
  }
  
  Dot getBestDot(){
    return bestDot;
  }
}
