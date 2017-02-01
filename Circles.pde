ArrayList<Circle> circles = new ArrayList<Circle>();

int noNewCircle = 0;
PImage img;
String currentImageFile;
boolean imageFinished;
ArrayList<String> inputFiles = new ArrayList<String>();

int imageIndex = 0;
color bg = color(0);

void setup()
{
  size(2560, 1440);
  noFill();
  strokeWeight(1);

  // Put the image files in here. All must of size 2560 x 1440 or larger
  inputFiles.add("s7.jpg");
  inputFiles.add("ship1.jpg");

  loadCurrentImage();
}

void loadCurrentImage()
{
  currentImageFile = inputFiles.get(imageIndex);
  circles.clear();

  if (imageIndex==0)
    bg = color(0);
  else
    bg = color(0);

  background(bg);
  
  
  img = loadImage(currentImageFile);
  //image(img, 0, 0);
  img.loadPixels();
  noNewCircle = 0; 
  imageFinished = false;
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {    
    return null;
  }
}

void keyPressed()
{
  if (key=='r' || key =='R')
    saveImage();

  if (key=='n'|| key == 'N')
  {
    moveNext();
  }

  if (key=='p'|| key == 'P')
  { 
    imageIndex--;
    loadCurrentImage();
  }
}

void moveNext()
{
  saveImage();

  imageIndex++;
  if (imageIndex >= inputFiles.size())
  {
    noLoop();
    exit();
  }

  loadCurrentImage();
}

void movePrevious()
{
  saveImage();

  imageIndex--;
  if (imageIndex < 0 )
    imageIndex = inputFiles.size() -1;

  loadCurrentImage();
}

void saveImage()
{
  String fileName = nf(year(), 2) + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2) + ".png";
  save("output\\" + currentImageFile + "_" + fileName);
}

void draw()
{  
  boolean stillRoom = false;

  for (int i=0; i< 30; i++)
  {
    Circle nc = NewCircle();
    if (nc != null)
    {
      circles.add(nc);
      stillRoom = true;
    }
  }

  for (Circle c : circles)
  {    
    c.check();
    if (!c.done) 
    {
      c.grow();    
      c.show();
    }
  }

  if (!stillRoom) noNewCircle++; 
  else noNewCircle--;

  if (noNewCircle > 15)
  {    
    imageFinished = true;       
    moveNext();
  }
}

Circle NewCircle()
{
  float x = random(0, width);
  float y = random(0, height);

  boolean insideCircle = false;
  for (Circle c : circles)
  {
    float d = dist(x, y, c.x, c.y) ;
    if (d < (c.r + 2))
    {
      insideCircle = true;
      break;
    }
  }

  if (!insideCircle)
  {
    return new Circle(x, y);
  } else
  {
    return null;
  }
}