//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Artemas Radik on 5/16/20.
//  Copyright © 2020 AJ Radik. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    let brain = TTTBrain()
    var gameBoardIsLocked = false
    
    var buttons: [WKInterfaceButton] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        buttons.append(ref0)
        buttons.append(ref1)
        buttons.append(ref2)
        buttons.append(ref3)
        buttons.append(ref4)
        buttons.append(ref5)
        buttons.append(ref6)
        buttons.append(ref7)
        buttons.append(ref8)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        reset()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    //top left tag 0
    @IBOutlet weak var ref0: WKInterfaceButton!
    @IBAction func tag0() {
        boardButtonWasPressed(ref0, tag: 0)
    }
    
    //top mid tag 1
    @IBOutlet weak var ref1: WKInterfaceButton!
    @IBAction func tag1() {
        boardButtonWasPressed(ref1, tag: 1)
    }
    
    
    //top right tag 2
    @IBOutlet weak var ref2: WKInterfaceButton!
    @IBAction func tag2() {
        boardButtonWasPressed(ref2, tag: 2)
    }
    
    //mid left tag 3
    @IBOutlet weak var ref3: WKInterfaceButton!
    @IBAction func tag3() {
        boardButtonWasPressed(ref3, tag: 3)
    }
    
    //mid mid tag 4
    @IBOutlet weak var ref4: WKInterfaceButton!
    @IBAction func tag4() {
        boardButtonWasPressed(ref4, tag: 4)
    }
    
    
    //mid right tag 5
    @IBOutlet weak var ref5: WKInterfaceButton!
    @IBAction func tag5() {
        boardButtonWasPressed(ref5, tag: 5)
    }
    
    //bottom left tag 6
    @IBOutlet weak var ref6: WKInterfaceButton!
    @IBAction func tag6() {
        boardButtonWasPressed(ref6, tag: 6)
    }
    
    //bottom mid tag 7
    @IBOutlet weak var ref7: WKInterfaceButton!
    @IBAction func tag7() {
        boardButtonWasPressed(ref7, tag: 7)
    }
    
    //bottom right tag 8
    @IBOutlet weak var ref8: WKInterfaceButton!
    @IBAction func tag8() {
        boardButtonWasPressed(ref8, tag: 8)
    }
    
    func boardButtonWasPressed(_ sender: WKInterfaceButton, tag: Int) {
        WKInterfaceDevice.current().play(.click)
        
        let row = tag / 3
        let col = tag % 3
        
        if gameBoardIsLocked {return}
        if !brain.checkForLegalMoveAtRowAndCol(row: row, col: col) {return}
        brain.placeTokenAtRowAndCol(row: row, col: col)
        let font = UIFont(name: "LexendDeca-Regular", size: 36)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: brain.getTokenAtRowAndCol(row: row, col: col), attributes: attributes as [NSAttributedString.Key : Any])
        sender.setAttributedTitle(attributedString)
        sender.setBackgroundColor(brain.getCurrentPlayer() == "X" ? UIColor(red: 240/255, green: 14/255, blue: 78/255, alpha: 1) : UIColor(red: 14/255, green: 240/255, blue: 78/255, alpha: 1))
        
        if brain.checkForWinner() {
           
            presentAlert(withTitle: "Game Over", message: "\(brain.getCurrentPlayer()) Won!", preferredStyle: .alert, actions: [WKAlertAction(title: "New Game", style: .default, handler: {self.reset()})])
            
            gameBoardIsLocked = true
            return
        }
        
        if brain.checkForDraw() {
            
            presentAlert(withTitle: "Game Over", message: "Draw", preferredStyle: .alert, actions: [WKAlertAction(title: "New Game", style: .default, handler: {self.reset()})])
            
            gameBoardIsLocked = true
            return
        }

        brain.switchPlayer()
    }
    
    func reset() {
        brain.resetBrain()
        gameBoardIsLocked = false
        
        for button in buttons {
            button.setTitle("")
            button.setBackgroundColor(UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1))
        }
    }
    
}
