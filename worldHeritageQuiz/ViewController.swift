//
//  ViewController.swift
//  worldHeritageQuiz
//
//  Created by 吉澤優衣 on 2019/08/12.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionTextView: UITextView!

    // 問題
    
    // クイズの問題を管理する
    var currentQuestionNum: Int = 0
    
    // 問題を管理
    let questions: [[String: Any]] = [
        ["question": "日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。\n1. 文化遺産 \n2. 自然遺産 \n3. 山岳遺産 \n4. 伝統遺産",
         "answer": 1
        ],
        ["question": "イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。\n1. シュルレアリスム \n2. アバンギャルド \n3. ルネサンス",
         "answer": 3
        ],
        ["question": "2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。\n1. コパカバーナの山 \n2. コルコバードの丘",
         "answer": 2
        ],
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()    // 下で作成した、問題を表示する関数 showQuestion() を呼び出す
    }
    
    // 問題を表示する関数
    func showQuestion() {
        // currentQuestionNum(問題番号)の問題を取得
        let question = questions[currentQuestionNum]    // question に questions[現在のインデックス番号] を代入
        
        //問題(辞書型)から Key を指定して内容を取得
        if let que = question["question"] as? String {
            // question Key の中身を Label に代入
            questionTextView.text = que    // questionTextView に取得した問題を表示
        }
    }
    
    
    // 回答をチェックする関数
    // 正解なら次の問題を表示する
    func checkAnswer(yourAnswer: Int) {
        // どの問題か取得する
        let question = questions[currentQuestionNum]    // question に questions[現在のインデックス番号] を代入
        
        // 問題の答えを取り出す
        if let ans = question["answer"] as? Int {    // ans に正解の番号を代入
            
            // 選択された答えと問題の答えを比較する
            if yourAnswer == ans {    // yourAnswer は押したボタンの番号のこと。
                // 【正解のとき】
                correctAlert()    // アラートを表示させる, ボタンタップで次の問題へ
                
                // 最後の問題の時
                if currentQuestionNum > questions.count {
                    // 画面遷移する

                }

            } else {
                // 【不正解のとき】
//                currentQuestionNum += 1
  //
    //            if currentQuestionNum >= questions.count {
                    // 最後の問題の時
                /*                 showAlert(message: "\(questions.count)問中\(result.count)問正解しました！")
                    isHint = false    // ヒント復活
                    currentQuestionNum = 0    // 問題番号リセット
                } else {
                    // 最後の問題ではない時
                    showAlert(message: "不正解...")
                }
            }
            
        }else{
            // エラーをわかりやすくする
            print("答えが入ってません")
            return
                 }*/}
            
        }
    }
    
    
    
    
    
    
    // まだできてないよー
    // 正解のアラートを表示する関数
    func correctAlert() {
        // アラートの作成
        let alert = UIAlertController(title: "正解！", message: "次に進みます", preferredStyle: .alert)
        // アラートのアクション（ボタン部分の定義）
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: {
            (action: UIAlertAction!) in
            self.currentQuestionNum += 1
            self.showQuestion()    // きたーーーーーーーーーーーーーー！！！！！！！！！ こいつここに入れれば次の問題に行ってくれる！！！泣
        })
        // 作成した alert にOKボタンを追加
        alert.addAction(ok)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    
    // 不正解アラートを表示する関数
    func incorrectAlert() {
        // アラートの作成
        let alert = UIAlertController(title: "不正解", message: "次に進みますか？", preferredStyle: .alert)
        // アラートのアクション（ボタン部分の定義）
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let turn = UIAlertAction(title: "もういちど", style: .cancel, handler: nil)
        // 作成した alert にボタンを追加
        alert.addAction(ok)
        alert.addAction(turn)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func button1(_ sender: Any) {
        checkAnswer(yourAnswer: 1)
    }
    
    
    @IBAction func button2(_ sender: Any) {
    }
    
    
    @IBAction func button3(_ sender: Any) {
    }
    
    
    @IBAction func button4(_ sender: Any) {
    }
    
}

