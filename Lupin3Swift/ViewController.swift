//
//  ViewController.swift
//  Lupin3Swift
//
//  Created by MAEDAHAJIME on 2015/07/07.
//  Copyright (c) 2015年 MAEDA HAJIME. All rights reserved.
//

import UIKit
import AudioToolbox

//static:数値が破棄されずに残る 加算される
struct GlobalData {
    //var
    static var idx:Int = 0
}

class ViewController: UIViewController {

    let LUPIN_TITLE:NSString = "ルパン三世";
    
    @IBOutlet weak var lbTitole: UILabel!
    
    // システムサウンド
    var _ssId01:SystemSoundID = 0
    var _ssId02:SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 音準備処理
        self.doReady()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // タイム
    func time(timer: NSTimer){
        
        // LUPIN_TITLEの文字数
        if (GlobalData.idx  < LUPIN_TITLE.length) {
            
            // １文字処理抜き取り
            // NSMakeRangeと同じ　構造体
            var rng: NSRange = NSRange(location:GlobalData.idx,length:1)
            
            // 定数：LUPIN_TITLE = @"ルパン三世";
            var str:NSString = LUPIN_TITLE .substringWithRange(rng)
            
            //println(" \(str)文字：\(GlobalData.idx)")
            
            // １文字処理抜き取り
            self.lbTitole.text = str as String;
            
            // フォントサイズ変更
            self.lbTitole.font = UIFont(name: "Arial Rounded MT Bold", size: 200.0)
            
            // 効果音１再生　カシャ
            AudioServicesPlaySystemSound(_ssId01)
            
            // 文字インデックス
            GlobalData.idx++
            
            
        } else {
            // 最後の処理
            
            // 全文字ラベル表示
            self.lbTitole.text = "ルパン三世"
            
            // フォントサイズ変更
            self.lbTitole.font = UIFont(name: "Arial Rounded MT Bold", size: 100.0)
            
            // 効果音2再生
            AudioServicesPlaySystemSound(_ssId02)
            
            // タイマー停止
            timer.invalidate()
            
            // 文字インデックス　クリア
            GlobalData.idx = 0
        }
    }

    // 画面タップ時
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        // タイマー起動
        var timer:NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.2,
            target: self,
            selector: Selector("time:"),
            userInfo: nil,
            repeats: true)
        
        // タイマーを開始、再開
        timer.fire()
    }
    
    // 音準備処理
    func doReady(){
        
        // サウンドデータの読み込み
        let url01 = NSURL(fileURLWithPath: NSBundle.mainBundle()
                                .pathForResource("Sound01", ofType: "wav")!)
        
        AudioServicesCreateSystemSoundID(url01, &_ssId01)
        AudioServicesPlaySystemSound ( _ssId01 )
        
        
        // サウンドデータの読み込み
        let url02 = NSURL(fileURLWithPath: NSBundle.mainBundle()
                                .pathForResource("Sound02", ofType: "wav")!)
        
        AudioServicesCreateSystemSoundID(url02, &_ssId02)
        AudioServicesPlaySystemSound ( _ssId02 )
    }

}

/*
Swift:サウンド（効果音）を再生するサンプルコード
http://www.sirochro.com/note/swift-sound-play-sample/

スイフトでシステムサウンドを再生する
http://qiita.com/hideji2/items/e7ed482ccffef2c0f66c

*/
