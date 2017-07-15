/**
 * BeatDetectのSOUND_ENERGYを利用し、ビートを検出して描画に反映させるサンプル
 * サウンドのビートを追跡するためにすべてのフレームでdetect()を呼び出してから
 * isOnset()を実行する必要がある
 */

// Minimをインポートする
import ddf.minim.*;

// BeatDetectクラスが含まれるMinim.analysisパッケージをインポートする
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
BeatDetect beat;

float eRadius;

void setup() {
    size(200, 200, P3D);

    // Minimにthisを渡して、データディレクトリからファイルをロードできるようにする
    minim = new Minim(this);
    
    // サウンドファイルをロードする、第2引数にbufferSizeを指定（デフォルトは1024）
    player = minim.loadFile("sample.mp3", 2048);
    player.play();

    // 10ミリ秒毎のビートを検出インスタンスを生成
    beat = new BeatDetect();

    /**
     * ellipseの座標指定を設定する
     * RADIUSを指定することにより、ellipse(中心のx座標, 中心のy座標, 横半径, 縦半径)になる
     * デフォルトはellipse(中心のx座標, 中心のy座標, 横直径, 縦直径)
     */
    ellipseMode(RADIUS);
    eRadius = 20;
}

void draw() {
    background(0);

    // 解析したいAudioBufferを渡す
    beat.detect(player.mix);

    float a = map(eRadius, 20, 80, 60, 255);

    fill(60, 255, 0, a);

    // ビートが検出できたら半径を更新する
    if (beat.isOnset()) eRadius = 80;

    ellipse(width / 2, height / 2, eRadius, eRadius);

    eRadius *= 0.95;

    if ( eRadius < 20 ) eRadius = 20;
}
