//Charenger v1.11
//サウンド関連の宣言
import ddf.minim.*;
AudioSnippet song1;
AudioSnippet song2;
AudioSnippet song3;
AudioSnippet song4;
AudioSnippet song5;
AudioSnippet song6;
AudioSnippet song7;
AudioSnippet song8;
AudioSnippet song9;
AudioSnippet song10;
AudioSnippet song11;
AudioSnippet song12;
Minim minim;
boolean s1flug;
boolean s2flug;
boolean s3flug;
boolean s4flug;
boolean s5flug;
boolean s6flug;
//サウンド関連の宣言ここまで
Ship ship;
Mybullet mybullet;
//オプションフラグ
boolean Hp_flug;
boolean Myspeed_flug;
boolean Hitdistance_flug;
boolean EnemyHitdistance_flug;
boolean Magazine_flug;
boolean Way_flug;
boolean Bad_hp_flug;
boolean Bad_magazine_flug;
//オプションフラグここまで
int Mode_flug = 0;
int Gameover_flug = 0;//(1=WIN、2=LOSE)
boolean Print_flug;
//ゲーム部にて使用する変数
boolean Setup_flug;
ArrayList enemy1list = new ArrayList();
ArrayList enemy2list = new ArrayList();
ArrayList enemy3list = new ArrayList();
ArrayList enemy4list = new ArrayList();
ArrayList bosslist = new ArrayList();
ArrayList sbosslist = new ArrayList();
ArrayList ebulletlist = new ArrayList();//敵弾リスト
ArrayList bmissilelist = new ArrayList();//ボスミサイルリスト
int Score;//ゲームスコア
float rate = 1.0;//スコアレート
int worning_counter;
boolean kw, ka, ks, kd, kj, kk;
//敵出現フラグ
boolean e1flug;
boolean e2flug;
boolean e3flug;
//敵出現フラグここまで
int frame_count;
int ms;//ミリ秒カウント
int s;//秒カウント
//ゲーム部にて使用する変数ここまで
void setup() {
  size(500, 500);
  frameRate(60);
  background(0);
  minim = new Minim( this );
  song1 = minim.loadSnippet("start.mp3");//スタート音
  song2 = minim.loadSnippet("SE4.mp3");//セレクト音
  song3 = minim.loadSnippet("SE5.mp3");//発射音
  song4 = minim.loadSnippet("bomb_2.mp3");//爆発音小
  song5 = minim.loadSnippet("bomb_1.mp3");//爆発音大
  song6 = minim.loadSnippet("alert.mp3");//アラート
  song7 = minim.loadSnippet("fanfare.mp3");//ファンファーレ
  song8 = minim.loadSnippet("gameover.mp3");//ゲームオーバー
  song9 = minim.loadSnippet("BGM_optionselect.mp3");//オプションBGM
  song10 = minim.loadSnippet("BGM_stage.mp3");//ステージBGM
  song11 = minim.loadSnippet("BGM_boss.mp3");//ボスBGM
  song12 = minim.loadSnippet("BGM_result.mp3");//リザルトBGM
}
void draw() {
  switch(Mode_flug) {
  case 0://タイトル画面
    Print_title();
    if (mousePressed) {
      song1.play();
      Mode_flug = 1;
    }
    break;
  case 1://オプションセレクト画面
    if (Print_flug == false) {
      Print_option();
    }
    Update_option();
    if ((keyPressed == true) && (key == ENTER)) {
      Mode_flug = 2;
      Rate();
    }
    break;
  case 2://ゲーム画面
    background(0);
    frame_count += 1;
    if (frame_count % 6 == 0) {//ミリ秒カウント
      ms += 1;
    }
    if (frame_count % 60 == 0) {//秒カウント
      s += 1;
    }
    textSize(21);
    fill(255);
    text(nf(s, 1, 0), 15, 20);//経過秒数表示
    if (Setup_flug == false) {//セットアップ部
      song9.pause();
      song10.loop();
      ship = new Ship(250, 450);
      Setup_flug =true;
    }
    if (Gameover_flug == 1||Gameover_flug == 2) {
      Mode_flug = 3;
    }
    if (s == 120) {
      Gameover_flug = 2;
    }
    ship.update();
    Enemy_update();
    Ebullet_update();
    Enemy_pop();
    break;
  case 3://ゲームオーバー画面
    Print_result();
    if ((keyPressed == true) && (key == ENTER)) {
      delay(500);
      Mode_flug = 4;
    }
    break;
  case 4:
    if (s1flug == false) {
      song12.loop();
      s1flug = true;
    }
    Result();
    if ((keyPressed == true) && (key == ENTER)) {
      exit();
    }
    break;
  }
}
void stop()
{
  song1.close();
  song2.close();
  song3.close();
  song4.close();
  song5.close();
  song6.close();
  song7.close();
  song8.close();
  song9.close();
  song10.close();
  song11.close();
  song12.close();
  minim.stop();
  super.stop();
}
//case0にて使用
void Print_title() {//タイトル表示
  textSize(50);
  textAlign(CENTER);
  text("Charenger", 250, 150);
  textSize(16);
  textAlign(CENTER);
  text("Please Press Mouse ", 250, 400);
}
//case0にて使用ここまで
//case1にて使用
void Print_option() {//オプション表示
  background(0);
  textSize(21);
  textAlign(CENTER);
  text("Select Option", 250, 45);
  text("When you are finished, please press the Enter", 250, 455);
  textAlign(RIGHT);
  text("HP 5(-10%)", 205, 95);
  image(loadImage("check(0).png"), 215, 73);
  text("SPEED UP(-15%)", 205, 145);
  image(loadImage("check(0).png"), 215, 123);
  text("MINIMUM(-20%)", 205, 195);
  image(loadImage("check(0).png"), 215, 173);
  text("BIG BULLET(-15%)", 205, 245);
  image(loadImage("check(0).png"), 215, 223);
  text("MAGAZINE 15(-10%)", 205, 295);
  image(loadImage("check(0).png"), 215, 273);
  text("3 WAY SHOT(-30%)", 205, 345);
  image(loadImage("check(0).png"), 215, 323);
  fill(255, 0, 0);
  text("HP 1(+30%)", 440, 95);
  image(loadImage("check(0).png"), 440, 73);
  text("MAGAZINE 5(+20%)", 440, 145);
  image(loadImage("check(0).png"), 440, 123);
  textSize(18);
  text("※Do not use 3WAYSHOT and ", 260, 400);
  text("the MAGAZINE5 at the same time", 310, 420);
  textSize(21);
  fill(0);
  song9.loop();
  Print_flug = true;
}
void Update_option() {//オプション画面更新
  if (mousePressed) {
    if (abs(220 - mouseX) < 16) {
      if (abs(83 - mouseY) < 16) {
        if (Hp_flug == false) {
          image(loadImage("check(1).png"), 215, 73);
          Hp_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 215, 73);
          Hp_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
    if (abs(220 - mouseX) < 16) {
      if (abs(133 - mouseY) < 16) {
        if (Myspeed_flug == false) {
          image(loadImage("check(1).png"), 215, 123);
          Myspeed_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 215, 123);
          Myspeed_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
    if (abs(220 - mouseX) < 16) {
      if (abs(183 - mouseY) < 16) {
        if (Hitdistance_flug == false) {
          image(loadImage("check(1).png"), 215, 173);
          Hitdistance_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 215, 173);
          Hitdistance_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
    if (abs(220 - mouseX) < 16) {
      if (abs(233 - mouseY) < 16) {
        if (EnemyHitdistance_flug == false) {
          image(loadImage("check(1).png"), 215, 223);
          EnemyHitdistance_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 215, 223);
          EnemyHitdistance_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
    if (abs(220 - mouseX) < 16) {
      if (abs(283 - mouseY) < 16) {
        if (Magazine_flug == false) {
          image(loadImage("check(1).png"), 215, 273);
          Magazine_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 215, 273);
          Magazine_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
    if (abs(220 - mouseX) < 16) {
      if (abs(333 - mouseY) < 16) {
        if (Way_flug == false) {
          image(loadImage("check(1).png"), 215, 323);
          Way_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 215, 323);
          Way_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
    if (abs(440 - mouseX) < 16) {
      if (abs(83 - mouseY) < 16) {
        if (Bad_hp_flug == false) {
          image(loadImage("check(1).png"), 440, 73);
          Bad_hp_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 440, 73);
          Bad_hp_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
    if (abs(440 - mouseX) < 16) {
      if (abs(133 - mouseY) < 16) {
        if (Bad_magazine_flug == false) {
          image(loadImage("check(1).png"), 440, 123);
          Bad_magazine_flug = true;
          song2.play();
          song2.rewind();
          delay(500);
        }
        else {
          image(loadImage("check(0).png"), 440, 123);
          Bad_magazine_flug = false;
          song2.play();
          song2.rewind();
          delay(500);
        }
      }
    }
  }
}
void Rate() {//スコアレート計算
  if (Hp_flug) {
    rate -= 0.1;
  }
  if (Myspeed_flug) {
    rate -= 0.15;
  }
  if (Hitdistance_flug) {
    rate -= 0.2;
  }
  if (EnemyHitdistance_flug) {
    rate -= 0.15;
  }
  if (Way_flug) {
    rate -= 0.3;
  }
  if (Magazine_flug) {
    rate -= 0.1;
  }
  if (Bad_hp_flug) {
    rate += 0.3;
  }
  if (Bad_magazine_flug) {
    rate += 0.2;
  }
}
//case1にて使用ここまで
//case2にて使用
void Enemy_update() {
  if (enemy1list.size() > 0) {//敵1アップデート
    for (int i = enemy1list.size()-1; i >= 0; i--) {
      Enemy1 t = (Enemy1)enemy1list.get(i);
      t.update();
      if (t.y <= 0 || t.y >= 500 || t.x <= 0 || t.x >= 500) {
        enemy1list.remove(i);
      }
    }
  }
  if (enemy2list.size() > 0) {//敵2アップデート
    for (int i = enemy2list.size()-1; i >= 0; i--) {
      Enemy2 t = (Enemy2)enemy2list.get(i);
      t.update();
      if (t.y <= 0 || t.y >= 500 || t.x <= 0 || t.x >= 500) {
        enemy2list.remove(i);
      }
    }
  }
  if (enemy3list.size() > 0) {//敵3アップデート
    for (int i = enemy3list.size()-1; i >= 0; i--) {
      Enemy3 t = (Enemy3)enemy3list.get(i);
      t.update();
      if (t.y <= 0 || t.y >= 500 || t.x <= 0 || t.x >= 500) {
        enemy3list.remove(i);
      }
    }
  }
  if (enemy4list.size() > 0) {//敵4アップデート
    for (int i = enemy4list.size()-1; i >= 0; i--) {
      Enemy4 t = (Enemy4)enemy4list.get(i);
      t.update();
      if (t.y <= 0 || t.y >= 500 || t.x <= 0 || t.x >= 500) {
        enemy4list.remove(i);
      }
    }
  }
  if (bosslist.size() > 0) {//ボスアップデート
    for (int i = bosslist.size()-1; i >= 0; i--) {
      Boss t = (Boss)bosslist.get(i);
      t.update();
      if (t.y <= 0) {
        bosslist.remove(i);
      }
    }
  }
  if (sbosslist.size() > 0) {//ボスアップデート
    for (int i = sbosslist.size()-1; i >= 0; i--) {
      SBoss t = (SBoss)sbosslist.get(i);
      t.update();
      if (t.y <= 0) {
        sbosslist.remove(i);
      }
    }
  }
}
void Enemy_pop() {//敵出現処理
  if (frame_count % 60 == 0 || s == 0) {
    if (s == 1) {
      enemy1list.add(new Enemy1(150, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(150, 50, 1, 3, 1, 250));
      enemy3list.add(new Enemy3(350, 0, 0, 3, 3, 230));
      enemy3list.add(new Enemy3(350, 50, 0, 3, 3, 230));
    }
    if (s == 2) {
      enemy1list.add(new Enemy1(350, 0, -1, 3, 1, 230));
      enemy1list.add(new Enemy1(350, 50, -1, 3, 1, 230));
      enemy3list.add(new Enemy3(150, 0, 0, 3, 3, 200));
      enemy3list.add(new Enemy3(150, 50, 0, 3, 3, 220));
    }
    if (s == 4) {
      enemy2list.add(new Enemy2(150, 0, 0, 3, 5, 210));
      enemy2list.add(new Enemy2(250, 0, 0, 3, 5, 250));
      enemy2list.add(new Enemy2(350, 0, 0, 3, 5, 210));
    }
    if (s == 6) {
      enemy1list.add(new Enemy1(150, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(150, 50, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(350, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(350, 50, -1, 3, 1, 250));
    }
    if (s == 8) {
      enemy1list.add(new Enemy1(100, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(150, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(200, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(250, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(300, 0, 1, 3, 1, 250));
    }
    if (s == 10) {
      enemy1list.add(new Enemy1(400, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(350, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(300, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(250, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(200, 0, -1, 3, 1, 250));
    }
    if (s == 11) {
      enemy3list.add(new Enemy3(250, 0, 0, 3, 3, 200));
      enemy3list.add(new Enemy3(250, 50, 0, 3, 3, 230));
      enemy3list.add(new Enemy3(250, 100, 0, 3, 3, 260));
      enemy4list.add(new Enemy4(400, 0, -1, 2.5, 1, 600));
      enemy4list.add(new Enemy4(400, 50, -1, 3, 1, 600));
      enemy4list.add(new Enemy4(100, 0, 1, 2.5, 1, 600));
      enemy4list.add(new Enemy4(100, 50, 1, 3, 1, 600));
    }
    if (s == 12) {
      enemy2list.add(new Enemy2(100, 0, 0, 3, 5, 200));
      enemy2list.add(new Enemy2(150, 0, 0, 3, 5, 230));
    }
    if (s == 13) {
      enemy2list.add(new Enemy2(400, 0, 0, 3, 5, 200));
      enemy2list.add(new Enemy2(350, 0, 0, 3, 5, 230));
    }
    if (s == 18) {
      enemy1list.add(new Enemy1(150, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(150, 50, 1, 3, 1, 250));
      enemy3list.add(new Enemy3(350, 0, 0, 3, 3, 230));
      enemy3list.add(new Enemy3(350, 50, 0, 3, 3, 230));
    }
    if (s == 19) {
      enemy1list.add(new Enemy1(350, 0, -1, 3, 1, 230));
      enemy1list.add(new Enemy1(350, 50, -1, 3, 1, 230));
      enemy3list.add(new Enemy3(150, 0, 0, 3, 3, 200));
      enemy3list.add(new Enemy3(150, 50, 0, 3, 3, 220));
    }
    if (s == 21) {
      enemy2list.add(new Enemy2(150, 0, 0, 3, 5, 210));
      enemy2list.add(new Enemy2(250, 0, 0, 3, 5, 250));
      enemy2list.add(new Enemy2(350, 0, 0, 3, 5, 210));
    }
    if (s == 23) {
      enemy1list.add(new Enemy1(150, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(150, 50, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(350, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(350, 50, -1, 3, 1, 250));
    }
    if (s == 25) {
      enemy1list.add(new Enemy1(100, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(150, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(200, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(250, 0, 1, 3, 1, 250));
      enemy1list.add(new Enemy1(300, 0, 1, 3, 1, 250));
    }
    if (s == 27) {
      enemy1list.add(new Enemy1(400, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(350, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(300, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(250, 0, -1, 3, 1, 250));
      enemy1list.add(new Enemy1(200, 0, -1, 3, 1, 250));
    }
    if (s == 28) {
      enemy3list.add(new Enemy3(250, 0, 0, 3, 3, 200));
      enemy3list.add(new Enemy3(250, 50, 0, 3, 3, 230));
      enemy3list.add(new Enemy3(250, 100, 0, 3, 3, 260));
      enemy4list.add(new Enemy4(400, 0, -1, 2.5, 1, 600));
      enemy4list.add(new Enemy4(400, 50, -1, 3, 1, 600));
      enemy4list.add(new Enemy4(100, 0, 1, 2.5, 1, 600));
      enemy4list.add(new Enemy4(100, 50, 1, 3, 1, 600));
    }
    if (s == 29) {
      enemy2list.add(new Enemy2(100, 0, 0, 3, 5, 200));
      enemy2list.add(new Enemy2(150, 0, 0, 3, 5, 230));
    }
    if (s == 30) {
      enemy2list.add(new Enemy2(400, 0, 0, 3, 5, 200));
      enemy2list.add(new Enemy2(350, 0, 0, 3, 5, 230));
    }
    if (s >= 50 && bosslist.size() == 0 && e3flug == false) {
      sbosslist.add(new SBoss(200, 0, 0, 3, 100));
      e3flug = true;
    }
  }
  if (enemy1list.size() == 0 &&enemy2list.size() == 0 && enemy3list.size() == 0) {
    if (s >= 33 && e1flug == false) {//アラートを表示
      song10.pause();
      song6.play();
      textSize(50);
      textAlign(CENTER);
      fill(255, 0, 0);
      text("WORNING !", 250, 250);
      fill(255);
      worning_counter++;
      if (worning_counter == 180) {
        e1flug = true;
      }
    }
    if (s >= 36 && e2flug == false && worning_counter >=180) {
      if (s2flug == false) {
        song11.loop();
      }
      bosslist.add(new Boss(200, 0, 0, 3, 100));
      e2flug = true;
    }
  }
}
void Ebullet_update() {//敵弾アップデート
  if (ebulletlist.size() > 0) {
    for (int i = ebulletlist.size()-1; i >= 0; i--) {
      Enemybullet t = (Enemybullet)ebulletlist.get(i);
      t.update();
      if (t.ty <= 0 || t.ty >= 500 || t.tx <= 0 || t.tx >= 500) {
        ebulletlist.remove(i);
      }
    }
  }
  if (bmissilelist.size() > 0) {
    for (int i = bmissilelist.size()-1; i >= 0; i--) {
      Bossmissile t = (Bossmissile)bmissilelist.get(i);
      t.update();
      if (t.ty <= 0 || t.ty >= 500 || t.tx <= 0 || t.tx >= 500) {
        bmissilelist.remove(i);
      }
    }
  }
}
void keyPressed() {
  //使用するキーが押されたら、対応する変数をtrueに
  switch(key) {
  case 'w':
    kw = true;
    break;
  case 'a':
    ka = true;
    break;
  case 's':
    ks = true;
    break;
  case 'd':
    kd = true;
    break;
  case 'j':
    kj = true;
    break;
  case 'k':
    kk = true;
    break;
  }
}
void keyReleased() {
  //使用するキーが離されたら、対応する変数をfalseに
  switch(key) {
  case 'w':
    kw = false;
    break;
  case 'a':
    ka = false;
    break;
  case 's':
    ks = false;
    break;
  case 'd':
    kd = false;
    break;
  case 'j':
    kj = false;
    break;
  case 'k':
    kk = false;
    break;
  }
}
//case2にて使用ここまで
//case3にて使用
void Print_result() {
  background(0);
  textSize(50);
  textAlign(CENTER);
  fill(255);
  if (Gameover_flug == 1) {
    if (s5flug == false) {
      song11.pause();
      song7.play();
      s5flug = true;
    }
    text("Congraturation !", 250, 250);
    textSize(21);
    text("Time Bonus : ", 220, 300);
    text(nf(floor((90 - s) * 500 * rate), 0, 0), 320, 300);
  }
  else if (Gameover_flug == 2) {
    if (s6flug == false) {
      song10.pause();
      song8.play();
      s6flug = true;
    }
    text("Failed...", 250, 250);
  }
}
//case3にて使用ここまで
//case4にて使用
void Result() {
  background(0);
  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("Score", 250, 200);
  if (Gameover_flug == 1) {
    text(nf(floor((Score + (90 - s) * 500) * rate), 0, 0), 250, 250);
  }
  else if (Gameover_flug == 2) {
    text(nf(floor(Score * rate), 0, 0), 250, 250);
  }
  textSize(21);
  text("Thank You For Playing !", 250, 425);
}
//case4にて使用ここまで

