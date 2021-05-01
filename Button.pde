class Button {
  float x;
  float y;
  String text;
  public Button(float x, float y, String text) {
    this.x = x;
    this.y = y;
    this.text = text;
  }
  public void drawButton() {
    fill(255, 255, 255);
    rect(x, y, 100, 25);
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, x+50, y+12);
  }
  public boolean mouseOver() { 
    return(mouseX > x && mouseX < x+100 && mouseY > y && mouseY < y+25);
  }
  public boolean clicked() {
    if (mouseOver() && mouseClicked) {
      return(true);
    } 
    else {
      return(false);
    }
  }
}
