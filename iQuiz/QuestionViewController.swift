//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Ben Basinski on 2/20/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

class QuizQuestion {
    var text: String
    var answers: [String]
    var correct: Int
    
    init(question: String, possibleAnswers: [String], trueAnswer: Int) {
        text = question
        answers = possibleAnswers
        correct = trueAnswer
    }
}

class QuizAnswer {
    var title: String? = nil
    
    init(title: String) {
        self.title = title
    }
}

class QuizAnswerDataSource : NSObject, UITableViewDataSource {
    var data: [QuizAnswer] = []
    
    init(_ elements: [QuizAnswer]) {
        data = elements
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizAnswers")!
        
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
}

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionTableView: UITableView!
    
    var quizAnswerDataSource: QuizAnswerDataSource? = nil
    
    var currentQuestion: Int = 0
    var questions: [QuizQuestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        questionText.text = questions[currentQuestion].text
        
        let answers = questions[currentQuestion].answers.map{ QuizAnswer(title: $0) }
        self.quizAnswerDataSource = QuizAnswerDataSource(answers)
        questionTableView.dataSource = self.quizAnswerDataSource
    }
    
    @IBAction func onConfirm(_ sender: Any) {
        let selectedAnswer = questionTableView.indexPathForSelectedRow?.item ?? -1
        
        NSLog("answer selected \(selectedAnswer + 1)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
