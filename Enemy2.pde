class Enemy2 extends Enemy1 {
  int frame_count;
  Enemy2(float ex, float ey, float emx, float emy, int ehp, int eaction) {
    super(ex, ey, emx, emy, ehp, eaction);
  }
  void moveenemy() {//移動処理
    if (move_flug == false) {
      y += mx;
      y += my;
      if (y >= action) {
        move_flug = true;
      }
    }
    else {
      mx = 2.0 * sin(radians(frame_count * 2));
      x += mx;
      if (frame_count % 100 == 0) {
        shot(x, y);
      }
    }
  }
  void shot(float x, float y) {
    ebulletlist.add(new Enemybullet(x + 10, y, 10, 0, 3));
    ebulletlist.add(new Enemybullet(x - 10, y, 10, 0, 3));
  }
  void draw() {
    imageMode(CENTER);
    image(loadImage("enemy2.png"), x, y);
  }
  void update() {
    frame_count += 1;
    moveenemy();
    draw();
  }
}

