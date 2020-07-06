import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;
int fftSize;

void setup() {
  size(640, 480, P2D);
  background(0);
  minim = new Minim(this);
  // fftサイズ設定
  fftSize = 512;
  // サウンドファイル読み込み
  player = minim.loadFile("hirihiri - sound leakage 2020 - 06 fountains.mp3", fftSize);
  // loop 再生
  player.loop();
  // FFTオブジェクト生成
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

float pastX = -1000;
int[] color_noise = {254,37,1};
int[] color_low = {18 ,63 ,103};
int[] color_middle = {53, 105, 154};
int[] color_high = {65, 138, 180};
Boolean is_high = true;
Boolean is_clap = false;

void draw() {
  if(!is_high) {
    background(0);
  }
  noStroke();
  // FFT解析
  fft.forward(player.mix);
  float low = 0;
  float middle = 0;
  float high = 0;
  for (int i = 0;i < fft.specSize(); i++) {
    float x = map(i, 0, fft.specSize(), 0, 10);
    if(x < 2) {
      low += fft.getBand(i); 
    } else if (x < 5) {
      middle += fft.getBand(i);
    } else {
      high += fft.getBand(i);
    }
  }
  if(is_high) {
    fill(color_noise[0], color_noise[1], color_noise[2], 50);
    for(int i=0; i<high*3; i++) {
      float x = random(width);
      float y = random(height);
      rect(x, y, 5, 5);
    }
  } else {
    fill(color_low[0], color_low[1], color_low[2], 100);
    rect(0, 0, low, height);
    fill(color_middle[0], color_middle[1], color_middle[2], 100);
    rect(width*2/10, 0, middle, height);
    fill(color_high[0], color_high[1], color_high[2], 100);
    rect(width*5/10, 0, high, height);
  }
   
  if(!is_high && is_clap) {
    fill(100, 198, 196, 200);
    
    // 左chのレベルを取得
    //float radiusL = player.left.level() * width;
    float radiusL = high;
    // 右chのレベルを取得
    float radiusR = middle;
    // レベルを半径にして円を描画
    float val = randomGaussian();
    float sd = 80;
    float xm = width/2;
    float xL = ( val * sd ) + xm;
    float yL = (0.5+randomGaussian()) * height/3;
    float xR = pastX;
    float yR = (0.5+randomGaussian()) * height*2/3;
    ellipse(xL, yL, radiusL, radiusL);
    ellipse(xR, yR, radiusR, radiusR);
    pastX = xL;
  }
  
  stroke(255);
  // 現在のプレイヤーにバッファーしたサンプルの数だけ繰り返し
  for (int i=0; i < player.bufferSize()-1; i++) {
    // 画面に大きさに合わせて座標を調整
    float x1 = map(i, 0, player.bufferSize(), 0, width);
    float x2 = map(i+1, 0, player.bufferSize(), 0, width);
    float y1 = height / 2;
    // 波形を描画
    if(is_high)
      line(x1, y1+player.left.get(i)*400, x2, y1+player.left.get(i+1)*400);
    else
      line(x1, y1+player.left.get(i) * 100, x2, y1+player.left.get(i+1)*100);
  }
}

void keyPressed() {
  if (key == CODED) {      // コード化されているキーが押された
    if (keyCode == LEFT) {    // キーコードを判定
       is_high = false;
    } else if (keyCode == RIGHT) {
       is_high = true;
    } else if (keyCode == DOWN) {
       is_clap = true;
    } else if (keyCode == UP) {
      is_clap = false;
    } else if (keyCode == SHIFT) {
      background(255);
    }
  }
}

void stop(){
  player.close();
  minim.stop();
  super.stop();
}
