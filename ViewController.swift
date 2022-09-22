//
//  ViewController.swift
//  Scifi Q&A
//
//  Created by Jube on 2022/9/19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var numberOfQ: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextBtnOutlet: UIButton!
    var questionIndex = 0
    var score = 0
    var questionArray = [Question]()
    var rightAnswer = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let question1 = Question(description: "哪部電影不是科幻電影？", answer: "《神鬼交鋒 Catch Me If You Can》", options: ["《星際效應Intersteller》","《神鬼交鋒 Catch Me If You Can》","《銀翼殺手Blade Runner》"])
        questionArray.append(question1)
        let question2 = Question(description: "此三位導演誰沒拍過科幻片？", answer: "魏斯·安德森 Wes Anderson", options: ["克里斯多福·諾蘭 Christopher Nolan","魏斯·安德森 Wes Anderson","雷利·史考特 Ridley Scott"])
        questionArray.append(question2)
        let question3 = Question(description: "哪個選項不是科幻元素？", answer: "軍火庫", options: ["軍火庫","外星人","人工智慧"])
        questionArray.append(question3)
        let question4 = Question(description: "科幻的英文縮寫為？", answer: "Sci-fi", options: ["Science fiction","Sci-fi","Fi-Sci"])
        questionArray.append(question4)
        let question5 = Question(description: "關於電影《全面啟動Inception》哪項為錯？", answer: "主角是李奧納多迪卡皮丘", options: ["主角是李奧納多迪卡皮丘","開放式結局","導演是諾蘭"])
        questionArray.append(question5)
        let question6 = Question(description: "哪部電影不是諾蘭的作品？", answer: "《沙丘Dune》", options: ["《星際效應Intersteller》","《沙丘Dune》","《全面啟動Inception》"])
        questionArray.append(question6)
        let question7 = Question(description: "哪位明星沒參與過科幻電影演出？", answer: "小賈斯汀 Justin Bieber", options: ["安·海瑟薇 Ann Hathaway","雷恩·葛斯林 Ryan Gosling","小賈斯汀 Justin Bieber"])
        questionArray.append(question7)
        let question8 = Question(description: "哪部科幻電影的主角不是布萊德·彼特Brad Pitt?", answer: "《星際效應Interstellar》", options: ["《星際救援Ad Astra》","《星際效應Interstellar》","《末日之戰 World War Z》"])
        questionArray.append(question8)
        let question9 = Question(description: "哪部電影不是雷利·史考特 Ridley Scott導演的？", answer: "《星際大戰Star wars》", options: ["《普羅米修斯Prometheus》","《異形Alien》","《星際大戰Star wars》"])
        questionArray.append(question9)
        let question10 = Question(description: "哪部科幻電影Jube不喜歡？", answer: "都喜歡", options: ["《普羅米修斯Prometheus》","《銀翼殺手Blade Runner》","都喜歡"])
        questionArray.append(question10)
        questionArray.shuffle()
        putAnswer(number: 0)
        rightAnswer = questionArray[0].answer
    }

    @IBAction func redoBtn(_ sender: Any) {
        questionIndex = 0
        score = 0
        questionArray.shuffle()
        putAnswer(number: 0)
        syncScoreAndLabel(scoreText: "0", numberOfQuestion: 1)
        hideOptions(hide: false)
        nextBtnOutlet.isHidden = false
    }
    @IBAction func nextBtn(_ sender: Any) {
        questionIndex = (questionIndex + 1) % questionArray.count
        // 重返回第一題
        if questionIndex == 0 {
            questionLabel.text = "恭喜你獲得\(score)分!"
            questionIndex = 1
            hideOptions(hide: true)
            nextBtnOutlet.isHidden = true
        } else{
            putAnswer(number: questionIndex)
            rightAnswer = questionArray[questionIndex].answer
            numberOfQ.text = String(format: "%02d" + "/10", questionIndex+1)
            hideOptions(hide: false)
        }
    }
    //填入題目與答案選項
    func putAnswer(number: Int) {
        questionLabel.text = questionArray[number].description
        for i in 0...2 {
            //答案選項丟進按鈕title
            answerButtons[i].setTitle(questionArray[number].options[i], for: .normal)
        }
        rightAnswer = questionArray[number].answer
    }
    
    @IBAction func correctAnswer(_ sender: UIButton) {
        questionIndex = (questionIndex + 1) % questionArray.count
        let userAnswer = sender.currentTitle!
        if questionIndex == 0{
            if userAnswer == rightAnswer {
                score += 10
                questionLabel.text = "恭喜你獲得\(score)分!"
                scoreLabel.text = String(score)
                questionIndex = 1
                nextBtnOutlet.isHidden = true
            } else {
                score -= 5
                questionLabel.text = "恭喜你獲得\(score)分!"
                scoreLabel.text = String(score)
                questionIndex = 1
                nextBtnOutlet.isHidden = true
            }
            hideOptions(hide: true)
        } else if score < 100 {
            if userAnswer == rightAnswer {
                score += 10
                syncScoreAndLabel(scoreText: String(score), numberOfQuestion: questionIndex+1)
                putAnswer(number: questionIndex)
            } else if score > 5 {
                score -= 5
                syncScoreAndLabel(scoreText: String(score), numberOfQuestion: questionIndex+1)
                putAnswer(number: questionIndex)
            } else {
                numberOfQ.text = String(format: "%02d" + "/10", questionIndex+1)
                putAnswer(number: questionIndex)
            }
        }
    }
    
    func syncScoreAndLabel(scoreText: String, numberOfQuestion: Int){
        scoreLabel.text = scoreText
        numberOfQ.text = String(format: "%02d" + "/10", numberOfQuestion)
    }
    func hideOptions(hide: Bool){
        for i in 0...2 {
            answerButtons[i].isHidden = hide
        }
    }
}

