void majXbee() {
  int timeOut = 500;
  if (etat == 0) { // un +++ vient d'être envoyé
    if ( myPort.available() > 2) {
      int val1 = myPort.read();         
      int val2 = myPort.read();         
      int val3 = myPort.read();   
      if (val1 == 79 && val2 == 75 && val3 == 13) {
        log.print(millis()/1000 + " s :  ");
        log.print("+++ OK   ");
        myPort.write("ATD1");
        if (on) {
          myPort.write("5");
        } else {
          myPort.write("4");
        }
        myPort.write(13);
        etat = 1;
        tEtatXbee = millis();
      }
    }
    if ((millis()-tEtatXbee) > timeOut) { // si c'est trop long à répondre, on relance le +++
      tEtatXbee = millis();
      to = millis();
      myPort.clear();
      myPort.write("+++");
      on = false;
    }
  }
  
  if (etat == 1) { // le ATD1x a été envoyé
    if ( myPort.available() > 2) {
      int val1 = myPort.read();         
      int val2 = myPort.read(); 
      int val3 = myPort.read();
      if (val1 == 79 && val2 == 75 && val3 == 13) {
        if (on) {
          log.print("ATD15 OK   ");
        } else {
          log.print("ATD14 OK   ");
        }
        myPort.write("ATCN");
        myPort.write(13);
        etat =2;
        tEtatXbee = millis();
      }
    }
    if ((millis()-tEtatXbee)> timeOut) { // si trop de temps à répondre, on (re)envoie un ATD14 pour arrêter
      tEtatXbee = millis();
      to = millis();
      myPort.clear();
      myPort.write("ATD14");
      myPort.write(13);
      on = false;
    }
  }
  
  if (etat == 2) { // le ATCN a été envoyé
    if ( myPort.available() > 2) {
      int val1 = myPort.read();         
      int val2 = myPort.read(); 
      int val3 = myPort.read();
      if (val1 == 79 && val2 == 75 && val3 == 13) {
        log.println("ATCN OK");
        etat = 3;
        tEtatXbee = millis();
      }
    }
    if ((millis()-tEtatXbee)> timeOut) { // si trop de temps à répondre, on (re)envoie un ATCN pour arrêter
      tEtatXbee = millis();
      to = millis();
      myPort.clear();
      myPort.write("ATCN");
      myPort.write(13);
      on = false;
    }
  }
  
  if (etat == 3 && on) { // a répondu à ATCN. Si c'est sur On
    if ((millis()-tEtatXbee)> tElectrocution) { // Si on atteint la fin de l'électrocution
      tEtatXbee = millis();
      myPort.clear();
      myPort.write("+++"); // on relance un +++ pour arreter l'électrocution
      etat = 0;
      on = false;
    }
  }
}