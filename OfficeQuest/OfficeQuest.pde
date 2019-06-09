import gifAnimation.*;
import ddf.minim.*;

boolean isUse;
boolean isExamine;
boolean isPickUp;
boolean win;
boolean movingUp;
boolean movingDown;
boolean movingLeft;
boolean movingRight;
boolean faceLeft;
boolean faceRight;
boolean isMoving;
boolean examineA;
boolean pickupA;
boolean useA;
boolean dcheck;
boolean fanPickUp;
boolean fanUse;
boolean ratOut;
boolean ratPickUp;
boolean ratUse;
//item uses
boolean magnetPickUp;
boolean magnetUse;
boolean paperclipPickUp;
boolean paperclipUse;
float playerPosX;
float playerPosY;
PImage room;
Gif character;
Gif still;
Gif moving;
Gif stillR;
Gif movingR;
Gif pickup;
Gif use;
Gif examine;
Gif talking;
Gif pickupR;
Gif useR;
Gif examineR;
Gif talkingR;
Gif pizza;
Gif pizzaNormal;
Gif pizzaStank;
Gif pizzaE;
Gif noPizza;
PImage fanNP;
PImage fanP;
PImage ratNP;
PImage ratP;
PImage rat;
PImage paperclip;
PImage paperclipNP;
PImage paperclipP;
PImage magnet;
PImage magnetNP;
PImage magnetP;
PImage fan;
PImage trash;
PImage desk;
PImage mousehole;
PImage mouseholeE;
PImage mouseholeS;
PImage door;
PImage chair;
PImage window;
Minim minim;
AudioPlayer song;

void setup()
{
  size(500,400);
  background(0);
  isUse = false;
  isExamine = false;
  isPickUp = false;
  isMoving = false;
  magnetUse = false;
  movingLeft = false;
  movingUp = false;
  movingDown = false;
  movingRight = false;
  faceLeft = true;
  faceRight = false;
  examineA = false;
  useA = false;
  pickupA = false;
  dcheck = false;
  win = false;
  ratOut = false;
  ratUse = false;
  fanUse = false;
  fanPickUp = false;
  magnetPickUp = false;
  still = new Gif(this, "STILL.gif");
  moving = new Gif(this, "WALK.gif");
  stillR = new Gif(this, "STILLR.gif");
  movingR = new Gif(this, "WALKR.gif");
  pickup = new Gif(this, "PICKUP.gif");
  use = new Gif(this, "USE.gif");
  examine = new Gif(this, "EXAMINE.gif");
  talking = new Gif(this, "TALK.gif");
  pickupR = new Gif(this, "PICKUPR.gif");
  useR = new Gif(this, "USER.gif");
  examineR = new Gif(this, "EXAMINER.gif");
  talkingR = new Gif(this, "TALKR.gif");
  pizzaNormal = new Gif(this, "Pizza.gif");
  pizzaE = new Gif(this, "PIZZAEMPTY.gif");
  pizza = pizzaNormal;
  trash = loadImage("TRASH.gif");
  fanNP = loadImage("Fan0.png");
  fanP = loadImage("Fan1.png");
  chair = loadImage("CHAIR.gif");
  fan = fanNP;
  character = still;
  playerPosX = 300;
  playerPosY = 150;
  //basic room
  room = loadImage("BASIC ROOM.gif");
  desk = loadImage("DESK.gif");
  ratNP = loadImage("rat.png");
  ratP = loadImage("rat1.png");
  rat = ratNP;
  magnetNP = loadImage("Magnet1.png");
  magnetP = loadImage("Magnet0.png");
  magnet = magnetNP;
  mouseholeE = loadImage("mousehole0.png");
  mouseholeS = loadImage("mousehole1.png");
  mousehole = mouseholeE;
  paperclipNP = loadImage("paperclip1.png");;
  paperclipP = loadImage("paperclip0.png");;
  paperclip = paperclipNP;
  door = loadImage("Door.gif");
  window = loadImage("WINDOW.gif");
  minim = new Minim(this);
  song = minim.loadFile("winsfx.mp3");
  println("OFFICE QUEST");
  println("U - use E - examine P - pickup");
  println("You are Joe, a simple office worker who works in a nondescript office building. Your coworkers have locked you inside the office as a juvenile office prank and now it is up to you and your wits to get out so you can go home.");
}

