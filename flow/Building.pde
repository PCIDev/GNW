/**
* The Building class represents a physical building 
*/
class Building {    
    ArrayList<Person> persons; 
    int xpos;
    int ypos; 
    int buildingWidth;
    int buildingHeight;
    
    /**
    * The Building constructor
    * @param x This is the x-coordinate of the building
    * @param y This is the y-coordinate of the building
    * @param w This is the width of the building
    * @param h This is the height of the building
    */
    Building (int x, int y, int w, int h) {
      xpos = x;
      ypos = y;
      buildingWidth = w;
      buildingHeight = h;
      
      persons = new ArrayList<Person>();
    }
  
   /**
   * The animation for people to flow out of this building to another building
   */
   void run() {
      for (int i = persons.size()-1; i >= 0; i--) {
        Person p = persons.get(i);
        p.run();
        if (p.isDead()) {
          //persons.remove(i);
          p.position = new PVector (xpos, ypos);
          p.lifespan = 300;
        }
      }
    }
    
    /**
    * Renders a block to represent the building onto the screen
    */
    void render() {
      fill(255);
      rectMode(CENTER);
      rect(xpos, ypos, buildingWidth, buildingHeight);
    }
    
    /**
    * Adds a person to this building
    */
    void addPerson() {
      for (int i = 0; i <= 50; i = i + 10)
      {
        persons.add(new Person(xpos - i, ypos));
      }
    }  
}