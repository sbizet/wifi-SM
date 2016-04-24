import g4p_controls.*;
import java.awt.Font;
import gifAnimation.*;
import org.jsoup.*;
import processing.serial.*;
import static javax.swing.JOptionPane.*;
Serial myPort;
PrintWriter log;

PImage[] animation;
Gif loopingGif;

GTextArea zoneAff;
GTextArea zoneChoix;
GButton btnSave;

String [] urlsRss;

String [][] rssTD;
String [] motsCle = {""};
String texteAff = " \n\n";

long to = 0;
long tRaff;

int tRaffMin = 3000;
int tRaffMax = 15000;
long tLoadRss = 60*60*1000;
int tElectrocution = 1000;

boolean maj = true;

color bg = color(241, 242, 234);

int etat;
boolean on = false;
long tEtatXbee;

void setup() {
  fullScreen();
  background(bg);

  affichageInit();
  
  log = createWriter("log.txt"); 
  
  urlsRss = loadStrings("urlsRss.txt");

  tRaff = int(random(tRaffMin, tRaffMax));

  connexionXbee();
}

void draw() {
  if (maj == true) {
    majRss(urlsRss);
    rssTD = getTitlesDescriptions(urlsRss, motsCle);
    afficheRss(rssTD, motsCle);
    myPort.write("+++");
    to = millis();
    etat = 0;
    on = false;
    maj = false;
  } else {
    PImage bandeau = loadImage("bandeau.jpg");
    image(bandeau, 0, 0);
  }
  if (millis()%tLoadRss < 2000) {
    maj = true;
    fill(bg);
    rect(0, 0, width, 85);
    fill(0);
    text("Loading 4500 RSS feeds, please wait ...", 20, 20);
  }
  image(loopingGif, 20, 500);
  if ((millis()-to)>tRaff) {
    litElectrocuteAfficheXML();
    to = millis();
    tRaff = int(random(tRaffMin, tRaffMax));
  }
  majXbee();
}


void handleButtonEvents(GButton button, GEvent event) { 
  if (event == GEvent.CLICKED) {
    if (button == btnSave) {
      motsCle = splitTokens(zoneChoix.getText());
      log.print(millis()/1000 + " s :  ");
      log.println("nouveaux mots clés --- ");
      texteAff = " \n\n";
      litElectrocuteAfficheXML();
    }
  }
}

void litElectrocuteAfficheXML() {
  rssTD = getTitlesDescriptions(urlsRss, motsCle);
  log.print(millis()/1000 + " s :  ");
  log.println(rssTD[0].length + " titres trouvés");
  if (rssTD[0].length>0 && etat==3) {
    tEtatXbee = millis();
    myPort.clear();
    myPort.write("+++");
    etat = 0;
    on = true;
  }
  afficheRss(rssTD, motsCle);
}

void handleTextEvents(GEditableTextControl textarea, GEvent event) {
  if (textarea == zoneAff) {
    if (event == GEvent.CHANGED) {
    }
  }
}

String html2text(String html) {
  return Jsoup.parse(html).text();
}

void keyPressed() {
  if (key==ESC) {
    key=0;
    log.flush();
    log.close();
    exit();
  }
}