void draw() 
{
  checkMovement();
  if (isMoving)
  {
    if(faceLeft)
    {
      character = moving;
      character.loop();
    }
  if(faceRight)
    {
      character = movingR;
      character.loop();
    }
    if(movingLeft&&playerPosX>30)
    {
      playerPosX-=1;
    }
    if(movingRight&&playerPosX<350)
    {
      playerPosX+=1;
    }
    if(movingUp&&playerPosY>100)
    {
      playerPosY-=1;
    }
    if(movingDown&&playerPosY<150)
    {
      playerPosY+=1;
    }
  }
  else
  {
    if(faceLeft)
    {
      character = still;
    }
  if(faceRight)
    {
      character = stillR;
    }
  }
  clear();
  checkCommand();
  itemInteraction();
  if(examineA)
  {
    if(faceLeft)
    {
      character = examine;
    }
    if(faceRight)
    {
      character = examineR;
    }
    character.play();
    examineA = false;
  }
  if(pickupA)
  {
    if(faceLeft)
    {
      character = pickup;
    }
    if(faceRight)
    {
      character = pickupR;
    }
    character.play();
    pickupA = false;
  }
  if(useA)
  {
    if(faceLeft)
    {
      character = use;
    }
    if(faceRight)
    {
      character = useR;
    }
    character.play();
    useA = false;
  }
  image(room,0,0);
  image(mousehole,250,160,mousehole.width*0.5,mousehole.height*0.5);
  image(window,150,50,window.width*1.5,window.height*1.5);
  image(door,12,50,door.width*0.8,door.height*0.8);
  image(desk,310,112,desk.width*0.55,desk.height*0.55);
  image(chair,420,200,chair.width*0.6,chair.height*0.6);
  image(character, playerPosX, playerPosY,character.width,character.height);
  image(trash,0,270,trash.height*1.7,trash.width*1.7);
  image(pizza,50,250,pizza.width*0.8,pizza.height*0.8);
  image(fan,10,325,fan.width,fan.height);
  image(magnet,160,330,magnet.width*1.2,magnet.height*1.2);
  image(rat,70,310,rat.width,rat.height);
  image(paperclip,250,315,paperclip.width,paperclip.height);
  if(win)
  {
    println("YOU DID IT!");
    song.play();
    win = false;
  }
}

void checkMovement()
{
  if(keyPressed==true&&key==CODED)
 {
   isMoving = true;
   if (keyCode == UP) 
   {
      movingUp = true;
   } 
   else if (keyCode == DOWN) 
   {
     movingDown = true;
   }
   else if (keyCode == LEFT) 
   {
     movingLeft = true;
     faceRight = false;
     faceLeft = true;
   }
   else if (keyCode == RIGHT) 
   {
     movingRight = true;
     faceRight = true;
     faceLeft = false;
   }
   else
   {
    movingUp = false;
    movingDown = false;
    movingRight = false;
    movingLeft = false;
   }
 }
 if (keyPressed == false)
  {
    isMoving=false;
    movingUp = false;
    movingDown = false;
    movingRight = false;
    movingLeft = false;
  }
}

void checkCommand()
{
  if (keyPressed) {
    if (key == 'u' || key == 'U')
    {
      isUse = true;
      isExamine = false;
      isPickUp = false;
    }
    if (key == 'p' || key == 'P')
    {
      isUse = false;
      isExamine = false;
      isPickUp = true;
    }
    if (key == 'e' || key == 'E')
    {
      isUse = false;
      isExamine = true;
      isPickUp = false;
    }
  }
}

