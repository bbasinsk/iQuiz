//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Ben Basinski on 2/22/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    var numberCorrect: Int = 0
    var questionCount: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var humanReadableScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "\(numberCorrect) out of \(questionCount) correct"
        
        if (numberCorrect == 0) {
            humanReadableScoreLabel.text = "Try again!"
        } else if (numberCorrect == questionCount) {
            humanReadableScoreLabel.text = "Perfect!"
        } else {
            humanReadableScoreLabel.text = "Almost!"
        }
    }
    
}
