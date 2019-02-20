//
//  ViewController.swift
//  iQuiz
//
//  Created by Ben Basinski on 2/8/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

class QuizTopic {
    var title: String? = nil
    var description: String? = nil
    var image: UIImage? = nil
    
    init(title: String, description: String, image: UIImage) {
        self.title = title
        self.description = description
        self.image = image
    }
}

class QuizTopicDataSource : NSObject, UITableViewDataSource {
    var data: [QuizTopic] = []
    
    init(_ elements: [QuizTopic]) {
        data = elements
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizTopics")!
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = data[indexPath.row].description
        cell.imageView?.image = data[indexPath.row].image
        
        return cell
    }
}

class QuizTopicDelegate : NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.window?.rootViewController?.performSegue(withIdentifier: "showQuestion", sender: tableView)
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var quizTopicTable: UITableView!

    var quizTopicDataSource: QuizTopicDataSource? = nil
    var quizTopicDelegate: QuizTopicDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let mathTopic = QuizTopic(title: "Mathematics", description: "A quiz about math stuffs", image: #imageLiteral(resourceName: "MathIcon"))
        let marvelTopic = QuizTopic(title: "Marvel Super Heros", description: "A quiz about Marvel characters", image: #imageLiteral(resourceName: "MarvelIcon"))
        let scienceTopic = QuizTopic(title: "Science", description: "A quiz about science stuffs", image: #imageLiteral(resourceName: "ScienceIcon"))
        
        quizTopicDataSource = QuizTopicDataSource([mathTopic, marvelTopic, scienceTopic])
        quizTopicTable.dataSource = quizTopicDataSource
        quizTopicDelegate = QuizTopicDelegate()
        quizTopicTable.delegate = quizTopicDelegate
    }

    // on settings click
    @IBAction func settings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings go here", message:
            nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}

