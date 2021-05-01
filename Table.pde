class GameTable {
  public int currentBet = 0;
  public int pot = 0;
  Card[] tableCards = new Card[5];
  public GameTable() {
    for (int i = 0; i < 5; i++) {
      tableCards[i] = new Card();
    }
  }
  public void placeCards1(Card card1, Card card2, Card card3) {
    tableCards[0] = card1;
    tableCards[1] = card2;
    tableCards[2] = card3;
  }
  public void placeCards2(Card card4) {
    tableCards[3] = card4;
  }
  public void placeCards3(Card card5) {
    tableCards[4] = card5;
  }
  public void showTableCard() {
    for (int i=0; i<5; i++) {
      if (tableCards[i] != null) {
        tableCards[i].goTo(225 + i*73, 400);
        tableCards[i].drawCard();
      }
    }
  }
  public void resetTable() {
    tableCards = new Card[5];
  }
  public Card[] getCards() {
    return(tableCards);
  }
}
