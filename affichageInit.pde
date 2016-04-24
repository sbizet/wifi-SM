void affichageInit(){
  loopingGif = new Gif(this, "ani.gif");
  loopingGif.loop();
  fill(0);
  textSize(18);
  text("Enter your keywords.", 20, 125);
  text("The P2P (Pain-to-Pain™)", 20, 550);
  text("technology of WIFI SM", 20, 570);
  text("scans in real time the", 20, 590);
  text("latest world news.", 20, 610);
  text("More than 4500 titles", 20, 650);
  text("from RSS feeds", 20, 670);
  
  zoneAff = new GTextArea(this, 270, 130, width-270-20, height-130-20, G4P.SCROLLBARS_NONE | G4P.SCROLLBARS_AUTOHIDE);
  zoneAff.setFont(new Font("", Font.PLAIN, 22));
  zoneAff.setTextEditEnabled(false);
  zoneAff.setLocalColor(2, color(0));
  zoneAff.setLocalColor(6, bg);
  zoneAff.setLocalColor(7, bg);
  zoneChoix = new GTextArea(this, 20, 130, 220, 300, G4P.SCROLLBARS_NONE);
  zoneChoix.setFont(new Font("", Font.PLAIN, 16));
  zoneChoix.setText(motsCle, 150);
  btnSave = new GButton(this, 20, 430, 150, 50, "SAVE");
  btnSave.setFont(new Font("", Font.PLAIN, 22));
  text("Loading 4500 RSS feeds, please wait ...", 10, 20);
}