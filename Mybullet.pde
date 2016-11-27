class Mybullet extends Enemybullet {
  Mybullet(float x, float y, float r, float dx, float dy) {
    super(x, y, r, dx, dy);
  }
  void Hit_check() {//当たり判定
    if (enemy1list.size() > 0) {
      for (int i = enemy1list.size()-1; i >= 0; i--) {
        Enemy1 t = (Enemy1)enemy1list.get(i);
        if (t.hp == 0) {
          enemy1list.remove(i);
          song4.play();
          song4.rewind();
          Score += 1000;
        }
        if (EnemyHitdistance_flug == true) {
          if (abs(tx - t.x) < 40 && abs(ty - t.y) < 40 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
        else {
          if (abs(tx - t.x) < 20 && abs(ty - t.y) < 20 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
      }
    }
    if (enemy2list.size() > 0) {
      for (int i = enemy2list.size()-1; i >= 0; i--) {
        Enemy2 t = (Enemy2)enemy2list.get(i);
        if (t.hp == 0) {
          enemy2list.remove(i);
          song4.play();
          song4.rewind();
          Score += 2500;
        }
        if (EnemyHitdistance_flug == true) {
          if (abs(tx - t.x) < 50 && abs(ty - t.y) < 50 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
        else {
          if (abs(tx - t.x) < 30 && abs(ty - t.y) < 30 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
      }
    }
    if (enemy3list.size() > 0) {
      for (int i = enemy3list.size()-1; i >= 0; i--) {
        Enemy3 t = (Enemy3)enemy3list.get(i);
        if (t.hp == 0) {
          enemy3list.remove(i);
          song4.play();
          song4.rewind();
          Score += 3000;
        }
        if (EnemyHitdistance_flug == true) {
          if (abs(tx - t.x) < 50 && abs(ty - t.y) < 50 && lock_flug == false) {
            t.hp--;
          }
        }
        else {
          if (abs(tx - t.x) < 30 && abs(ty - t.y) < 30 && lock_flug == false) {
            t.hp--;
          }
        }
      }
    }
    if (enemy4list.size() > 0) {
      for (int i = enemy4list.size()-1; i >= 0; i--) {
        Enemy4 t = (Enemy4)enemy4list.get(i);
        if (t.hp == 0) {
          enemy4list.remove(i);
          song4.play();
          song4.rewind();
          Score += 1000;
        }
        if (EnemyHitdistance_flug == true) {
          if (abs(tx - t.x) < 40 && abs(ty - t.y) < 40 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
        else {
          if (abs(tx - t.x) < 20 && abs(ty - t.y) < 20 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
      }
    }
    if (bosslist.size() > 0) {
      for (int i = bosslist.size()-1; i >= 0; i--) {
        Boss t = (Boss)bosslist.get(i);
        if (t.hp == 0) {
          bosslist.remove(i);
          song5.play();
          song5.rewind();
          Score += 10000;
          if (Score < 111700 || rate < 1.0) {
            Gameover_flug = 1;
          }
        }
        if (EnemyHitdistance_flug == true) {
          if (abs(tx - t.x) < 130 && abs(ty - t.y) < 130 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
        else {
          if (abs(tx - t.x) < 100 && abs(ty - t.y) < 100 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
      }
    }
    if (sbosslist.size() > 0) {
      for (int i = sbosslist.size()-1; i >= 0; i--) {
        SBoss t = (SBoss)sbosslist.get(i);
        if (t.hp == 0) {
          sbosslist.remove(i);
          song5.play();
          song5.rewind();
          Score += 100000;
          Gameover_flug = 1;
        }
        if (EnemyHitdistance_flug == true) {
          if (abs(tx - t.x) < 130 && abs(ty - t.y) < 130 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
        else {
          if (abs(tx - t.x) < 100 && abs(ty - t.y) < 100 && lock_flug == false) {
            t.hp--;
            lock_flug = true;
          }
        }
      }
    }
  }
  void update() {
    tx += mx;
    ty += my;
    stroke(255, 255, 0);
    noFill();
    if (lock_flug == false) {
      ellipse(tx, ty, tr, tr);//弾描画
    }
    Hit_check();
  }
}

