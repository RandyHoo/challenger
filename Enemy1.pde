class Enemy1 {
  float x, y, mx, my;//ステータス(x座標、y座標、移動量X、移動量Y、耐久力)
  int hp, action;
  boolean move_flug;//移動フラグ
  boolean action_flug;//発砲フラグ
  int speed = 3;//弾速
  float d;//ベクトル計算用変数
  Enemy1(float ex, float ey, float emx, float emy, int ehp, int eaction) {
    x = ex;
    y = ey;
    mx = emx;
    my = emy;
    hp = ehp;
    action = eaction;
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
      if (action_flug == false) {
        shot();
        action_flug = true;
      }
    }
  }
  void shot() {
    d = sqrt((ship.x - x) * (ship.x - x) + (ship.y - y) * (ship.y - y));
    ebulletlist.add(new Enemybullet(x, y, 10, (ship.x - x) / d * speed, (ship.y - y) / d * speed));
  }
  void draw() {
    imageMode(CENTER);
    image(loadImage("enemy1.png"), x, y);
  }
  void update() {
    moveenemy();
    draw();
  }
}

