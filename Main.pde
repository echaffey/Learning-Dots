Colony colony;
public PVector goal;
public PFont f;

void setup(){
  f = createFont("Arial", 18, true);
}

void settings(){
  size(600,600);

  colony = new Colony(2000);
  goal = new PVector(width/2,15);
}

void draw(){
  background(255);
  
  fill(color(0,255,0));
  ellipse(goal.x,goal.y,15,15);
  
  fill(color(255,0,255));
  //bottom
  rect(0,3*height/5,width-160,10);
  //top
  rect(160,height/3,width-80,10);
  
  textFont(f, 18);
  fill(0);
  text("Gen: "+colony.generation, width-100, 35);
  text("MR: "+colony.pop[0].getBrain().mutationRate,width-100,55);
  
  stroke(color(255,0,0));
  line(colony.avgX,0,colony.avgX,height);
  line(0,colony.avgY,width,colony.avgY);
  
  stroke(0);
  colony.update();
  
  //System.out.println(colony.getBestDot().getFitness());
  

}
