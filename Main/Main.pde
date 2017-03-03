import pathfinder.*; //<>//
import controlP5.*;

GNWPathFinder GNWPathFinder;
GNWMap GNWMap;
GNWInterface GNWInterface;

ArrayList<BuildingUse> buildingUses;

ArrayList<Building> restaurantBuildings;
ArrayList<Building> officeBuildings;
ArrayList<Building> recBuildings;
ArrayList<Building> residentBuildings;
ArrayList<Building> retailBuildings;

int shiftX;
int shiftY;

//define the time selection parameter
String cur_time = "morning";
float prevTime;
boolean timeChanged = false;

//define the UI for radio button
ControlP5 cp5;
RadioButton r1;


void setup()
{
  //fullScreen();

  size(2134, 1601);
  shiftX = 0;
  shiftY = 0;
  GNWMap = new GNWMap();
  GNWInterface = new GNWInterface();
  GNWPathFinder = new GNWPathFinder();
  buildingUses = new ArrayList<BuildingUse>();
  setBuildingUses();

  restaurantBuildings = new ArrayList<Building>();
  officeBuildings = new ArrayList<Building>();
  recBuildings = new ArrayList<Building>();
  residentBuildings = new ArrayList<Building>();
  retailBuildings = new ArrayList<Building>();

  //create the radio button interface to change the time
  cp5 = new ControlP5(this);
  r1 = cp5.addRadioButton("radioButton")
    .setPosition(100, 900)
    .setSize(100, 50)
    .setColorForeground(color(120))
    .setColorActive(color(200))
    .setColorLabel(color(0))
    .setItemsPerRow(5)
    .setSpacingColumn(70)
    .addItem("8AM", 10)
    .addItem("2PM", 14)
    ;
}

/** 
 * 
 */
void draw() {
  background(255);
 
  pushMatrix();
  translate(shiftX, shiftY);
  GNWMap.render();
  //GNWPathFinder.drawGraph();  //show node and edges for debugging purposes
  update_time();
  
   if (GNWMap.isBuildingUseAdded || timeChanged)           //whenever a new building use is added or the time is changed, calculate the flow densities for all paths
  {
    GNWMap.isBuildingUseAdded = false;
    timeChanged = false;
    GNWMap.flowInit();
  }

  GNWMap.drawFlow();
  
  popMatrix();

  //render buildingUseBoxes and SelectedBUIcon
  GNWInterface.render();
}

//update time 
void update_time()
{
  float curTimeVal = r1.getValue();
 
  if (curTimeVal == 10)
  {
    cur_time = "morning";
  } else if (curTimeVal == 14)
  {
    cur_time = "mid_afternoon";
  } else 
  {
    cur_time = null;
  }
  
  if (curTimeVal != prevTime)
  {
    timeChanged = true;
  }
  
  prevTime = curTimeVal;
}

void mousePressed()
{
  if (!isOnMap()) {
    GNWInterface.selectBuildingUse();
  }
}

void mouseDragged()
{
  //differiate between icon move and map move
  if (GNWInterface.selectedBUIcon != null) {
    GNWInterface.update();
  } else {
    shiftX = shiftX - (pmouseX - mouseX);
    shiftX = constrain(shiftX, width-GNWMap.mapImage.width, 0);
  }
} 

void mouseReleased()
{
  if (GNWInterface.selectedBUIcon != null && isOnMap()) {
    try {
      GNWMap.assignBuildingUse(GNWInterface.selectedBUIcon.buildingUse);
    } 
    catch(Exception e) {
      GNWInterface.clearSelected();
    }
  }
  //remove the icon after release the mouse
  GNWInterface.clearSelected();
}

/**
 * Checks if mouse position is on map
 * TODO: update to actual pixel. Currently assuming first half of app is map
 */
boolean isOnMap()
{
  return mouseY< height/2;
}

void setBuildingUses()
{
  buildingUses.add(new BuildingUse("Restaurant", "restaurant.png", color (200, 0, 0), "Office"));
  buildingUses.add(new BuildingUse("Office", "office.png", color (0, 0, 200), "Restaurant"));
  buildingUses.add(new BuildingUse("Recreation", "recreation.png", color(0, 200, 0), "Office"));
  buildingUses.add(new BuildingUse("Resident", "resident.png", color (200, 200, 0), "Restaurant"));
  buildingUses.add(new BuildingUse("Retail", "restaurant.png", color(200, 0, 200), "Restaurant"));

  GNWInterface.createBuildingUseBoxes();
}


//USED FOR DEBUGGING - prints x & y coordinate values of mouse click
//void mouseClicked() {
//  fill(0);
//  ellipse(mouseX, mouseY, 2, 2);
//  println("x: " + mouseX + "; y: " + mouseY);
//}