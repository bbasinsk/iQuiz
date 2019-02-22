//
//  QuizTopicTableViewController.swift
//  iQuiz
//
//  Created by Ben Basinski on 2/20/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

class QuizData {
    var title: String? = nil
    var desc: String? = nil
    var questions: [QuizQuestion] = []
    
    init(title: String, desc: String, questions: [QuizQuestion]) {
        self.title = title
        self.desc = desc
        self.questions = questions
    }
}


class QuizTopicTableViewController: UITableViewController {
    

    var quizzes: [QuizData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadQuizzes()
    }
    
    private func loadQuizzes() {
        let scienceQuiz = QuizData(
            title: "Science!",
            desc: "Because SCIENCE!",
            questions: [QuizQuestion(
                question: "What is fire?",
                possibleAnswers: [
                    "One of the four classical elements",
                    "A magical reaction given to us by God",
                    "A band that hasn't yet been discovered",
                    "Fire! Fire! Fire! heh-heh"],
                trueAnswer: 1)])
        
        let mathQuiz = QuizData(
            title: "Mathematics",
            desc: "Did you pass the third grade?",
            questions: [
                QuizQuestion(
                    question: "What is 2+2?",
                    possibleAnswers: [
                        "4",
                        "22",
                        "An irrational number",
                        "Nobody knows"],
                    trueAnswer: 1),
                QuizQuestion(
                    question: "What is 4+2?",
                    possibleAnswers: [
                        "22",
                        "6",
                        "An irrational number",
                        "Nobody knows"],
                    trueAnswer: 2)
            ])
        
        quizzes = [scienceQuiz, mathQuiz]
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizTopics", for: indexPath)

        cell.textLabel?.text = quizzes[indexPath.row].title
        cell.detailTextLabel?.text = quizzes[indexPath.row].desc
        cell.imageView?.image = #imageLiteral(resourceName: "QuizIcon")

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showQuestion", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showQuestion") {
            let questionVC = segue.destination as! QuestionViewController;
            questionVC.questions = quizzes[tableView.indexPathForSelectedRow!.item].questions
        }
    }
 
    @IBAction func settingsBtnPress(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings go here", message:
            nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
