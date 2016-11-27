class Boss {
  int hp;//ステータス(x座標、y座標、移動量X、移動量Y、耐久力)
  float x, y, mx, my;
  boolean move_flug;//移動フラグ
  int speed = 3;//弾速
  float d;//ベクトル計算用変数
  int frame_count;
  Boss(float bx, float by, float bmx, float bmy, int bhp) {
    x = bx;
    y = by;
    mx = bmx;
    my = bmy;
    hp = bhp;
  }
  void moveboss() {//移動処理(半分まで来たら戻る)
    if (move_flug == false) {
      y += my;
      if (y >= 100) {
        move_flug = true;
      }
    }
    else {
      mx = 5.0 * sin(radians(frame_count * 2));
      x += mx;
      shot1_mod();
      if (frame_count % 100 == 0) {
        shot2(x, y);
      }
      if (frame_count % 150 == 0) {
        shot3(x, y);
      }
      if (frame_count % 300 == 0) {
        shot4(x, y);
      }
    }
  }
  void shot1_mod() {
    if (frame_count % 50 == 0) {
      shot1(x, y);
    }
  }
  void shot1(float x, float y) {//機銃
    for (int j = 30; j < 160; j+= 60) { 
      float rad = radians(j);
      ebulletlist.add(new Enemybullet(x - 40, y, 3, cos(rad) * 1.5, sin(rad) * 1.5));
      ebulletlist.add(new Enemybullet(x + 40, y, 3, cos(rad) * 1.5, sin(rad) * 1.5));
    }
  }
  void shot2(float x, float y) {//ミサイル
    d = sqrt((ship.x - x) * (ship.x - x) + (ship.y - y) * (ship.y - y));
    bmissilelist.add(new Bossmissile(x, y, 10, (ship.x - x) / d * speed, (ship.y - y) / d * speed));
  }
  void shot3(float x, float y) {//ロケットランチャー
    for (int i = 0;i < 1;i ++ ) {
      ebulletlist.add(new Enemybullet(x + i - 40, y + 20, 8, 0, 4));
      ebulletlist.add(new Enemybullet(x + i + 40, y + 20, 8, 0, 4));
    }
  }
  void shot4(float x, float y) {//カノン砲
    ebulletlist.add(new Enemybullet(x, y + 80, 20, 0, 5));
  }
  void draw() {
    imageMode(CENTER);
    image(loadImage("boss.png"), x, y);
    fill(200, 255, 0);
    rect(480, 0, 10, 3 * hp);
  }
  void update() {
    frame_count += 1;
    moveboss();
    draw();
  }
}

