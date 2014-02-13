  void printCO2()
{
   for(int i=0; i<noOfCountries; i++)
   {
 
    for(int j=0; j<noOfYears; j++)
    {
      print(dataCO2PerCapita[i][j] + " ");
    }
    println("\n");
  }
}

void printLatLong()
{

 for(int i=0; i<noOfCountries; i++)
 {
   print(i + " ");
    for(int j=0; j<2; j++)
    {
      print(latLong[i][j] + " ");
    }
    println("\n");
  }
}

void printCountryData()
{
  for(int i=0; i<countryList.size(); i++)
  {
    String eachItem = (String)countryList.get(i);
    println(eachItem);
  }
}