void itemInteraction()
{
  if(mousePressed)
  {
    //window
    if(mouseX>150 && mouseX<(150+1.5*window.width)&&mouseY>50 && mouseY<(50+1.5*window.height))
    {
      if(isUse){
        dcheck=tooFar(150,50);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          println("Suicide is never the answer");
          isUse = false;
        }
      }
      if(isExamine)
      {
        dcheck=tooFar(150,50);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          println("Man, if this office wasn't so high up I would have totally used this window to make my daring escape.");
          isExamine = false;
        }
      }
      if(isPickUp)
      {
        dcheck=tooFar(150,50);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          println("It's attached to the wall. I can't just tear it out.");
          isPickUp = false;
        }
      }   
    }
    //door
    if(mouseX>12 && mouseX<(12+door.width*0.8)&&mouseY>50 && mouseY<(50+door.height*0.8))
    {
      if(paperclipUse)
      {
        dcheck=tooFar(12,50);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          println("That's it! I used the paperclip as a lock pick and managed to unlock the door. I am truly the master of unlocking things! I'm free!");
          win = true;
        }
        paperclipUse = false;
      }
      else
      {
        if(isUse){
          dcheck=tooFar(12,50);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("I would love to, but it's locked.");
            isUse = false;
          }
        }
        if(isExamine)
        {
          dcheck=tooFar(12,50);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("Why must you mock me so, locked door?");
            isExamine = false;
          }
        }
        if(isPickUp)
        {
          dcheck=tooFar(12,50);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("I can't pick up the door! I'm not that strong, or desperate.");
            isPickUp = false;
          }
        }
      }
    }
    //chair
    if(mouseX>420 && mouseX<(420+0.6*chair.width)&&mouseY>200 && mouseY<(200+0.6*chair.height))
    {
      if(ratUse)
      {
        dcheck=tooFar(420,200);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          println("Well, I spun the rat aroud until it threw up the magnet. Gross, but a man's gotta do what a man's gotta do.");
          magnetPickUp = true;
          magnet = magnetP;
        }
        ratUse = false;
      }
      else
      {
        if(isUse){
          dcheck=tooFar(420,200);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("WHEEEEEEE!!!");
            isUse = false;
          }
        }
        if(isExamine)
        {
          dcheck=tooFar(420,200);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("It's my spinning chair. It spins, it's a chair and it's mine.");
            isExamine = false;
          }
        }
        if(isPickUp)
        {
          dcheck=tooFar(420,200);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("I doubt the chair would fit in my pocket");
            isPickUp = false;
          }
        }
      }
    }
    //mousehole
    if(mouseX>250 && mouseX<(250+0.5*mousehole.width)&&mouseY>160 && mouseY<(160+0.5*mousehole.height))
    {
      if(isUse){
        dcheck=tooFar(250,160);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          if(ratOut)
          {
            println("That fat rat is in the way of the hole");
          }
          else
          {
            println("I mean, it's in the wall. I don't think there's any way I could use it.");
          }
          isUse = false;
        }
      }
      if(isExamine)
      {
        dcheck=tooFar(250,160);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          if(ratOut)
          {
            println("Haha, all that pizza's made him unable to go back into the hole. I can kinda relate actually.");
          }
          else
          {
            println("That's a mouse hole. I think there's a rat in there. I don't really care so much as long as it doesn't bother me.");
          }
          isExamine = false;
        }
      }
      if(isPickUp)
      {
        dcheck=tooFar(250,160);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          if(ratOut)
          {
            println("Well, I gotta get that magnet dude. Say hello to your new home Mr. Rat.");
            ratOut = false;
            rat = ratP;
            mousehole = mouseholeE;
            ratPickUp = true;
          }
          else
          {
            println("I don't want to put my hand in there. I wouldn't trust my hand with a rat I don't know.");
          }
          isPickUp = false;
        }
      }   
    }
    //fan
    if(mouseX>10 && mouseX<(10+fan.width)&&mouseY>325 && mouseY<(325+fan.height))
    {
      if(fanPickUp)
      {
        fanUse=true;
      }
    }
    //rat
    if(mouseX>70 && mouseX<(70+rat.width)&&mouseY>310 && mouseY<(310+rat.height))
    {
      if(ratPickUp)
      {
        ratUse=true;
      }
    }
    //Magnet
    if(mouseX>160 && mouseX<(160+magnet.width)&&mouseY>330 && mouseY<(330+magnet.height))
    {
      if(magnetPickUp)
      {
        magnetUse=true;
      }
    }
    //paperclip
    if(mouseX>250 && mouseX<(250+paperclip.width)&&mouseY>315 && mouseY<(315+paperclip.height))
    {
      if(paperclipPickUp)
      {
        paperclipUse=true;
      }
    }
    //desk
    if(mouseX>310 && mouseX<(310+0.55*desk.width)&&mouseY>112 && mouseY<(112+0.55*desk.height))
    {
      if(isUse){
        dcheck=tooFar(310,112);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          println("I guess I could try to use the desk as a battering ram through the door. Nah, it's too heavy.");
          isUse = false;
        }
      }
      if(isExamine)
      {
        dcheck=tooFar(310,112);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          println("It's my desk. I do work stuff on it. Oh hey, there's one of those novelty pocket fans in the drawer. I could use this.");
          pickupA = true;
          fanPickUp = true;
          fan = fanP;
          isExamine = false;
        }
      }
      if(isPickUp)
      {
        dcheck=tooFar(310,112);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          examineA = true;
          println("I'm not going to pick that up because I'm not an animal.");
          isPickUp = false;
        }
      }   
    }
    //pizza
    if(mouseX>50 && mouseX<(50+0.8*pizza.width)&&mouseY>250 && mouseY<(250+0.8*pizza.height))
    {
      if(fanUse)
      {
        dcheck=tooFar(50,250);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          println("The rat from that mouse hole came out and ate the whole thing! Wait, the magnet is gone! The rat must have swallowed it!");
          ratOut = true;
          pizza = pizzaE;
          mousehole = mouseholeS;
        }
        fanUse = false;
      }
      else
      {
        if(isUse){
          dcheck=tooFar(50,250);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("That stuff's gross dude");
            isUse = false;
          }
        }
        if(isExamine)
        {
          dcheck=tooFar(50,250);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("It's really really old pizza. There's a complimentary magnet in that box but uh, I think it's stuck to the cheese.");
            isExamine = false;
          }
        }
        if(isPickUp)
        {
          dcheck=tooFar(50,250);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("I'm not gonna put that in my pocket.");
            isPickUp = false;
          }
        }
      }
    }
    //trash
    if(mouseX>0 && mouseX<(1.7*trash.width)&&mouseY>270 && mouseY<(270+1.7*trash.height))
    {
      if(magnetUse){
        dcheck=tooFar(0,270);
        if(dcheck)
        {
          dcheck = false;
        }
        else
        {
          println("Wow, this magnet's really strong. I was able to get that paperclip without even touching the trash.");
          paperclipPickUp = true;
          paperclip = paperclipP;
        }
        magnetUse = false;
      }
      else
      {
        if(isUse){dcheck=tooFar(0,270);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("How would I use that?");
            isUse = false;
          }
        }
        if(isExamine)
        {
          dcheck=tooFar(0,270);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("Sometimes if you look into the abyss it looks back, same for the trash. Oh hey! There's a paper clip in there!");
            isExamine = false;
          }
        }
        if(isPickUp)
        {
          dcheck=tooFar(0,270);
          if(dcheck)
          {
            dcheck = false;
          }
          else
          {
            examineA = true;
            println("I am not sticking my hand in there.");
            isPickUp = false;
          }
        }
      }
    }
  }
}

boolean tooFar(float i, float j)
{
  float distance = sqrt(pow((i-playerPosX),2)+pow((j-playerPosY),2));
  if(distance < 150)
  {
    return false;
  }
  else
  {
    if(faceRight)
    {
      character = talkingR;
    }
    if(faceLeft)
    {
      character = talking;
    }
    println("It's too far away");
    isUse = false;
    isExamine = false;
    isPickUp = false;
    return true;
  }
}
