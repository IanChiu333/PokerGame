class Hand {
  Card[] handCards = new Card[2];
  float x;
  float y;
  int value = 0;
  int money = 5000;
  Card[] allCards = new Card[7];
  public Hand() {
    x = 0;
    y = 0;
  }
  public Hand(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public void showHandCard() {
    for (int i=0; i<2; i++) {
      handCards[i].goTo(x+(i*73), y);
      handCards[i].drawCard();
    }
  }
  public void showHiddenCards() {
    image(backImage, this.x, this.y);
    image(backImage, this.x+73, this.y);
  }
  public void showAllCards() {
    for (int i=0; i < 7; i++) {
      allCards[i].goTo((i*73), 500);
      allCards[i].drawCard();
    }
  }
  public void pickupCards(Card card1, Card card2) {
    handCards[0] = card1;
    handCards[1] = card2;
  }
  public void sortCard() {
    for (int j=0; j < 6; j++) {
      for (int i=0; i < 6-j; i++) {
        if (allCards[i].value > allCards[i+1].value) {
          Card temp = allCards[i];
          allCards[i] = allCards[i+1];
          allCards[i+1] = temp;
        }
      }
    }
  }
  public boolean checkPair() {
    boolean doub = false;
    for (int i=0; i < 6; i++) {
      if (allCards[i].number == allCards[i+1].number) {
        value = 100 + allCards[i+1].value;
        doub = true;
      }
    }
    if (doub == true) {
      return(true);
    } else {
      return(false);
    }
  }
  public boolean checkTwoPairs() {
    int counter = 0;
    for (int i=0; i < 6; i++) {
      if (allCards[i].number == allCards[i+1].number) {
        value = 1000 + allCards[i+1].value;
        counter++;
      }
    }
    if (counter >= 2) {
      return(true);
    } else {
      return(false);
    }
  }
  public boolean checkThreeOfAKind() {
    boolean trip = false;
    for (int i=0; i < 5; i++) {
      if (allCards[i].number == allCards[i+1].number && allCards[i].number == allCards[i+2].number) {
        value = 10000 + allCards[i+1].value;
        trip = true;
      }
    }
    if (trip == true) {
      return(true);
    } else {
      return(false);
    }
  }
  public boolean checkStraight() {
    boolean straight = false;
    for (int i=0; i < 3; i++) {
      if (allCards[i].number + 1 == allCards[i+1].number && allCards[i].number + 2 == allCards[i+2].number && allCards[i].number + 3 == allCards[i+3].number && allCards[i].number + 4 == allCards[i+4].number) {
        value = allCards[i+4].value;
        straight = true;
      }
    }
    if (straight == true) {
      value += 100000;
      return(true);
    } else {
      return(false);
    }
  }
  public boolean checkFlush() {
    boolean flush = false;
    for (int i=0; i < 3; i++) {
      if (allCards[i].suit == allCards[i+1].suit && allCards[i].suit == allCards[i+2].suit && allCards[i].suit == allCards[i+3].suit && allCards[i].suit == allCards[i+4].suit) {
        value = allCards[i+4].value;
        flush = true;
      }
    }
    if (flush == true) {
      value += 1000000;
      return(true);
    } else {
      return(false);
    }
  }
  public boolean checkFullHouse() {
    boolean tri = false;
    boolean dou = false;
    Card[] temp = new Card[3];
    temp[0] = new Card();
    temp[1] = new Card();
    temp[2] = new Card();
    for (int i=0; i < 5; i++) {
      if (allCards[i].number == allCards[i+1].number && allCards[i].number == allCards[i+2].number) {
        tri = true;
        temp[0] = allCards[i];
        temp[1] = allCards[i+1];
        temp[2] = allCards[i+2];
      }
    }
    for (int i=0; i < 6; i++) {
      if (allCards[i].number != temp[0].number && allCards[i].number == allCards[i+1].number) {
        dou = true;
      }
    }
    if (tri == true && dou == true) {
      value = 10000000 + temp[2].value;
      return(true);
    } else {
      return(false);
    }
  }
  public boolean checkFourOfAKind() {
    boolean four = false;
    for (int i=0; i < 3; i++) {
      if (allCards[i].number == allCards[i+1].number && allCards[i].number == allCards[i+2].number && allCards[i].number == allCards[i+3].number) {
        value = 100000000 + allCards[i+1].value;
        four = true;
      }
    }
    if (four == true) {
      return(true);
    } else {
      return(false);
    }
  }
  public boolean straightFlush() {
    boolean strflush = false;
    for (int i=0; i < 3; i++) {
      if (allCards[i].suit == allCards[i+1].suit && allCards[i].suit == allCards[i+2].suit && allCards[i].suit == allCards[i+3].suit && allCards[i].suit == allCards[i+4].suit && allCards[i].number + 1 == allCards[i+1].number && allCards[i].number + 2 == allCards[i+2].number && allCards[i].number + 3 == allCards[i+3].number && allCards[i].number + 4 == allCards[i+4].number) {
        value = allCards[i+4].value;
        strflush = true;
      }
    }
    if (strflush == true) {
      value += 1000000000;
      return(true);
    } else {
      return(false);
    }
  }
  public int handValue() {
    value = 0;
    Card[] temp = gameTable.getCards();
    for (int i=0; i < 5; i++) {
      allCards[i] = temp[i];
    }
    allCards[5] = handCards[0];
    allCards[6] = handCards[1];
    sortCard();
    if (straightFlush() == true) {
      println("Straight Flush");
      return(value);
    } else if (checkFourOfAKind() == true) {
      println("Four of a Kind");
      return(value);
    } else if (checkFullHouse() == true) {
      println("Fullhouse");
      return(value);
    } else if (checkFlush() == true) {
      println("Flush");
      return(value);
    } else if (checkStraight() == true) {
      println("Straight");
      return(value);
    } else if (checkThreeOfAKind() == true) {
      println("Three of a Kind");
      return(value);
    } else if (checkTwoPairs() == true) {
      println("Two Pairs");
      return(value);
    } else if (checkPair() == true) {
      println("Pair");
      return(value);
    } else {
      value = allCards[6].value;
      return(value);
    }
  }
}
