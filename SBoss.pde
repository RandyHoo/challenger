class SBoss extends Boss {
  SBoss(float bx, float by, float bmx, float bmy, int bhp) {
    super(bx, by, bmx, bmy, bhp);
  }
  void shot1_mod() {
    if (frame_count % 30 == 0) {
      shot1(x, y);
    }
  }
  void shot1(float x, float y) {//機銃
    for (int i = 0;i < 30;i += 10) {
      ebulletlist.add(new Enemybullet(x + i - 40, y + 40, 3, 0, 3));
      ebulletlist.add(new Enemybullet(x + i + 40, y + 40, 3, 0, 3));
    }
  }
  void shot3(float x, float y) {//ロケットランチャー
    for (int i = 0;i < 30;i += 15) {
      ebulletlist.add(new Enemybullet(x + i - 40, y + 20, 8, 0, 5));
      ebulletlist.add(new Enemybullet(x + i + 40, y + 20, 8, 0, 5));
    }
  }
  void draw() {
    imageMode(CENTER);
    image(loadImage("sboss.png"), x, y);
    fill(200, 255, 0);
    rect(480, 0, 10, 3 * hp);
  }
}

