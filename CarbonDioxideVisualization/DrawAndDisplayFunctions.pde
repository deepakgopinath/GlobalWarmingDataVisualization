void displayFirstPage()
{
    fill(255,25, 0);
    textAlign(CENTER);
    textSize(38);
    text("CarbOn DiOxIDE EMissION VisuALiZaTion", width/2 , height/2 - 100);
    textSize(22);
    text("CrEAted bY", width/2, height/2 - 40);
    textSize(28);
    text("DeEpaK goPiNatH", width/2, height/2 + 15 );
    textSize(20);
    fill(255,255,0);
    text("Hit Space to Continue", width/2, height/2 + 170);
}

void displaySecondPage()
{
    fill(255, 25, 0);
    textAlign(CENTER);
    textSize(30);
    text("Navigation", width/2, height/2 - 150);
    textSize(18);
    
    text("Use the mouse to rotate the globe", width/2, height/2 - 40);
    text("Use up and down arrows to control the zoom level", width/2, height/2 + 20);
    text("Use left and right arrows to select the year", width/2, height/2 + 80);
    
    fill(255,255,0);
    textSize(20);
    text("Hit Space to Continue", width/2, height/2 + 170);
    textAlign(LEFT);
    textSize(18);
}

void displayData()
{
    
  for(int i=0; i<countryList.size(); i++)
  {
    String eachItem = (String)countryList.get(i);
    if(eachItem.equals(trim(savedText.toLowerCase())))
    {
     // println("The data is " + dataCO2PerCapita[i][yearSelected - 1960]);
      if(CO2PerCapita ==  1 && CO2TotalSelect == 0)
      {
        if(dataCO2PerCapita[i][yearSelected - 1960] != 0)
        {
          currentCountryData = str(dataCO2PerCapita[i][yearSelected - 1960]);
        }else{  
        currentCountryData = "Not Available";
        }
      }else if (CO2PerCapita ==  0  && CO2TotalSelect == 1)
      {
        if(dataCO2Total[i][yearSelected - 1960] != 0)
        {
           currentCountryData = str(dataCO2Total[i][yearSelected - 1960]);
        }else{
        currentCountryData = "Not Available";
        }
      }
      break;
    }
  }
}



void readNews()
{
    fill(255);
    if(readStatus == 0){
    ArrayList eachYearItemList = (ArrayList)yearlyNewsList.get(yearSelected - 1960);
    readStatus = 1;
    selectNewsItemForCurrentYear = (int)random(eachYearItemList.size());
    if(selectNewsItemForCurrentYear > 0){
    eachNewsItem = (String)eachYearItemList.get(selectNewsItemForCurrentYear);
    lengthOfString = eachNewsItem.length();
   }else {
     eachNewsItem = "  ";
     lengthOfString = eachNewsItem.length();
   }
  }
  
  text(eachNewsItem.substring(index,lengthOfString), 220, 60);
   if(frameCount%3 == 0)
    {   
      index += (int)(40/frameRate);
      if(index >= lengthOfString - 1){
        index = 0;
        readStatus = 0;
        
      }
    }
}

void drawSelectorButtons()
{
  fill(0);
  stroke(0,255,0);
  strokeWeight(2);
  rect(1000, 200, 20,20); 
  rect(1000, 240, 20, 20);
  rect(1000, 280, 20, 20);
  rect(1000, 320, 20, 20);
  rect(790, 530, 230, 30); 
  rect(790, 600, 230, 30);

  
  fill(255,0,0);
  text("Per Capita Emissions", 810, 215);
  text("Total Emissions", 810, 255);
  text("Burning Planet", 810,295);
  text("The Dark Future", 810, 335);
  text("Country Search", 650, 550);
  text(savedText, 795, 550);
  text("Current Data", 670, 620);
  text(currentCountryData, 795, 620);
  

  if (CO2PerCapita == 1 && CO2TotalSelect == 0)
  {
    text("X", 1005, 215);
    text(" ", 1005, 255);
  }
  if (CO2PerCapita == 0 && CO2TotalSelect == 1)
  {
    text(" ", 1005, 215);
    text("X", 1005, 255);
  }
  if(smokeMode == 1)
  {
    text("X", 1005, 295);
  }else if(smokeMode == 0);
  {
    text(" ", 1005, 295);
  }
  if( darkFuture == 1)
  {
    text("X", 1005, 335);
    
  }else if(darkFuture == 0)
  {
    text(" ", 1005, 335);
  }
  stroke(255);
  
}




