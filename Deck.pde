class Deck {
  Card[] cards = new Card[52];
  int i=-1;
  public Deck() {
    int index = 0;
    for (int j=0; j < 4; j++) {
      for (int i=0; i < 13; i++) {
        cards[index] = new Card(i+1, j, pictures[index], i*4 + j);
        index++;
      }
    }
  }
  public void printAllCards() {
    for (int i=0; i < 52; i++) {
      cards[i].printInfo();
    }
  }
  public void showAllCards() {
    int rowCounter = 0;
    int columnCounter = 0;
    for (int i=0; i < 52; i++) {
      cards[i].goTo(columnCounter*73, rowCounter*96);
      cards[i].drawCard();
      columnCounter++;
      if (columnCounter == 11) {
        columnCounter = 0;
        rowCounter++;
      }
    }
  }
  public void shuffle() {
    for (int i=0; i<52; i++) {
      Card card = cards[i];
      int j = floor(random(52));
      cards[i] = cards[j];
      cards[j] = card;
    }
  }
  public Card passCard() {
    i++;
    return(cards[i]);
  }
  public void resetDeck() {
     i = 0;
     shuffle();
  }
}
