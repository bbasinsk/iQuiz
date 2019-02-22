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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        DispatchQueue.global().async {
            self.loadQuizzes(url: self.currentUrl)
        }
        
    }
    
    private func loadQuizzes(url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let qData = try JSONDecoder().decode([QuizData].self, from: data)

                //Get back to the main queue
                DispatchQueue.main.async {
                    self.quizzes = qData
                    self.tableView.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
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
