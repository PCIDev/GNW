class BuildingUse
{
  String name;
  String imgSrc;
  color colorId;
  boolean cust;
  
  
  //TODO this should be a hashmap to store all the locations depending on time of the day
  String matchBUse;
  /*
  BuildingUse(String name, String imgSrc, color colorId, String matchBUse)
  {
    this.name = name;
    this.imgSrc = imgSrc;
    this.colorId = colorId;
    this.matchBUse = matchBUse;
  } 
  */
  BuildingUse(String name, String imgSrc, color colorId, boolean cust)
  {
    this.name = name;
    this.imgSrc = imgSrc;
    this.colorId = colorId;
    this.cust = cust;
  } 
  
}