void keyPressed() // up and down arrows to control the zooming in and out.
{
  if(key == ' ')
  {
    startFlag += 1;
  }
  if(key != CODED)
  { // Keeping track of text entry. Backspace clears the string character by character. Enter retreives the data and displays it the data box. 
    switch(key)
    {
      case BACKSPACE :
        enteredCurrentText = enteredCurrentText.substring(0, max(0,enteredCurrentText.length()-1));
        savedText = enteredCurrentText;
        currentCountryData = ""; //Clear the data display field
        break;
      case ENTER:
      case RETURN:
        savedText = enteredCurrentText;
        displayData();
        break;
       default:
         enteredCurrentText += key;
         savedText = enteredCurrentText;
         currentCountryData = "";
         break;
        
    }
  }else if(key == CODED){
    if(keyCode == UP){
      zoomFactor = zoomFactor - 0.01;
      if(zoomFactor <= 0.7){
        zoomFactor = 0.7;
      }
        
    } else if(keyCode == DOWN){
     zoomFactor = zoomFactor + 0.01;
      if(zoomFactor >= 2.5){
        zoomFactor = 2.5;
      }
    }else if(keyCode == RIGHT){
      switchMode = 1;
      yearSelected = yearSelected + 1; 
      if(yearSelected >= 2009){
        yearSelected = 2009;
      }
      displayData();
    }else if(keyCode == LEFT){
      switchMode = 1;
      yearSelected = yearSelected - 1; 
      if(yearSelected <= 1960){
        yearSelected = 1960;
      }
      displayData();
    }
  }
    
}

void mouseReleased()
{
  //To see if the mouse was clicked in the selector boxes.
  
  if((mouseX >= 1000 && mouseX <= 1020) && (mouseY > 200 && mouseY < 220))
  {
    CO2PerCapita = 1; // Setting flags for which data set to access
    CO2TotalSelect = 0;
    displayData();
  }else if((mouseX >= 1000 && mouseX <= 1020) && (mouseY > 240 && mouseY < 260))
  {
    CO2PerCapita = 0;
    CO2TotalSelect = 1;
    displayData();
  }else if((mouseX >= 1000 && mouseX <= 1020) && (mouseY > 280 && mouseY < 300))
  {
    if(smokeMode == 0)
    {
      smokeMode = 1;
    }
    else
    {
      smokeMode = 0;
    }
  }else if((mouseX >= 1000 && mouseX <= 1020) && (mouseY > 320 && mouseY < 340))
  {
    if(darkFuture == 0)
    {
      darkFuture = 1;
    }
    else
    {
      darkFuture = 0;
    }
  }
}
