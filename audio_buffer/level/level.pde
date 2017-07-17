/**
 * level()から取得した値を描画するサンプル
 */

// Minimをインポートする
import ddf.minim.*;

Minim minim;
AudioPlayer player;

// 描画するバーのwidth
float barWidth = 100;

void setup() {
    size(300, 400);

    // Minimにthisを渡して、データディレクトリからファイルをロードできるようにする
    minim = new Minim(this);
    
    // サウンドファイルをロードする、第2引数にbufferSizeを指定（デフォルトは1024）
    player = minim.loadFile("sample.mp3", 1024);
    player.loop();

    /**
     * setGain()などに指定できる値は端末によって異なる
     * printControls()を利用できればどの範囲の値が有効なのか閣下鵜人できる
     */
    player.printControls();

    // Minimにthisを渡して、データディレクトリからファイルをロードできるようにする
    player.setGain(-10);
}

void draw() {
    background(0);

    noStroke();
    fill(255);

    /**
     * level()から取得した値をセットする
     * 取得できる値は、バッファの値の総量を二乗平均平方根にしたもの
     * 簡単に言ってしまえば、バッファの送料が大きければ、level()から取得できる値も大きい
     * 取得できる値の範囲は0~1のため、スケーリングする必要がある
     */
    float leftLevel = player.left.level();
    float rightLevel = player.right.level();

    rect(0, height, barWidth, -leftLevel * height);
    rect(width - barWidth, height, barWidth, -rightLevel * height);
}
