class Icon_DragDrop
{
  int bx;
  int by;
  int w = 30;
  int h = 30;
  boolean hover = false;
  boolean locked = false;
  int difx = 0; 
  int dify = 0; 
  String img;
  PImage a;
  int Icon_class;
  String time = "morning";
  float flow_percent;
  String building_name = null;
  String building_cur = null;
  String building_pre = null;
  
  //constructor
  Icon_DragDrop(String img_name, int x, int y,int wi, int hi)
  {
    img = img_name;
    w = wi;
    h = hi;
    bx = x;
    by = y;
    class_decide();
    
  }
  
  //load he image to drop at the beginning
  void load()
  {
    //a = loadImage("data/Button.jpg");
    a = loadImage(img);
    
  }
  
  //the image is controlled by the bx, by parameters
  void update()
  {
    
    if (mouseX > bx - w/2 && mouseX < bx + w/2 && mouseY > by - h/2 && mouseY < by + h/2) 
    {
      hover = true;  
    } 
    else 
    {
      hover = false;
    }
    imageMode(CENTER);
    image(a, bx, by, w, h);
  }
  void mousePressed() 
  {
    if(hover) 
    { 
      locked = true; 
    //copy the image after hold the mouse
    }
    else 
    {
      locked = false;
    }
    difx = mouseX - bx; 
    dify = mouseY - by; 
  }

  void mouseDragged() 
  {
    if(locked) 
    {
    //update the new position of the image everytime user drag it
      bx = mouseX - difx; 
      by = mouseY - dify; 
    
    }
  }

  void mouseReleased() 
  {
    locked = false;
    building_decide();
    addToBuilding ();
    //System.out.println(building_name);
  }
  
  void class_decide()
  {
    if(time == "morning")
    {
      if(img == "restaurant.png")
      {
        Icon_class = 2;
      }
      else if(img == "resident.png" || img == "transit.png")
      {
        Icon_class = 3;
      }
      else if(img == "office.png" || img == "school.png")
      {
        Icon_class = 1;
      }
      
    }
    else if(time == "mid_afternoon")
    {
      if(img == "restaurant.png")
      {
      Icon_class = 2;
      }
      else if(img == "resident.png" || img == "transit.png" )
      {
      Icon_class = 3;
      }
      else if(img == "office.png" || img == "school.png" )
      {
      Icon_class = 2;
      }
      else if(img == "recreation.png")
      {
      //the icon is inactive at this time
      Icon_class = 2;
      }
      
      
    }
    
    
  }
  
  
  void building_decide()
  {
    //icon is within specific building
    for (Map.Entry GNWMapEntry : GNWMap.entrySet()) 
    {
      Building building = (Building) GNWMapEntry.getValue();
      if(building.p.contains(bx,by))
      {
        building_name = building.buildingName;
        break;
      }
      else
      {
        building_name = null;
      }
    }
    
    
  }
 
  
  void addToBuilding()
  {
    building_cur = building_name;
    if(building_cur != building_pre)
    {
      for (Map.Entry GNWMapEntry : GNWMap.entrySet()) 
      {
        Building building = (Building) GNWMapEntry.getValue();
        if(building.buildingName == building_pre)
        {
          building.iconDrags.remove(this);
        }
        else if(building.buildingName == building_cur)
        {
           building.iconDrags.add(this);
        }
        
      }
      building_pre = building_cur;
    }
    
  }
  
  
  
  
  
}