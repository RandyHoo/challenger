class Enemy3 extends Enemy1 {
  Enemy3(float ex, float ey, float emx, float emy, int ehp, int eaction) {
    super(ex, ey, emx, emy, ehp, eaction);
  }
  void shot() {  
    for (int i = 0; i < 360; i+= 45) { 
      float rad = radians(i);
      ebulletlist.add(new Enemybullet(x, y, 10, cos(rad), sin(rad)));
    }
  }
  void draw() {
    imageMode(CENTER);
    image(loadImage("enemy3.png"), x, y);
  }
  void update() {
    moveenemy();
    draw();
  }
}

