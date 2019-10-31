PImage conqueror;
float stampX;
float stampY;
int stampSize;
float stampAlpha;

color colour;
color pColour;

color black = 0;
color red = #FF0000;
color pink = #FF00DE;
color purple = #9800FF;
color blue = #002CFF;
color turquoise = #00FFCE;
color green = #29FF00;
color yellow = #FFE600;
color orange = #FF9100;

color canvas = 244;
color palette = #E0D7CC;
color sliderLine = #BCAE9E;
color slider = #675D51;

int strokeSliderTop;
int strokeSliderBot;
int strokeSliderX;
float strokeSliderY;
boolean strokeSliderDown;
int alphaSliderTop;
int alphaSliderBot;
int alphaSliderX;
float alphaSliderY;
float sliderRadius;
boolean alphaSliderDown;

int colourLeft;
int colourWidth;
int colourHeight;
int colourRight;

int paletteLeft;

int slButtonLeft;
int slButtonWidth;
int slButtonHeight;
int slButtonRight;

String mousePos = "";
String mouseTarget = "";
String sliderTarget = "";

float alpha;
float thickness;

boolean stamping = false;
boolean stampDown;

boolean penDown = false;

void setup()
{
  size(800, 600);
  background(canvas);
  frameRate(120);

  conqueror = loadImage("conqueror.png");
  
  colour = black;
  colourLeft = width - 80;
  colourWidth = 70;
  colourHeight = 40;
  colourRight = colourLeft + colourWidth;
  strokeSliderTop = 20;
  strokeSliderBot = 190;
  strokeSliderX = width - 115;
  strokeSliderY = lerp(strokeSliderTop, strokeSliderBot, 0.5);
  strokeSliderDown = false;
  alphaSliderTop = 270;
  alphaSliderBot = 440;
  alphaSliderX = width - 115;
  alphaSliderY = alphaSliderTop;
  alphaSliderDown = false;
  sliderRadius = 20;
  paletteLeft = width - 150;
  slButtonLeft = width - 140;
  slButtonWidth = 50;
  slButtonHeight = 25;
  slButtonRight = slButtonLeft + slButtonWidth;
}

void draw()
{  
  if((keyPressed && key == 'c') || (mousePressed && mouseButton == RIGHT && mousePos == "canvas"))
  {
    clear();
  }
  
  mousePos = "";
  mouseTarget = "";
  stampDown = false;
  penDown = false;
  
  alpha = map(alphaSliderY, alphaSliderBot, alphaSliderTop, 0, 255);
  thickness = map(strokeSliderY, strokeSliderBot, strokeSliderTop, 4, 24);

  mousePos();
  customMousePressed();

  noStroke(); //palette
  fill(palette);
  rect(paletteLeft, 0, 150, height);
  
  highlight(mouseTarget);
  colourButtons();
  slButtons();
  
  stroke(colour, alpha); //current colour
  strokeWeight(thickness);
  noFill();
  ellipse(colourLeft - 35, 230, 30, 30);

  stamp();

  sliders();
}

void mouseReleased()
{
  strokeSliderDown = false;
  alphaSliderDown = false;

  if(mouseButton == LEFT)
  {
    colourPressed();
    slButtonsPressed();
  }
  
  if(mouseX > stampX && mouseX < stampX + stampSize && mouseY > stampY && mouseY < stampY + stampSize) //select stamp
  {
    stamping = true;
  }
}

void mousePos() //determines where the mouse is hovering
{
  if (mouseX >= colourLeft && mouseX <= colourRight && !strokeSliderDown && !alphaSliderDown)
  {
    if (mouseY > 10 && mouseY < 50)
    {
      mousePos = "black";
      mouseTarget = "colour";
    }
    else if (mouseY > 60 && mouseY < 100)
    {
      mousePos = "red";
      mouseTarget = "colour";
    }
    else if (mouseY > 110 && mouseY < 150)
    {
      mousePos = "pink";
      mouseTarget = "colour";
    }
    else if (mouseY > 160 && mouseY < 200)
    {
      mousePos = "purple";
      mouseTarget = "colour";
    }
    else if (mouseY > 210 && mouseY < 250)
    {
      mousePos = "blue";
      mouseTarget = "colour";
    }
    else if (mouseY > 260 && mouseY < 300)
    {
      mousePos = "turquoise";
      mouseTarget = "colour";
    }
    else if (mouseY > 310 && mouseY < 350)
    {
      mousePos = "green";
      mouseTarget = "colour";
    }
    else if (mouseY > 360 && mouseY < 400)
    {
      mousePos = "yellow";
      mouseTarget = "colour";
    }
    else if (mouseY > 410 && mouseY < 450)
    {
      mousePos = "orange";
      mouseTarget = "colour";
    }
    else if (dist(colourLeft + colourWidth / 2, 490, mouseX, mouseY) < 55 / 2)
    {
      mousePos = "canvas";
      mouseTarget = "colour";
    }
  }
  else if(mouseX > stampX && mouseX < stampX + stampSize && mouseY > stampY && mouseY < stampY + stampSize)
  {
    mousePos = "stamp";
  }
  else if(mouseX > slButtonLeft && mouseX < slButtonRight)
  {
    if(mouseY > 460 && mouseY < 460 + slButtonHeight)
    {
      mousePos = "save";
      mouseTarget = "slButton";
    }
    else if(mouseY > 495 && mouseY < 495 + slButtonHeight)
    {
      mousePos = "load";
      mouseTarget = "slButton";
    }
  }
}

