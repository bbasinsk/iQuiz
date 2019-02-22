//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Ben Basinski on 2/20/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var currentQuestion: Int = 0
    var questions: [QuizQuestion] = []
    
    var selectedAnswers: [Int] = []
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var correctText: UILabel!
    @IBOutlet weak var answerTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let correctAnswer = questions[currentQuestion].correct
        
        questionText.text = questions[currentQuestion].text
        answerText.text = questions[currentQuestion].answers[correctAnswer - 1]
        correctText.text = selectedAnswers[currentQuestion] == correctAnswer ? "Correct" : "Incorrect"
        answerTitle.title = "Answer #\(currentQuestion + 1)"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if going to a next question, increment the currentQuestion
        if (segue.identifier == "nextQuestion") {
            let questionVC = segue.destination as! QuestionViewController
            questionVC.currentQuestion = self.currentQuestion + 1
            questionVC.questions = self.questions
            questionVC.selectedAnswers = self.selectedAnswers
        }
        if (segue.identifier == "toFinish") {
            let totalCorrect = self.questions
                .map { $0.correct }
                .enumerated()
                .reduce(0, { sum, cur in selectedAnswers[cur.offset] == cur.element ? sum + 1 : sum })

            let finishVC = segue.destination as! FinishViewController
            finishVC.numberCorrect = totalCorrect
            finishVC.questionCount = self.questions.count
        }
    }
 
    @IBAction func onNext(_ sender: Any) {
        if (questions.count > currentQuestion + 1) {
            self.performSegue(withIdentifier: "nextQuestion", sender: self)
        } else {
            self.performSegue(withIdentifier: "toFinish", sender: self)
        }
    }
    
}
