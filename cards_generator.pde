float n = 0;
char type = 'S';

int calculate_columns(float num) {

  int columns = 1;
  int col_height = int (num / columns);
  if (num <= 3) return int(1);
  while (col_height > (float(columns) * 1.1)) {

    columns ++;
    col_height = int(num / columns);
  }
  return columns;
}
PImage image;
color text_color = color(0, 0, 0);

void column(float h, int w, int x) {
  int total_height = 700;
  int total_width = 470;

  int image_size = int(total_width/(w+1));
  if(w<2) image_size *= 0.5;
  imageMode(CENTER);
  int height_offset = int(total_height / h+(10/h));
  int y =0;
  if (h%2 == 1) y = height/2;
  else y = height/2 + height_offset/2;
  for (int i = 0; i <= h; i++) {
    if (y> height/2) {
      pushMatrix();
      translate(0, 2*y);
      scale(1, -1);

      image(image, x, y, image_size, image_size);
      popMatrix();
    } else
      image(image, x, y, image_size, image_size);
    if (i%2 ==0)
      y += i*height_offset;
    else
      y -= i*height_offset;
  }
}
void generate(float n, char type) {
  textFont(createFont("/CARDOVA.ttf", 40));

  switch(type) {
  case 'S':
    image = loadImage("/srdce.jpg");
    text_color = color(212, 0, 0);

    break;
  case 'L':
    image = loadImage("/list.jpg");
    text_color = (0);
    break;

  case 'P':
    image = loadImage("/pika.jpg");
    text_color = (0);

    break;
  case 'K':
    image = loadImage("/kara.jpg");
    text_color = color(212, 0, 0);
    break;

  default:
    image = loadImage("/srdce.jpg");
    text_color = (0);
    break;
  }

  int cols = calculate_columns(n);
  int max_height = ceil(n/float(cols));
  if (max_height * cols == n)
    max_height ++;




  int p_height = 840;
  int p_width = 590;

  rectMode(CENTER);
  rect(width/2, height/2, width, height, 35);
  //rect(width/2, height/2, p_width, p_height, 35);
  imageMode(CORNER);
    image(image, 32, 110, 50, 50);

  fill(text_color);
  textSize(70);
  textAlign(LEFT, TOP);
  if (n%1 ==0)
    text(int(n), 40, 40);
  else text(n, 40, 40);
  

  pushMatrix();
  translate(width, height);
  rotate(PI);
    image(image, 32, 110, 50, 50);

  if (n%1 ==0)
    text(int(n), 40, 40);
  else text(n, 40, 40);

  popMatrix();
  p_height -= 140;
  p_width -= 120;
  fill(255);


  int h_offset = p_width/cols;
  float to_leave = cols*max_height - n;
  int rectsize = p_width/(cols);
  int h_border = (width - p_width)/2 + rectsize/2 + (p_width - (rectsize + (cols-1)*h_offset))/2;
  if (cols%2 ==1) {
    for (int i = 0; i< cols; i++) {

      if (i == cols/2) {
        column(max_height - to_leave, cols, h_border + i*h_offset);
      } else
        column(max_height, cols, h_border + i*h_offset);
    }
  } else {
    if (to_leave%2 ==0) {
      for (int i = 0; i< cols; i++) {
        if ((i == floor(float(cols)/2))||(i == floor(float(cols)/2) -1)) {
          column(max_height - (to_leave/2), cols, h_border + i*h_offset);
        } else
          column(max_height, cols, h_border + i*h_offset);
      }
    } else {
      to_leave ++;
      for (int i = 0; i< cols; i++) {
        if ((i == floor(float(cols)/2))||(i == floor(float(cols)/2) -1)) {
          column(max_height - (to_leave/2), cols, h_border + i*h_offset);
        } else
          column(max_height, cols, h_border + i*h_offset);
      }
      column(1, cols, width/2);
    }
  }
}
void setup() {
  size(650, 900);
  Table table;
  table = loadTable("Cards.csv", "header");

  for (TableRow row : table.rows()) {

    float number =row.getFloat(0);
    type = row.getString(1).charAt(0);


    println("Card: " + type + " " + number);
    generate(number, type);
    saveFrame("/generated/" + type +" " + (number) +".png");
    
  }
  exit();
}
