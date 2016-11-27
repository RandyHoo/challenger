class Bossmissile {
  float tx, ty, tr, mx, my;//ステータス(x座標、y座標、弾半径、移動量X、移動量Y)
  boolean lock_flug;//多段ヒット防止用フラグ
  int speed = 3;//弾速
  float theta = 1;//旋回角度上限
  float d, rad, mx0, my0, mx1, my1, mx2, my2, mx3, my3, px, py;//ベクトル計算用変数
  Bossmissile(float x, float y, float r, float dx, float dy) {
    tx = x;//弾X座標
    ty = y;//弾Y座標
    tr = r;//弾半径
    mx = dx;//移動量X
    my = dy;//移動量Y
  }
  void Hit_shipcheck() {//自機当たり判定
    if (ship.hp == 0) {
      Gameover_flug = 2;
    }
    if (abs(tx - ship.x) < 10 && abs(ty - ship.y) < 10 && lock_flug == false) {
      ship.hp--;
      lock_flug = true;
    }
  }
  void update() {
    mx0 = mx;
    my0 = my;
    d = sqrt((ship.x - tx) * (ship.x - tx) + (ship.y - ty) * (ship.y - ty));
    if (d != 0) {
      mx1 = (ship.x - tx) / d * speed;
      my1 = (ship.y - ty) / d * speed;
    }
    else {
      mx1 =0;
      my1 = speed;
    }
    rad = 3.141592653 / 180 * theta;
    mx2 = cos(rad) * mx0 - sin(rad) * my0;
    my2 = sin(rad) * mx0 + cos(rad) * my0;
    if (mx0 * mx1 + my0 * my1 >= mx0 * mx2 + my0 * my2) {
      mx = mx1;
      my = my1;
    }
    else {
      mx3 = cos(rad) * mx0 + sin(rad) *my0;
      my3 = -sin(rad) * mx0 + cos(rad) *my0;
      px = ship.x - tx;
      py = ship.y - ty;
      if (px * mx2 + py * my2 >= px * mx3 + py * my3) {
        mx = mx2;
        my = my2;
      }
      else {
        mx = mx3;
        my = my3;
      }
    }
    tx += mx;
    ty += my;
    stroke(255, 100, 100);
    noFill();
    if (lock_flug == false) {
      ellipse(tx, ty, tr, tr);//弾描画
    }
    Hit_shipcheck();
  }
}

