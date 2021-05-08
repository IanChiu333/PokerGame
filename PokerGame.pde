PImage[] pictures = new PImage[52];
PImage backImage;
Deck deck;
Hand hand;
Hand cpu1;
Hand cpu2;
Hand cpu3;
GameTable gameTable;
Button buttonCall;
Button buttonReplay;
Button buttonFold;
Button buttonAddBet100;
Button buttonAddBet10;
boolean mouseClicked = false;
enum GameStates {
  PASSCARDS, 
    TURN1, 
    TURN2, 
    TURN3, 
    RESULTS, 
    OPTIONS
}
int stateNumber = 0;
GameStates currentState = GameStates.PASSCARDS;
void setup() {
  size(800, 800);
  String folderpath = sketchPath();
  backImage = loadImage(folderpath + "/redback.jpg");
  PImage diamonds = loadImage(folderpath + "/diamonds-cards.jpg");
  PImage clubs = loadImage(folderpath + "/clubs-cards.jpg");
  PImage hearts = loadImage(folderpath + "/hearts-cards.jpg");
  PImage spades = loadImage(folderpath + "/spades-cards.jpg");
  for (int i=0; i < 13; i++) {
    pictures[i] = diamonds.get(i*73, 0, 73, 96);
  }
  for (int i=0; i < 13; i++) {
    pictures[i+13] = clubs.get(i*73, 0, 73, 96);
  }
  for (int i=0; i < 13; i++) {
    pictures[i+26] = hearts.get(i*73, 0, 73, 96);
  }
  for (int i=0; i < 13; i++) {
    pictures[i+39] = spades.get(i*73, 0, 73, 96);
  }
  deck = new Deck();
  deck.printAllCards();
  deck.shuffle();
  hand = new Hand(304, 700);
  cpu1 = new Hand(0, 400);
  cpu2 = new Hand(330, 0);
  cpu3 = new Hand(660, 400);
  gameTable = new GameTable();
  buttonCall = new Button(600, 700, "Call");
  buttonReplay = new Button(600, 675, "Replay");
  buttonFold = new Button(600, 650, "Fold");
  buttonAddBet100 = new Button(100, 700, "+100");
  buttonAddBet10 = new Button(100, 650, "+10");
}
void draw() {
  //deck.showAllCards();
  background(100);
  switch(currentState) {
  case PASSCARDS:
    stateNumber = 0;
    gameTable.resetTable();
    deck.resetDeck();
    Card card1 = deck.passCard();
    Card card2 = deck.passCard();
    hand.pickupCards(card1, card2);
    cpu1.pickupCards(deck.passCard(), deck.passCard());
    cpu2.pickupCards(deck.passCard(), deck.passCard());
    cpu3.pickupCards(deck.passCard(), deck.passCard());
    currentState = GameStates.OPTIONS;
    gameTable.pot += 40;
    hand.money -= 10;
    cpu1.money -= 10;
    cpu2.money -= 10;
    cpu3.money -= 10;
    break;
  case TURN1:
    Card card3 = deck.passCard();
    Card card4 = deck.passCard();
    Card card5 = deck.passCard();
    gameTable.placeCards1(card3, card4, card5);
    currentState = GameStates.OPTIONS;
    gameTable.currentBet += floor(random(0, 10))*10;
    break;
  case TURN2:
    Card card6 = deck.passCard();
    gameTable.placeCards2(card6);
    currentState = GameStates.OPTIONS;
    gameTable.currentBet += floor(random(0, 10))*10;
    break;
  case TURN3:
    Card card7 = deck.passCard();
    gameTable.placeCards3(card7);
    currentState = GameStates.OPTIONS;
    gameTable.currentBet += floor(random(0, 10))*10;
    break;
  case RESULTS:
    buttonReplay.drawButton();
    if (buttonReplay.clicked()) {
      currentState = GameStates.PASSCARDS;
    }
    cpu1.showHandCard();
    cpu2.showHandCard();
    cpu3.showHandCard();
    //hand.handValue();
    //fill(255);
    //text(hand.value, 700,750);
    //hand.showAllCards();
    if (hand.money < 0) {
      noLoop();
    }
    break;
  case OPTIONS:
    text(gameTable.currentBet, 350, 550);
    text(gameTable.pot, 450, 550);
    text(hand.money, 525, 700);
    text(cpu1.money, 25, 350);
    text(cpu2.money, 400, 150);
    text(cpu3.money, 775, 350);
    buttonCall.drawButton();
    buttonFold.drawButton();
    buttonAddBet10.drawButton();
    buttonAddBet100.drawButton();
    if (buttonCall.clicked()) {
      if (stateNumber == 0) {
        currentState = GameStates.TURN1;
      } else if (stateNumber == 1) {
        currentState = GameStates.TURN2;
      } else if (stateNumber == 2) {
        currentState = GameStates.TURN3;
      } else if (stateNumber == 3) {
        int winner = determineWinner();
        if (winner == 1) {
          cpu1.money += gameTable.pot;
        } else if (winner == 2) {
          cpu2.money += gameTable.pot;
        } else if (winner == 3) {
          cpu3.money += gameTable.pot;
        } else {
          hand.money += gameTable.pot;
        }
        gameTable.pot = 0;
        currentState = GameStates.RESULTS;
      }
      stateNumber++;
      hand.money -= gameTable.currentBet;
      cpu1.money -= gameTable.currentBet;
      cpu2.money -= gameTable.currentBet;
      cpu3.money -= gameTable.currentBet;
      gameTable.pot = gameTable.pot + gameTable.currentBet * 4;
      gameTable.currentBet = 0;
    }
    if (buttonFold.clicked()) {
      currentState = GameStates.PASSCARDS;
    }
    if (buttonAddBet10.clicked()) {
      gameTable.currentBet +=10;
    }
    if (buttonAddBet100.clicked()) {
      gameTable.currentBet +=100;
    }
    cpu1.showHiddenCards();
    cpu2.showHiddenCards();
    cpu3.showHiddenCards();
    break;
  }
  hand.showHandCard();
  gameTable.showTableCard();
  mouseClicked = false;
}
void mousePressed() {
  mouseClicked = true;
}

int determineWinner() {
  if (cpu1.handValue() > cpu2.handValue() && cpu1.handValue() > hand.handValue() && cpu1.handValue() > cpu3.handValue()) {
    return(1);
  } else if (cpu2.handValue() > cpu1.handValue() && cpu2.handValue() > hand.handValue() && cpu2.handValue() > cpu3.handValue()) {
    return(2);
  } else if (cpu3.handValue() > cpu1.handValue() && cpu3.handValue() > hand.handValue() && cpu3.handValue() > cpu2.handValue()) {
    return(3);
  } else {
    return(4);
  }
}
