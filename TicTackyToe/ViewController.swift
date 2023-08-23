//
//  ViewController.swift
//  TicTackyToe
//
//  Created by AJ Radik on 1/15/20.
//  Copyright © 2020 AJ Radik. All rights reserved.
//

//test

import UIKit
import Mixpanel

class ViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet var board: [DesignableButton]!
    
    let brain = TTTBrain()
    var gameBoardIsLocked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        overrideUserInterfaceStyle = .dark
//        topLabel.font = topLabel.font.withSize( (3.6/71) * UIScreen.main.bounds.height)
        resetButton(nil)
    }

    @IBAction func boardButtonWasPressed(_ sender: DesignableButton) {
        
        let row = sender.tag / 3
        let col = sender.tag % 3
        
        Mixpanel.mainInstance().track(event: "Board Button Pressed", properties: [
            "Row": row,
            "Column": col,
        ])
        
        if gameBoardIsLocked {return}
        if !brain.checkForLegalMoveAtRowAndCol(row: row, col: col) {return}
        brain.placeTokenAtRowAndCol(row: row, col: col)
        sender.setTitle(brain.getTokenAtRowAndCol(row: row, col: col), for: UIControl.State.normal)
        sender.backgroundColor = brain.getCurrentPlayer() == "X" ? UIColor.systemPink : UIColor.systemGreen
        
        if brain.checkForWinner() {
            topLabel.text = "\(brain.getCurrentPlayer()) Won!"
            Mixpanel.mainInstance().track(event: "Game Completed", properties: [
                "Type": "Win",
                "Ender": brain.getCurrentPlayer(),
            ])
            gameBoardIsLocked = true
            return
        }
        
        if brain.checkForDraw() {
            topLabel.text = "Draw!"
            topLabel.textColor = UIColor.label
            Mixpanel.mainInstance().track(event: "Game Completed", properties: [
                "Type": "Draw",
                "Ender": brain.getCurrentPlayer(),
            ])
            gameBoardIsLocked = true
            return
        }

        brain.switchPlayer()
        updateTopLabelForNextMove()
    }
    
    @IBAction func resetButton(_ sender: Any?) {
        
        Mixpanel.mainInstance().track(event: "Game Reset")
        
        brain.resetBrain()
        gameBoardIsLocked = false
        
        for button in board {
            button.backgroundColor = UIColor.secondarySystemFill
            button.setTitle("", for: UIControl.State.normal)
        }
        
        updateTopLabelForNextMove()
    }
    
    func updateTopLabelForNextMove() {
        topLabel.text = "\(brain.getCurrentPlayer())'s Move"
        topLabel.textColor = brain.getCurrentPlayer() == "X" ? UIColor.systemPink : UIColor.systemGreen
    }
    
}
