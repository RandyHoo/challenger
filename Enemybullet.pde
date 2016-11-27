class Enemybullet {
  float tx, ty, tr, mx, my;//ステータス(x座標、y座標、弾半径、移動量X、移動量Y) 
  boolean lock_flug;//多段ヒット防止用フラグ
  Enemybullet(float x, float y, float r, float dx, float dy) {
    tx = x;//弾X座標
    ty = y;//弾Y座標
    tr = r;//弾半径
    mx = dx;//移動量X
    my = dy;//移動量Y
  }
  void Hit_check() {//自機当たり判定
    if (ship.hp == 0) {
      if (Gameover_flug != 2) {
        song5.play();
        song5.rewind();
      }
      Gameover_flug = 2;
    }
    if (Hitdistance_flug == true) {
      if (tr == 20) {
        if (abs(tx - ship.x) < 15 && abs(ty - ship.y) < 15 && lock_flug == false) {
          ship.hp -= 3;
          lock_flug = true;
        }
      }
      else if (tr == 3) {
        if (abs(tx - ship.x) < 2 && abs(ty - ship.y) < 2 && lock_flug == false) {
          ship.hp -= 0.5;
          lock_flug = true;
        }
      }
      else {
        if (abs(tx - ship.x) < 5 && abs(ty - ship.y) < 5 && lock_flug == false) {
          ship.hp--;
          lock_flug = true;
        }
      }
    }
    else {
      if (tr == 20) {
        if (abs(tx - ship.x) < 35 && abs(ty - ship.y) < 35 && lock_flug == false) {
          ship.hp -= 3;
          lock_flug = true;
        }
      }
      else if (tr == 3) {
        if (abs(tx - ship.x) < 3 && abs(ty - ship.y) < 3 && lock_flug == false) {
          ship.hp -= 0.5;
          lock_flug = true;
        }
      }
      else {
        if (abs(tx - ship.x) < 15 && abs(ty - ship.y) < 15 && lock_flug == false) {
          ship.hp--;
          lock_flug = true;
        }
      }
    }
  }
  void update() {
    tx += mx;//X座標移動処理
    ty += my;//Y座標移動処理
    if (tr == 20) {
      stroke(255, 255, 0);
    }
    else if (tr == 8) {
      stroke(0, 255, 0);
    }
    else {
      stroke(255, 0, 0);
    }
    noFill();
    if (lock_flug == false) {
      ellipse(tx, ty, tr, tr);//弾描画
    }
    Hit_check();
  }
}

