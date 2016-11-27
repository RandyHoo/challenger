class Ship {//自機クラス
  int x, y, r, speed;//ステータス(x座標、y座標、耐久力、弾半径、速度)
  float hp;
  int magazine_max, magazine_now;//マガジン管理関連(最大数、現在数)
  ArrayList my_bullet = new ArrayList();//自機弾リスト
  Ship(int sx, int sy) {
    x = sx;
    y = sy;
    if (Hp_flug == true) {//体力設定
      hp = 5;
    }
    if (Bad_hp_flug == true) {
      hp = 1;
    }
    if (Bad_hp_flug == false && Hp_flug == false) {
      hp = 3;
    }
    if (EnemyHitdistance_flug == true) {//自機弾サイズ設定
      r = 30;
    }
    else {
      r = 10;
    }
    if (Way_flug == true) {//マガジン最大数設定
      magazine_max = 3;
    }
    if (Magazine_flug == true) {//マガジン最大数設定
      magazine_max = 15;
    }
    if (Bad_magazine_flug == true) {
      magazine_max = 5;
    }
    if (Way_flug == false && Magazine_flug == false && Bad_magazine_flug == false) {
      magazine_max = 10;
    }
    if (Myspeed_flug == true) {//自機速度設定
      speed = 6;
    }
    else {
      speed = 3;
    }
    magazine_now = magazine_max;
  }
  void movecheck() {//移動処理
    if (kw) {
      y -= speed;
    }
    if (ka) {
      x -= speed;
    }
    if (ks) {
      y += speed;
    }
    if (kd) {
      x += speed;
    }
    if (y <= 0) {
      y = 0;
    }
    if (y >= 500) {
      y = 500;
    }
    if (x <= 0) {
      x = 0;
    }
    if (x >= 500) {
      x = 500;
    }
    imageMode(CENTER);
    if (Hitdistance_flug == true) {
      image(loadImage("miniship.png"), x, y);
    }
    else {
      image(loadImage("myship.png"), x, y);
    }
  }
  void shotcheck() {
    if (magazine_now <= 0) {
      if (kk == true && kj == false) {//リロード処理
        magazine_now = magazine_max;
      }
    }
    else {
      if (kj == true) {//射撃処理
        if (Way_flug == true && magazine_now >= 0) {
          my_bullet.add(new Mybullet(x, y, r, 0, -10));
          my_bullet.add(new Mybullet(x, y, r, 3, -10));
          my_bullet.add(new Mybullet(x, y, r, -3, -10));
          song3.play();
          song3.rewind();
          magazine_now -= 3;
        }
        else {
          my_bullet.add(new Mybullet(x, y, r, 0, -10));
          song3.play();
          song3.rewind();
          magazine_now--;
        }
      }
    }
  }
  void print_status() {
    float mn = magazine_now;
    float HP = hp;
    textAlign(CENTER);
    fill(255);
    textSize(21);
    text("SCORE", 400, 420);
    text(nf(floor(Score * rate), 0, 0), 470, 420);
    text("HP", 400, 450);
    text(nf(HP, 1, 1), 470, 450);
    text("BULLET", 400, 480);
    text(nf(mn, 0, 0), 470, 480);
  }
  void update_mybullet() {
    if (my_bullet.size() > 0) {
      for (int i = my_bullet.size()-1; i >= 0; i--) {
        Mybullet t = (Mybullet)my_bullet.get(i);
        t.update();
        if (t.ty <= 0 || t.ty >= 500 || t.tx <= 0 || t.tx >= 500) {
          my_bullet.remove(i);
        }
      }
    }
  }
  void update() {
    if (hp <= 0) {
      Gameover_flug = 2;
    }
    movecheck();
    shotcheck();
    print_status();
    update_mybullet();
  }
}

