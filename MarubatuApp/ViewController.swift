//
//  ViewController.swift
//  MarubatuApp
//
//  Created by 高橋康之 on 2021/11/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    
    // 表示中の問題番号を格納
    var currentQuestionNum: Int = 0
    var questions: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = []
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "add") != nil{
            questions = userDefaults.object(forKey: "add") as! [[String: Any]]
        }
        showQuestion()
    }
    
    // 繰り返し処理する
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        let userDefaults = UserDefaults.standard
        //"add"というキーで保存された値がなにかある -> 値をquestionsへ
        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String:Any]]
        }
        showQuestion()
    }

    func showQuestion(){
        if questions.isEmpty == true {
            //問題文が無い時
            questionLabel.text = "問題がありません"
        } else {
            //問題文が有る時
            let question = questions[currentQuestionNum]
            if let que = question["question"] as? String {
                //問題文の表示
                questionLabel.text = que
            }
        }
    }
    
    // 回答をチェックする関数
    // 正解なら次の問題を表示します
    func checkAnswer(yourAnswer: Bool) {
        if questions.isEmpty == true{
            
        } else {
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool {
            if yourAnswer == ans {
                // 正解
                // currentQuestionNumを1足して次の問題に進む
                currentQuestionNum += 1
                showAlert(message: "正解")
            } else {
                // 不正解
                showAlert(message: "不正解")
            }
        } else {
            print("答えが入ってません")
            return
        }
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        // 問題を表示します。
        // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
        }
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func yesButton(_ sender: UIButton) {
        if questions.isEmpty != true {
        checkAnswer(yourAnswer: true)
        } else {
            return
        }
    }
    
    @IBAction func noButton(_ sender: UIButton) {
        if questions.isEmpty != true{
        checkAnswer(yourAnswer: false)
        } else {
            return
        }
    }
    
}
