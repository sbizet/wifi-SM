void afficheRss(String[][] rssTD, String[] motsCle) {
  int nL = 0;
  String newText = "";
  if (rssTD[0].length>0) {
    int index = int(random(0, rssTD[0].length-0.5));
    newText = newText + "---- " + rssTD[2][index] + " ----\n";
    newText = newText + rssTD[0][index] + " :     ";
    String description = rssTD[1][index];
    if (description != null) {
      
      newText = newText + description+"\n\n";
    } else {
      newText = newText + "\n\n";
    }
  }
  texteAff = newText + texteAff;
  zoneAff.clearStyles();
  if (texteAff.length()>2000) {
    texteAff = texteAff.substring(0, 2000);
  }
  try {
    if (texteAff.length()>1) {
      zoneAff.setText(texteAff, width-270-40);
    }
  }
  catch(NullPointerException e) {
    zoneAff.setText("??", width-270-40);
  }

  while (true) {
    String textLigne = zoneAff.getText(nL).toLowerCase();
    for (int k=0; k<motsCle.length; k++) {
      if (motsCle[k] != "") {
        String motCle = motsCle[k];
        int indexCle = textLigne.indexOf(motCle.toLowerCase());
        if (indexCle > -1) {
          zoneAff.addStyle(G4P.BACKGROUND, color(255, 0, 0), nL, indexCle, indexCle+motCle.length());
          zoneAff.addStyle(G4P.FOREGROUND, color(255), nL, indexCle, indexCle+motCle.length());
        }
      }
    }
    if (textLigne.indexOf(" :     ")>-1) {
      try {
        zoneAff.addStyle(G4P.WEIGHT, G4P.WEIGHT_BOLD, nL, 0, textLigne.indexOf(" :     "));
        zoneAff.addStyle(G4P.SIZE, 30, nL, 0, textLigne.indexOf(" :     "));
      }
      catch(NullPointerException e) {
        log.println(e + " --- " + textLigne + " ; t = " + millis()/1000 + " s."); 
      }
    }
     if (textLigne.indexOf("---- ")>-1) {
      try {
        zoneAff.addStyle(G4P.WEIGHT, G4P.WEIGHT_BOLD, nL);
        zoneAff.addStyle(G4P.POSTURE, G4P.POSTURE_OBLIQUE, nL);
      }
      catch(NullPointerException e) {
        log.println(e + " --- " + textLigne + " ; t = " + millis()/1000 + " s."); 
      }
    }
    if (textLigne.equals("")) break;
    nL++;
  }
}