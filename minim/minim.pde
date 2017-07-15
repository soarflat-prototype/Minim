/**
 * MinimのAudioPlayerを利用してファイルを再生するサンプル
 */

// Minimをインポートする
import ddf.minim.*;

Minim minim;

/**
 * AudioPlayerはサウンドファイルをディスクやインターネット、ストーリンミングから
 * 再生する自己完結型の方法を提供する
 * ファイル再生、ループなどのメソッドを提供する
 */
AudioPlayer player;

void setup() {
    size(512, 200, P3D);

    // thisをMinimに渡して、データディレクトリからファイルをロードできるようにする
    minim = new Minim(this);

    // ロードするファイルそ指定、絶対パスやURLも指定できる
    player = minim.loadFile("sample.mp3");
}

void draw() {
    background(0);
    stroke(255);
    text("bufferSize" + player.bufferSize(), 10, 40 );

    /**
     * player.bufferSize()で返されるサウンドオブジェクトのバッファサイズを元に波形を描画する
     * player.left.get()とplayer.right.get()によって返される値は-1と1の間にあり,
     * 波形を描画するためにはwindowの高さに応じてスケールする必要がある
     * player.left.get()とplayer.right.get()で左右のサンプルを取得できる
     * モノラルの場合はどちらとも同じ値になる
     */
    for (int i = 0; i < player.bufferSize() - 1; i++) {
        /**
         * 描画を開始するy位置を指定
         */ 
        float startY = 50;
        float startY2 = 150;

        /**
         * map関数を利用して描画を開始するx位置をスケーリングする
         * 
         * map関数はある範囲から別の範囲に数値を再マップする関数
         * @example
         *   map(50, 0, 100, 0, 200) 
         *   return 100
         * 0~100の範囲で50の数値を、0~200の範囲の数値に再マップするので100になる
         */ 
        float x1 = map(i, 0, player.bufferSize(), 0, width);
        float x2 = map(i + 1, 0, player.bufferSize(), 0, width);

        /**
         * 描画する波形の大きさをスケーリングする
         * player.left.get()とplayer.right.get()によって返される値は-1と1の間にあり
         * 50を乗算するため、-50~50の値が格納される
         */ 
        float y1GotLeft = player.left.get(i) * 50;
        float y2GotLeft = player.left.get(i + 1) * 50;
        float y1GotRight = player.right.get(i) * 50;
        float y2GotRight = player.right.get(i + 1) * 50;

        /**
         * x座標: x1、y座標: y1GotLeftから
         * x座標: x2、y座標: y2GotLeftに向かって線を引く
         */ 
        line(x1, startY　+ y1GotLeft, x2, startY + y2GotLeft);
        line(x1, startY2 + y1GotRight, x2, startY2 + y2GotRight);
    }

    /**
     * 曲の再生が現在どこにあるかを示す線を描画する
     * player.position()で現在の再生位置（ミリ秒）を取得
     * player.length()でサウンドの長さ（ミリ秒）を取得
     * 現在の再生位置とサウンドの長さを利用し、描画位置をmap関数でスケーリングする
     */
    float posX = map(player.position(), 0, player.length(), 0, width);
    stroke(0, 200, 0);
    line(posX, 0, posX, height);

    /**
     * 曲を再生中かどうかでテキスト出し分け
     */
    if (player.isPlaying()) {
        text("Press any key to pause playback.", 10, 20 );
    } else {
        text("Press any key to start playback.", 10, 20 );
    }
}

void keyPressed() {
    if (player.isPlaying()) {
        player.pause();
    } else if (player.position() == player.length()) {
        player.rewind();
        player.play();
    } else {
        player.play();
    }
}
