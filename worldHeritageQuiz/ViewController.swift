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
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    
    // 結果の配列
    var result: [String] = []
    
    // クイズの問題を管理する
    var currentQuestionNum: Int = 0
    
    // 問題を管理
    let questions: [[String: Any]] = [
        ["title": "第1問", "question": "日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。\n\n1. 文化遺産\n2. 自然遺産\n3. 山岳遺産\n4. 伝統遺産",
         "answer": 1, "choice": 4
        ],
        ["title": "第2問", "question": "イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。\n\n1. シュルレアリスム \n2. アバンギャルド \n3. ルネサンス",
         "answer": 3, "choice": 3
        ],
        ["title": "第3問", "question": "2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。\n\n1. コパカバーナの山 \n2. コルコバードの丘",
         "answer": 2, "choice": 2
        ],
    ]
    
    
    
    //   override func viewDidLoad() {
    //       super.viewDidLoad()
    //       showQuestion()    // 下で作成した、問題を表示する関数 showQuestion() を呼び出す
    //   }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // backボタンを「問題へ」に変更
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "問題へ", style: .plain, target: nil, action: nil)
        // カウント初期化
        currentQuestionNum = 0
        // リスト初期化
        result = []
        // 問題を表示する関数 showQuestion() 呼び出し
        showQuestion()
    }
    
    
    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ResultViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToResult", let vc = segue.destination as? ResultTableViewController else {
            return
        }
        vc.result = result
    }
    
    
    // 問題を表示する関数
    func showQuestion() {
        // currentQuestionNum(問題番号)の問題を取得
        let question = questions[currentQuestionNum]    // question に questions[現在のインデックス番号] を代入
        
        // タイトルを取り出す
        if let title = question["title"] as? String {    // question が Any型だから as? でダウンキャスト？
            self.navigationItem.title = title    // これで画面一番上のタイトルが変わる。
        }
        
        // 問題を取り出す
        if let que = question["question"] as? String {
            // question Key の中身を Label に代入
            questionTextView.text = que     // これで questionTextView に取得した問題が表示される。
        }
        
        // 何択の問題かによってボタンの表示数を変える処理
        if let choice = question["choice"] as? Int {
            if choice == 4 {
                button1.isHidden = false
                button2.isHidden = false
                button3.isHidden = false
                button4.isHidden = false
                
            } else if choice == 3 {
                button1.isHidden = false
                button2.isHidden = false
                button3.isHidden = false
                button4.isHidden = true
                
            } else if choice == 2 {
                button1.isHidden = false
                button2.isHidden = false
                button3.isHidden = true
                button4.isHidden = true
            }
        }
    }
    
    
    // 回答をチェックする関数
    func checkAnswer(yourAnswer: Int) {
        // どの問題か取得する
        let question = questions[currentQuestionNum]    // question に questions[現在のインデックス番号] を代入
    
        // 問題の答えを取り出す
        if let ans = question["answer"] as? Int {    // ans に正解の番号を代入
            
            // 選択された答えと問題の答えを比較する
            if yourAnswer == ans {    // yourAnswer には押したボタンの番号が入る。
                // 【正解のとき】
                correctAlert()
                
            } else {
                // 【不正解のとき】
                incorrectAlert()
            }
        }
    }
    
    
    // 正解のアラートを表示する関数
    func correctAlert() {
        // アラートの作成
        let alert = UIAlertController(title: "正解！", message: "次に進みます", preferredStyle: .alert)
        // アラートのアクション（ボタン部分の定義）
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: {
            (action: UIAlertAction!) in
            // 【OKボタンを押したら】
            // インデックス番号を +1 する
            self.currentQuestionNum += 1    // self つけないと怒られる
            
            // 結果リスト追加
            let num = self.currentQuestionNum
            self.result.append("第\(num)問：○")
            
            if self.currentQuestionNum >= self.questions.count {
                // 最後の問題の時
                // 画面遷移する
                self.performSegue(withIdentifier: "ToResult", sender: nil)
                
            } else {
                // 最後の問題ではないとき
                // 次の問題を表示する
                self.showQuestion()
            }
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
        let ok = UIAlertAction(title: "OK", style: .default, handler: {    // style を .cancel にすると壊れる。
            (action: UIAlertAction!) in
            // 【OKボタンを押したら】
            // インデックス番号を +1
            self.currentQuestionNum += 1
            
            // 結果リスト追加
            let num = self.currentQuestionNum
            self.result.append("第\(num)問：✗")
            
            if self.currentQuestionNum >= self.questions.count {
                // 最後の問題のとき
                // 画面遷移する
                self.performSegue(withIdentifier: "ToResult", sender: nil)
                
            } else {
                // 最後の問題ではないとき
                self.showQuestion()
            }
        })
        let turn = UIAlertAction(title: "もういちど", style: .default, handler: nil)    // 「もういちど」を選択した時は何もしない
        
        // 作成した alert にボタンを追加
        // （ボタンはaddした順番に左から表示される！！）
        alert.addAction(turn)
        alert.addAction(ok)
        
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func button1(_ sender: Any) {
        checkAnswer(yourAnswer: 1)
    }
    
    @IBAction func button2(_ sender: Any) {
        checkAnswer(yourAnswer: 2)
    }
    
    @IBAction func button3(_ sender: Any) {
        checkAnswer(yourAnswer: 3)
    }
    
    @IBAction func button4(_ sender: Any) {
        checkAnswer(yourAnswer: 4)
    }
}
