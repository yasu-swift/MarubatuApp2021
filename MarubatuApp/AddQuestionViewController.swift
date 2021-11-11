//
//  AddQuestionViewController.swift
//  MarubatuApp
//
//  Created by 高橋康之 on 2021/11/06.
//

import UIKit

class AddQuestionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var AddQuestionText: UITextField!
    @IBOutlet weak var SelectLabel: UISegmentedControl!
    // userが保存した時に内容を入れる配列
    var questions:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddQuestionText.delegate = self
        let userDefaults = UserDefaults.standard
        //"add"というキーで保存された値がなにかある -> 値をtaskArrayへ
        if userDefaults.object(forKey: "add") != nil {
            questions = userDefaults.object(forKey: "add") as! [[String:Any]]
        }
    }

    @IBAction func ReturnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)  //1つ前の画面に戻る
    }
    
    @IBAction func AddButton(_ sender: Any) {
        if AddQuestionText.text != "" {
            var answer:Bool = true
            if SelectLabel.selectedSegmentIndex == 0 {
                answer = false
            } else {
                answer = true
            }
            questions.append(["question":AddQuestionText.text!,"answer":answer])
            let userDefaults = UserDefaults.standard
            userDefaults.set(questions,forKey: "add")
            AddQuestionText.text = ""
            showAlert(message: "問題を保存しました")
            print(questions)
        } else {
            showAlert(message: "問題が未入力です")
        }
    }
    
    @IBAction func DeleteButton(_ sender: Any) {
        questions = []
        let userDefaults = UserDefaults.standard
        userDefaults.set(questions, forKey: "add")
        showAlert(message: "全て削除しました")
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
}
