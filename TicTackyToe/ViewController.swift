//
//  ViewController.swift
//  TicTackyToe
//
//  Created by AJ Radik on 1/15/20.
//  Copyright © 2020 AJ Radik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let brain = TTTBrain()
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet var board: [DesignableButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        topLabel.font = topLabel.font.withSize( (3.6/71) * UIScreen.main.bounds.height)
        resetButton(nil)
    }

    @IBAction func resetButton(_ sender: Any?) {
        brain.resetBrain()
        topLabel.text = "\(brain.getCurrentPlayer())'s Move"
        topLabel.textColor = brain.getCurrentPlayer() == "X" ? UIColor.systemPink : UIColor.systemGreen
    }
    
}

