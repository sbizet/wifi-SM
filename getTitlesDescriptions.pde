String [][] getTitlesDescriptions(String[] urlsRss, String [] motsCle) {
  int nRss = 0;
  String [][] tab = new String [3][5000];
  for (int iRss = 0; iRss<urlsRss.length; iRss++) {
    if (random(0, 5)<1) {
      XML rss = loadXML("rssXML/rss"+nf(iRss,2,0)+".xml");
      XML [] itemXML = rss.getChildren("channel/item");
      for (int j = 0; j < itemXML.length; j++) {
        String [] children = itemXML[j].listChildren();
        for (int c = 0; c < children.length; c++) {
          if (children[c].equals("title")) {
            tab[0][nRss] = html2text(itemXML[j].getChildren("title")[0].getContent());
          }
          if (children[c].equals("description")) {
            tab[1][nRss] = html2text(itemXML[j].getChildren("description")[0].getContent());
            int lMax = 280;
            if (tab[1][nRss].length()>lMax){
              tab[1][nRss] = tab[1][nRss].substring(0,lMax) + " ... ";
            }
          }
        }
        XML channelTitleXML = rss.getChild("channel/title");
        tab[2][nRss] = html2text(channelTitleXML.getContent());
        nRss++;
      }
    }
  }
  String [][] tabCle = new String [3][nRss*motsCle.length];
  int nRssCle = 0;
  for (int i = 0; i<nRss; i++) {
    for (int k = 0; k<motsCle.length; k++) {
      if (tab[1][i] == null) {
        if (tab[0][i].toLowerCase().indexOf(motsCle[k].toLowerCase())>=0 && motsCle[k] !="") {
          tabCle[0][nRssCle] = tab[0][i];
          tabCle[1][nRssCle] = null;
          tabCle[2][nRssCle] = tab[2][i];
          nRssCle++;
        }
      } else {
        if ((tab[0][i].toLowerCase().indexOf(motsCle[k].toLowerCase())>=0 && motsCle[k] !="") || (tab[1][i].toLowerCase().indexOf(motsCle[k].toLowerCase())>=0 && motsCle[k] !="")) {
          tabCle[0][nRssCle] = tab[0][i];
          tabCle[1][nRssCle] = tab[1][i];
          tabCle[2][nRssCle] = tab[2][i];
          nRssCle++;
        }
      }
    }
  }
  String[][] retour = new String [3][nRssCle];
  for (int i = 0; i<nRssCle; i++) {
    retour[0][i] = tabCle[0][nRssCle-i-1];
    retour[1][i] = tabCle[1][nRssCle-i-1];
    retour[2][i] = tabCle[2][nRssCle-i-1];
  }
  /*
  for (int i = 0; i < retour[0].length; i++) {
   println(i + " : " + retour[0][i] + " " + retour[1][i]);
   }
   */
  return retour;
}