void highlight(String target) //overload
{
  highlight(target, "");
}

void highlight(String target, String slider) //highlights buttons
{
  if(target == "colour")
  {
    stroke(#FEFF03, 100);
    strokeWeight(10);
    noFill();

    if(mousePos == "black")
    {
      rect(colourLeft, 10, colourWidth, colourHeight);
    }
    else if(mousePos == "red")
    {
      rect(colourLeft, 60, colourWidth, colourHeight);
    }
    else if(mousePos == "pink")
    {
      rect(colourLeft, 110, colourWidth, colourHeight);
    }
    else if(mousePos == "purple")
    {
      rect(colourLeft, 160, colourWidth, colourHeight);
    }
    else if(mousePos == "blue")
    {
      rect(colourLeft, 210, colourWidth, colourHeight);
    }
    else if(mousePos == "turquoise")
    {
      rect(colourLeft, 260, colourWidth, colourHeight);
    }
    else if(mousePos == "green")
    {
      rect(colourLeft, 310, colourWidth, colourHeight);
    }
    else if(mousePos == "yellow")
    {
      rect(colourLeft, 360, colourWidth, colourHeight);
    }
    else if(mousePos == "orange")
    {
      rect(colourLeft, 410, colourWidth, colourHeight);
    }
    else if(mousePos == "canvas")
    {
      ellipse(colourLeft + colourWidth / 2, 490, 55, 55);
    }
  }
  else if(target == "slider")
  {
    stroke(#FEFF03, 100);
    strokeWeight(8);
    noFill();
    
    if(slider == "alpha")
    {
      ellipse(alphaSliderX, alphaSliderY, sliderRadius, sliderRadius);
    }
    else if(slider == "stroke")
    {
      ellipse(strokeSliderX, strokeSliderY, sliderRadius, sliderRadius);
    }
  }
  else if(target == "slButton")
  {
    stroke(#FEFF03, 100);
    strokeWeight(8);
    noFill();
    
    if(mousePos == "save")
    {
      rect(slButtonLeft, 460, slButtonWidth, slButtonHeight);
    }
    else if(mousePos == "load")
    {
      rect(slButtonLeft, 495, slButtonWidth, slButtonHeight);
    }
  }
}

void colourButtons() //draws colour buttons
{
  noStroke();
  
  fill(black);
  rect(colourLeft, 10, colourWidth, colourHeight);
  fill(red);
  rect(colourLeft, 60, colourWidth, colourHeight);
  fill(pink);
  rect(colourLeft, 110, colourWidth, colourHeight);
  fill(purple); 
  rect(colourLeft, 160, colourWidth, colourHeight);
  fill(blue);
  rect(colourLeft, 210, colourWidth, colourHeight);
  fill(turquoise);
  rect(colourLeft, 260, colourWidth, colourHeight);
  fill(green);
  rect(colourLeft, 310, colourWidth, colourHeight);
  fill(yellow);
  rect(colourLeft, 360, colourWidth, colourHeight);
  fill(orange);
  rect(colourLeft, 410, colourWidth, colourHeight);
  fill(canvas);
  ellipse(colourLeft + colourWidth / 2, 490, 55, 55);
}

void colourPressed() //makes colour buttons functional
{
  if(mousePos == "black")
  {
    colour = black;
    stamping = false;
  }
  else if(mousePos == "red")
  {
    colour = red;
    stamping = false;
  }
  else if(mousePos == "pink")
  {
    colour = pink;
    stamping = false;
  }
  else if(mousePos == "purple")
  {
    colour = purple;
    stamping = false;
  }
  else if(mousePos == "blue")
  {
    colour = blue;
    stamping = false;
  }
  else if(mousePos == "turquoise")
  {
    colour = turquoise;
    stamping = false;
  }
  else if(mousePos == "green")
  {
    colour = green;
    stamping = false;
  }
  else if(mousePos == "yellow")
  {
    colour = yellow;
    stamping = false;
  }
  else if(mousePos == "orange")
  {
    colour = orange;
    stamping = false;
  }
  else if(mousePos == "canvas")
  {
    colour = canvas;
    stamping = false;
  }
}

void slButtons()
{
  textSize(18);
  fill(sliderLine);
  rect(slButtonLeft, 460, slButtonWidth, slButtonHeight);
  rect(slButtonLeft, 495, slButtonWidth, slButtonHeight);
  fill(slider);
  text("save", slButtonLeft + 5.5, 460 + slButtonHeight * 0.66);
  text("load", slButtonLeft + 6.5, 496.5 + slButtonHeight * 0.66);
}

void slButtonsPressed()
{
  if(mousePos == "save")
  {
    selectOutput("Save your drawing...", "save");
  }
  else if(mousePos == "load")
  {
    selectInput("Load an image...", "load");
  }
}

void save(File i)
{
  if(i != null)
  {
    PImage canvas = get(0, 0, paletteLeft, height);
    canvas.save(i.getAbsolutePath());
  }
}

void load(File i)
{
  if(i != null)
  {
    PImage image = loadImage(i.getAbsolutePath());
    image(image, 0, 0);
  }
}

void sliders() //draws sliders
{
  stroke(sliderLine); //draws stroke slider line
  strokeWeight(6);
  line(strokeSliderX, strokeSliderTop, strokeSliderX, strokeSliderBot);

  if((dist(strokeSliderX, strokeSliderY, mouseX, mouseY) < sliderRadius / 2 || strokeSliderDown) && !alphaSliderDown)
  {
    highlight("slider", "stroke");
  }
  
  noStroke(); //draws stroke slider
  fill(slider);
  ellipse(strokeSliderX, strokeSliderY, sliderRadius, sliderRadius);
  
  stroke(sliderLine); //draws alpha slider line
  strokeWeight(6);
  line(alphaSliderX, alphaSliderTop, alphaSliderX, alphaSliderBot);
  
  if((dist(alphaSliderX, alphaSliderY, mouseX, mouseY) < sliderRadius / 2 || alphaSliderDown) && !strokeSliderDown)
  {
    highlight("slider", "alpha");
  }
  
  noStroke(); //draws alpha slider
  fill(slider);
  ellipse(alphaSliderX, alphaSliderY, sliderRadius, sliderRadius);
}

void stamp() //draws stamp
{
  noStroke();
  fill(palette);
  rect(0, 0, 100, 100);
  stampX = 10.5 - map(strokeSliderY, strokeSliderBot, strokeSliderTop, -16, 16);
  stampY = 10 - map(strokeSliderY, strokeSliderBot, strokeSliderTop, -12, 12);
  stampSize = Math.round(map(strokeSliderY, strokeSliderBot, strokeSliderTop, 40, 110));
  stampAlpha = map(alphaSliderY, alphaSliderBot, alphaSliderTop, 0, 255);
  if(mousePos == "stamp" && !strokeSliderDown && !alphaSliderDown && !stampDown && !penDown)
  {
    tint(200, stampAlpha);
  }
  else
  {
    tint(255, stampAlpha);
  }
  image(conqueror, stampX, stampY, stampSize, stampSize);
}

void customMousePressed() //on mouse click
{
  if ((mousePressed && mouseButton == LEFT) && !strokeSliderDown && !alphaSliderDown) //draw lines/stamps
  {
    if(stamping)
    {
      stampDown = true;
      
      if(frameCount % 3 == 0)
      {
        image(conqueror, mouseX - stampSize / 2, mouseY - stampSize / 2, stampSize, stampSize);
      }
    }
    else
    {
      stroke(colour, alpha);
      strokeWeight(thickness);
      line(pmouseX, pmouseY, mouseX, mouseY);
      
      penDown = true;
    }
  }

  if (mousePressed && mouseX > strokeSliderX - sliderRadius / 2 && mouseX < strokeSliderX + sliderRadius / 2 && mouseY > strokeSliderTop && mouseY < strokeSliderBot && !alphaSliderDown) //adjust stroke slider
  {
    strokeSliderDown = true;
    mouseTarget = "slider";
    sliderTarget = "alpha";
  }
  if (strokeSliderDown)
  {
    if (mouseY >= strokeSliderTop && mouseY <= strokeSliderBot)
    {
      strokeSliderY = mouseY;
    }
  }
  
  if (mousePressed && mouseX > alphaSliderX - sliderRadius / 2 && mouseX < alphaSliderX + sliderRadius / 2 && mouseY > alphaSliderTop && mouseY < alphaSliderBot && !strokeSliderDown) //adjust alpha slider
  {
    alphaSliderDown = true;
    mouseTarget = "slider";
    sliderTarget = "stroke";
  }
  if (alphaSliderDown)
  {
    if (mouseY >= alphaSliderTop && mouseY <= alphaSliderBot)
    {
      alphaSliderY = mouseY;
    }
  }
}

void clear()
{
  background(canvas);
}
