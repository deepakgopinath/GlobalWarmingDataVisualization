//All the xml parsing code goes in here. 

void loadCarbonDioxideData()
{
    XML xml = loadXML("EN.ATM.CO2E.PC_Indicator_en.xml");
    XML [] children =  xml.getChildren("data/record");
    
    for(int i=0; i<children.length; i++){ //For each record, get the subtree at field. 
       XML [] fieldArray = children[i].getChildren("field");
       currentCountry = fieldArray[0].getString("key");
       if(!previousCountry.equals(currentCountry)){
         previousCountry = currentCountry;
         countryCounter = countryCounter+1; // go to new row in the 2d array containing the carbondioxide data;
       }   
       
     if(!(trim(fieldArray[3].getContent()).equals(""))){
       dataCO2PerCapita[countryCounter][Integer.parseInt(fieldArray[2].getContent()) - 1960] = Float.parseFloat(fieldArray[3].getContent());
     }else{
       dataCO2PerCapita[countryCounter][Integer.parseInt(fieldArray[2].getContent()) - 1960] = 0;
     }
  }
}

void loadLatLongData()
{
  String lines[] = loadStrings("CLists.txt");
  XML xml = loadXML("Countries.xml");
  XML [] childrenArray = xml.getChildren("wb:country");
  
  for(int j=0; j<lines.length; j++)
  {
    for(int i=0; i<childrenArray.length; i++)
    {
      if(childrenArray[i].getString("id").equals(lines[j]))
      {
        XML [] subchildrenArrayLati = childrenArray[i].getChildren("wb:latitude");
        XML [] subchildrenArrayLongi = childrenArray[i].getChildren("wb:longitude");
        
        if(!trim(subchildrenArrayLati[0].getContent()).equals(""))
        {
          latLong[j][0] = Float.parseFloat(subchildrenArrayLati[0].getContent());
          latLong[j][1] = Float.parseFloat(subchildrenArrayLongi[0].getContent());
        }
       break;
      }
    }
  }
  
}


void loadNewsItems()
{
  String [] lines = loadStrings("news.txt");
  
  for(int i=0; i<lines.length; i++)
  {
    String [] chunks = split(lines[i], ';');
    ArrayList chunkList = new ArrayList();
    for (int j=0; j<chunks.length; j++)
    {
      chunkList.add(chunks[j]);
    }
    yearlyNewsList.add(chunkList);
    
  }
}

void loadCO2TotalData()
{
  String [] lines = loadStrings("CLists.txt");
  XML xml = loadXML("en.atm.co2e.kt_Indicator_en_xml_v2.xml");
  XML [] children = xml.getChildren("data/record");
  
  for(int j =0 ; j<lines.length; j++)
  {
    for(int i=0; i<children.length; i++)
    {
      XML [] fieldArray = children[i].getChildren("field");
     // println("country code is " + fieldArray[0].getString("key"));
      if(fieldArray[0].getString("key").equals(lines[j]))
      {
        if(!trim(fieldArray[3].getContent()).equals(""))
        {
          dataCO2Total[j][Integer.parseInt(fieldArray[2].getContent()) - 1960] = Float.parseFloat(fieldArray[3].getContent());
        }else
        {
          dataCO2Total[j][Integer.parseInt(fieldArray[2].getContent()) - 1960] = 0;
        }
      }
    }
  } 
}

void loadCountryData()
{
  String lines[] = loadStrings("CLists.txt");
  XML xml = loadXML("Countries.xml");
  XML [] childrenArray = xml.getChildren("wb:country");
  
  for (int j=0; j<lines.length; j++)
  {
    for(int i=0; i<childrenArray.length; i++)
    {
      if(childrenArray[i].getString("id").equals(lines[j]))
      {
        XML [] subChildren = childrenArray[i].getChildren("wb:name");
        if(!trim(subChildren[0].getContent()).equals(""))
        {
          String [] chunks = split(trim(subChildren[0].getContent().toLowerCase()),',');
          countryList.add(chunks[0]);
        }
      }
    }
  }
}

