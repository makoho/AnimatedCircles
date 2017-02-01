class Circle {

  float x;
  float y;
  float r;
  float s;
  color c;
  boolean innerCircle1 = true;
  boolean innerCircle2 = true;
  boolean done = false;
  float maxSize = random(8, 15);

  public Circle(float x_, float y_)
  {
    x = x_;
    y = y_;
    r = 1; 
    s = 1;
    c = img.pixels[(int)x + (int)y * width];
    
    innerCircle1 = (random(0, 10) < 5);
    innerCircle2 = (random(0, 10) < 5);
  }

  void grow()
  {
    r += s;
  }

  void check()
  {
    if (done) return;

    if (r > maxSize)    done = true;
    if (x + r > width)  done = true;
    if (x - r < 0)      done = true;
    if (y + r > height) done = true;
    if (y - r < 0)      done = true;

    if (done) return;

    for (Circle c : circles)
    {
      if (c != this)
      {
        float d = dist(x, y, c.x, c.y);
        if (d - 1 < (c.r + r) )
          done = true;
      }
    }
  }

  void show()
  {      
    // overdraw previously drawn circles with a filled circle
    fill(bg);
    noStroke();
    ellipse(x, y, r*2, r*2);

    // Draw the outer circle
    strokeWeight(1);
    fill(c, 10);
    stroke(c);
    ellipse(x, y, r * 2, r * 2);

    if (r>5 && innerCircle1)
    {
      // draw the first (larger) inner circle
      ellipse(x, y, r, r);
    } 

    if (r > 11)
    {
      // draw the second (smaller) inner circle
      ellipse(x, y, r-8, r-8);
    }
  }
}