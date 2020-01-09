class BackpackDNA implements Comparable<BackpackDNA> {
  ArrayList<Item> contents = new ArrayList<Item>();
  int id;
  int gen;
  float weight;
  float price;
  
  BackpackDNA(int id, int gen, ArrayList<Item> target, boolean shuffle){
    this.id = id;
    this.gen = gen;
    copy(target);
    calculateStats();
    if(shuffle){
      shuffle();
    }
    
  
  }
  
   //This makes it so that the Backpack is comparable by its price
  public int compareTo(BackpackDNA other){
    return (int) Math.signum(this.price - other.price);
  }
  
  
  void copy(ArrayList<Item> target){
    for(int i = 0; i<target.size(); i++){
      contents.add(new Item(target.get(i).name, target.get(i).weight, target.get(i).price));
    }
    calculateStats();
  }
  
  
  void shuffle(){
    for(int i = 0; i<contents.size(); i++){
      if(random(0,1) > 0.5){
        contents.get(i).active = true;
      }
      else{
        contents.get(i).active = false;
      }
    }
    calculateStats();
  }
  
  void calculateStats(){
    //Calculates the total weight and price of the backpack
    weight = 0;
    price = 0;
    for(int i = 0; i<contents.size(); i++){
      if(contents.get(i).active){
        weight = weight+contents.get(i).weight;
        price = price+contents.get(i).price;
      }
    }  
  }
  
  void printBP(){
    println("ID:"+id);
    println("Weight Sum:" +weight);
    println("Price Sum:" +price);
    println(" ");
  }
  
  
  void printItems(){
    ArrayList<Item> array = contents;
    println("ID:" +id);
    println("Weight Sum:" + weight);
    println("Price Sum" + price);
  for(int i = 0; i < array.size(); i++){
    print("N: "+array.get(i).getName()+" ");
    print("W: "+array.get(i).getWeight()+" ");
    print("P: "+array.get(i).getPrice()+" ");
    print("F: "+array.get(i).getFitness());
    println("");
  }
}
  
  
  
  
  
}
