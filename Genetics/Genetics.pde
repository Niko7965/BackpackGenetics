//Imports a library used later for sorting
import java.util.Collections;

ArrayList<Item> allItems = new ArrayList<Item>();
ArrayList<ArrayList<BackpackDNA>> Generations = new ArrayList<ArrayList<BackpackDNA>>();

int genSize = 100;
int mutationPercentage = 50;
float decimatePercentage = 0.98;
void setup(){
  
  //Reads a csv file containing the items, and generates the first generation
  read();
  whileGen(genSize);
  
  
  
}

void draw(){
  //Iterates every draw step
  iterateGen(Generations.get(Generations.size()-1));
  
}

void iterateGen(ArrayList<BackpackDNA> previousGen){
  //Creates a new gen based on the previous gen
  printGenStats(previousGen);

  
  //Sorts the previous generation, and removes all but the strongest percentile
  Collections.sort(previousGen);
  decimate(previousGen, decimatePercentage);

  //Creates an ArrayList for the new generation
  ArrayList<BackpackDNA> newGen = new ArrayList<BackpackDNA>();
  
  
  //Iterates through the previous generation, and zipmerges backpacks in pairs.
  for(int i = 0; i<floor(previousGen.size()/2);i++){
   newGen.add(zipMerge(previousGen.get(i*2),previousGen.get((i*2)+1)));
   }
  //Kills backpacks that are too large
  kill(newGen);
  
  //Keeps mating until the generation is big enough, killing the degenerates in the process
  while(newGen.size()<genSize){
    for(int i = 0; i<floor(previousGen.size()/2);i++){
   newGen.add(zipMerge(previousGen.get(i*2),previousGen.get((i*2)+1)));
   }
   kill(newGen);
  }
  
  
  //This last part, adds the generation to the list of generations 
  
  ArrayList<BackpackDNA> temp = new ArrayList<BackpackDNA>();
  
  for(int i = 0; i<genSize; i++){
    temp.add(newGen.get(i));
  }
  newGen.clear();
  for(int i = 0; i<genSize; i++){
    newGen.add(temp.get(i));
  }
  Generations.add(newGen);
  Collections.sort(newGen);
  println("//Generation:"+ (Generations.size()-1)+ "//");
  printGenStats(newGen);
  
  
   
}

void whileGen(int amount){
  generate(amount);
  kill(Generations.get(0));
  while(Generations.get(0).size() < amount){
    int amountToGen = amount - Generations.get(0).size();
    
    for(int i = 0; i<amountToGen; i++){
      Generations.get(0).add(new BackpackDNA(Generations.get(0).size(),0,allItems,true));
    }
    
    kill(Generations.get(0));
    //println(Generations.get(0).size());
    
  }
  
}

void generate(int amount){
  //Adds a certain amount of random backpacks to a generation
   ArrayList<BackpackDNA> gen0 = new ArrayList<BackpackDNA>();
  Generations.clear();
  for(int i = 0; i<amount; i++){
    gen0.add(new BackpackDNA(gen0.size(),0,allItems,true));
  }
  
  Generations.add(gen0);
}

void printGenStats(ArrayList<BackpackDNA> target){
  float totalPrice = 0;
  float totalWeight = 0;
  for(int i = 0; i<target.size(); i++){
    totalPrice = totalPrice + target.get(i).price;
    totalWeight = totalWeight +target.get(i).weight;
  }
  println("//Gen Size: "+target.size()+"//");
  println("//Avg price: "+totalPrice/target.size()+"//");
  println("//Avg weight: "+totalWeight/target.size()+"//");
  println("/////////////////////");
  

}

void decimate(ArrayList<BackpackDNA> target, float percentage){
  Collections.sort(target);
  float killAmount = round(target.size() * percentage);
  ArrayList<BackpackDNA> newGen = new ArrayList<BackpackDNA>();
  for(int i = 0; i<(target.size()-killAmount); i++){
    newGen.add(target.get(i));
  }
 
  target.clear();
  for(int i = 0; i<(newGen.size());i++){
    target.add(newGen.get(i));
  }
 
  
  
}

void kill(ArrayList<BackpackDNA> target){
  ArrayList<BackpackDNA> newgen = new ArrayList<BackpackDNA>();
  for(int i = 0; i<target.size(); i++){
    if(target.get(i).weight <= 5000){
      newgen.add(target.get(i));
    }
  }
  target.clear();
  for(int i = 0; i<newgen.size(); i++){
    target.add(newgen.get(i));
  }
  
}

void read(){
  // Read items from csv file
  // name, weight, value
  String[] lines = loadStrings("BPdata.csv");
  for (int i = 0; i < lines.length; i++) {
    // Split current line on comma
    String[] parts = split(lines[i], ",");

    // Add new item based on name, weight and value
    allItems.add(new Item(parts[0],float((parts[1])),float(parts[2]))); 
  }
}

BackpackDNA zipMerge(BackpackDNA parent1, BackpackDNA parent2){
  ArrayList<Item> newList = new ArrayList<Item>();
  for(int i = 0; i>parent1.contents.size(); i++){
   
    if(i%2 == 0){
      newList.add(new Item(parent1.contents.get(i).name, parent1.contents.get(i).weight, parent1.contents.get(i).price));
    }
    else{
      newList.add(new Item(parent2.contents.get(i).name, parent2.contents.get(i).weight, parent2.contents.get(i).price));
    }
    
    if(random(100)<mutationPercentage){
      if(random(1) > 0.5){
        newList.get(newList.size()).active = true;
    }
      else{
        newList.get(newList.size()).active = false;
      }       
    }
  }
  BackpackDNA newBP = new BackpackDNA(0,0,allItems,true);
  newBP.contents.clear();
  for(int i =0; i<newList.size();i++){
    newBP.contents.add(newList.get(i));
  }
  return newBP;
}



void printGen(ArrayList<BackpackDNA> target, int gen){
  println("//// Gen: "+gen+"////");
  for(int i = 0; i<target.size(); i++){
    target.get(i).printBP();
  }
}


void printItems(ArrayList<Item> array){
  for(int i = 0; i < array.size(); i++){
    print("N: "+array.get(i).getName()+" ");
    print("W: "+array.get(i).getWeight()+" ");
    print("P: "+array.get(i).getPrice()+" ");
    print("F: "+array.get(i).getFitness());
    println("");
  }
}
