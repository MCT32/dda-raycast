int gridsize = 50;

int gridWidth, gridHeight;

boolean[][] map;

int pointX = 0;
int pointY = 0;

void setup()
{
  size(800, 600, P2D);
  
  gridWidth = ceil(float(width) / gridsize);
  gridHeight = ceil(float(height) / gridsize);
  
  map = new boolean[gridWidth][gridHeight];
}

void draw()
{
  background(0);
  
  stroke(255);
  
  for(int i = 1; i <= width/gridsize; i++)
  {
    line(i * gridsize, 0, i * gridsize, height);
  }
  
  for(int i = 1; i <= height/gridsize; i++)
  {
    line(0, i * gridsize, width, i * gridsize);
  }
  
  fill(0, 0, 255);
  
  for(int x = 0; x < gridWidth; x++)
  {
    for(int y = 0; y < gridHeight; y++)
    {
      if(map[x][y])
      {
        rect(x * gridsize, y * gridsize, gridsize, gridsize);
      }
    }
  }
  
  boolean found = false;
  
  float x = float(pointX) / gridsize;
  float y = float(pointY) / gridsize;
  
  int cellX = floor(x);
  int cellY = floor(y);
  
  PVector dir = new PVector(mouseX - pointX, mouseY - pointY);
  dir = dir.normalize();
  
  stroke(255);
  line(pointX, pointY, mouseX, mouseY);
  
  int i = 0;
  
  while(!found)
  {
    noFill();
    stroke(255, 255, 0);
    rect(cellX * gridsize, cellY * gridsize, gridsize, gridsize);
    
    float dx, dy;
    
    if(dir.x > 0)
    {
      dx = (cellX + 1) - x;
    } else {
      dx = cellX - x;
    }
    
    if(dir.y > 0)
    {
      dy = (cellY + 1) - y;
    } else {
      dy = cellY - y;
    }
    
    float step;
    if(abs(dx / dir.x) <= abs(dy / dir.y))
    {
      step = dx / dir.x;
      
      if(dx > 0)
      {
        cellX++;
      } else {
        cellX--;
      }
    } else {
      step = dy / dir.y;
      
      if(dy > 0)
      {
        cellY++;
      } else {
        cellY--;
      }
    }
    
    line(x * gridsize, y * gridsize, (x + dir.x * step) * gridsize, (y + dir.y * step) * gridsize);
    
    x += dir.x * step;
    y += dir.y * step;
    
    if(cellX >= 0 && cellY >= 0 && cellX < gridWidth && cellY < gridHeight)
    {
      if(map[cellX][cellY])
      {
        fill(255, 255, 0);
        ellipse(x * gridsize, y * gridsize, 10, 10);
        
        found = true;
      }
    }
    
    i++;
    if(i == 10) found = true; //<>//
  }
  
  fill(0, 255, 0);
  stroke(0);
  
  ellipse(mouseX, mouseY, 10, 10);
  
  fill(255, 0, 0);
  
  ellipse(pointX, pointY, 10, 10);
}

void mousePressed()
{
  if(mouseButton == LEFT)
  {
    map[floor(mouseX / gridsize)][floor(mouseY / gridsize)] = !map[floor(mouseX / gridsize)][floor(mouseY / gridsize)];
  } else {
    pointX = mouseX;
    pointY = mouseY;
  }
}
