class Item {
    String name;
    float weight;
    float price;
    float fitness;
    double normFitness;
    boolean active;

    Item(String name, float weight, float price){
        this.name = name;
        this.weight = weight;
        this.price = price;
        this.fitness = (price/weight);
        this.normFitness = (fitness/6.612);
        active = false;
        
    }
    
    String getName(){
      return name;
    }
    
    float getPrice(){
      return price;
    }
    
    float getWeight(){
      return weight;
    }
    
    float getFitness(){
      return fitness;
    }

}
