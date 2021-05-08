class Card {
  int number;
  int suit;
  int value;
  float x;
  float y;
  PImage cardImage;
  
  public Card() {
    number = 0;
    suit = 0;
    value = 0;
    x = 0;
    y = 0;
    cardImage = new PImage();
  }
  
  public Card(int number, int suit, PImage cardImage, int value) {
    this.number = number;
    this.suit = suit;
    this.cardImage = cardImage;
    this.value = value;
    x = 0;
    y = 0;
  }
  public void goTo(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public void printInfo() {
    println("Number" + number + "suit" + suit);
  }
  public void drawCard() {
    image(this.cardImage,x, y);
  }
}
