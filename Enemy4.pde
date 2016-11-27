class Enemy4 extends Enemy1 {
  boolean lock_flug;
  Enemy4(float ex, float ey, float emx, float emy, int ehp, int eaction) {
    super(ex, ey, emx, emy, ehp, eaction);
  }
  void moveenemy() {//移動処理(半分まで来たら戻る)
    if (move_flug == false) {
      x += mx;
      y += my;
      if (y >= action) {
        move_flug = true;
      }
    }
    else {
      x += mx;
      y -= my;
    }
  }
  void Hit_check() {
    if (ship.hp == 0) {
      if (Gameover_flug != 2) {
        song5.play();
        song5.rewind();
      }
      Gameover_flug = 2;
    }
    else {
      if (abs(x - ship.x) < 15 && abs(y - ship.y) < 15 && lock_flug == false) {
        ship.hp -= 3;
        lock_flug = true;
      }
    }
  }
  void draw() {
    imageMode(CENTER);
    image(loadImage("enemy1.png"), x, y);
  }
  void update() {
    moveenemy();
    Hit_check();
    draw();
  }
}

