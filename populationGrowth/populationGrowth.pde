// Countries and their population + growth to compare
Country[] countries = {
  new Country("India", 1.3, 1.26),
  new Country("China", 1.4, 0.52)
};

// initial max year, could be changed by mouse wheel
float maxYear = 50;

// year input is bound to mouse x axis
float year = 0;

// beyond this borders on the x axis the mouse postion
// won't affect the current year
float mouseBorder = 50;

// multiplies the population by drawFactor to make
// the amounts of heads more or less visible
float drawFactor = 10;

void setup() {
  size(1600, 600);
  //fullScreen();
  textAlign(CENTER);
  textSize(80);
}

void draw() {
  background(200);
  
  float mouseXarea = (mouseX - mouseBorder) / (width - mouseBorder * 2);
  year = constrain(mouseXarea, 0, 1) * maxYear;
  
  for (int c = 0; c < countries.length; c++) {
    float population = Math.round(countries[c].getPopulation(year) * drawFactor);
    fill(255);
    for (int p = 0; p < population; p++) {
      push();
      translate(
          width / 2 * c + width * 0.075 + p % 10 * (width * 0.0375),
          height/2 - p / 10 * (width * 0.0375)
      );
      drawHead();
      pop();
    }
    fill(0);
    drawCountry(c);
  }

  drawYear();
}

void drawHead() {
  arc(0, width * 0.0125, width * 0.025, width * 0.025, PI, PI*2, CHORD);
  circle(0, - width * 0.00625, width * 0.01875);
}

void drawCountry(int idx) {
  push();
  translate(width/4f + width/2f * idx, height/2+120);
  text(countries[idx].name, 0, 0);
  text(countries[idx].getPopulation(year), 0, 80);
  pop();
}

void drawYear() {
  push();
  translate(width/2, height/2+120);
  text("Year: " + Math.round(year), 0, 0);
  text("Max year: " + Math.round(maxYear), 0, 80);
  pop();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  maxYear -= e;
  if (maxYear < 1) maxYear = 1;
}

static float getCompoundInterest(float initial, float rate, float years) {
  return initial * (float) Math.pow(1 + rate/100f, years);
}

class Country {
  String name;
  float population;
  float growth;
  
  Country(String name, float population, float growth) {
    this.name = name;
    this.population = population;
    this.growth = growth;
  }
  
  float getPopulation(float years) {
    return getCompoundInterest(population, growth, years);
  }
}
