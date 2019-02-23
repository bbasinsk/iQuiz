//
//  QuizTopicTableViewController.swift
//  iQuiz
//
//  Created by Ben Basinski on 2/20/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

struct QuizQuestion: Codable {
    var text: String
    var answers: [String]
    var answer: String
}

struct QuizData: Codable {
    var title: String?
    var desc: String?
    var questions: [QuizQuestion]
}

class QuizTopicTableViewController: UITableViewController {
    
    var currentUrl: URL = URL(string: "https://tednewardsandbox.site44.com/questions.json")!
    var quizzes: [QuizData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global().async {
            if (Storage.fileExists("quizzes.json", in: .documents)) {
                self.quizzes = Storage.retrieve("quizzes.json", from: .documents, as: [QuizData].self)
            } else {
                self.loadQuizzes(url: self.currentUrl)
            }
        }
        
    }
    
    private func loadQuizzes(url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                let error = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(error, animated: true, completion: nil)
            }
            
            guard let data = data else { return }

            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let qData = try JSONDecoder().decode([QuizData].self, from: data)

                //Get back to the main queue
                DispatchQueue.main.async {
                    self.quizzes = qData
                    self.tableView.reloadData()
                    if (Storage.fileExists("quizzes.json", in: .documents)) {
                        Storage.remove("quizzes.json", from: .documents)
                    }
                    Storage.store(qData, to: .documents, as: "quizzes.json")
                }
            } catch let jsonError {
                let error = UIAlertController(title: "Error", message: jsonError.localizedDescription, preferredStyle: .alert)
                error.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(error, animated: true, completion: nil)
            }
        }.resume()
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
        performSegue(withIdentifier: "showQuestion", sender: self)
    }


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
        let alertController = UIAlertController(title: "Quiz URL", message: nil, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter json url here..."
        })

        alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            if let url = alertController.textFields?.first?.text {
                print("Json url: \(url)")
                let jsonUrl = URL(string: url)!
                self.loadQuizzes(url: jsonUrl)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
