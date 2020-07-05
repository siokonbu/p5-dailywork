import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;
int fftSize;

float pastX = -1000;

void setup() {
  size(640, 480, P2D);
  minim = new Minim(this);
  // fftサイズ設定
  fftSize = 512;
  // サウンドファイル読み込み
  player = minim.loadFile("yuigot+長谷川白紙 - sound leakage 2020 - 24 音がする.mp3", fftSize);
  // loop 再生
  player.loop();
  // FFTオブジェクト生成
  fft = new FFT(player.bufferSize(), player.sampleRate());
}

void draw() {
  background(0);
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
  fill(18 ,63 ,103, 100);
  rect(0, 0, low, height);
  fill(53, 105, 154, 100);
  rect(width*2/10, 0, middle, height);
  fill(65, 138, 180, 100);
  rect(width*5/10, 0, high, height);
  
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
  //ellipse(width*2/5, height/3, radiusL, radiusL);
  //ellipse(width*3/5, height*2/3, radiusR, radiusR);
  ellipse(xL, yL, radiusL, radiusL);
  ellipse(xR, yR, radiusR, radiusR);
  
  stroke(255);
  // 現在のプレイヤーにバッファーしたサンプルの数だけ繰り返し
  for (int i=0; i < player.bufferSize()-1; i++) {
    // 画面に大きさに合わせて座標を調整
    float x1 = map(i, 0, player.bufferSize(), 0, width);
    float x2 = map(i+1, 0, player.bufferSize(), 0, width);
    float y1 = height / 2;
    // 波形を描画
    line(x1, y1+player.left.get(i) * 100, x2, y1+player.left.get(i+1)*100);
    //line(x1, y2+player.right.get(i) * 100, x2, y1+player.right.get(i+1)*100);
  }
  pastX = xL;
}

void stop(){
  player.close();
  minim.stop();
  super.stop();
}
