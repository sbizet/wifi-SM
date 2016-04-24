void majRss(String[] urlsRss){
  
  for (int iRss = 0; iRss<urlsRss.length; iRss++) {
    log.print(millis()/1000 + " s :  ");
    log.println(urlsRss[iRss]);
    String [] xmlTemp = loadStrings(urlsRss[iRss]);
    String [] xmlNull = new String[1];
    xmlNull[0]="";
    if (xmlTemp != null) {
      saveStrings("data/rssXML/rss"+nf(iRss,2,0)+".xml",xmlTemp);
    }
    else{
      saveStrings("data/rss/XML/rss"+nf(iRss,2,0)+".xml",xmlNull);
    }
  }
}