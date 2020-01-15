//
//  TTTBrain.swift
//  Provides logic and data storage for Tic-Tac-Toe.
//  Game size customizable via BOARD_SIZE constant.
//
//  Created by Andrew Burke on 1/10/20.
//  Copyright © 2020 Andrew Burke. All rights reserved.
//

import Foundation
public class TTTBrain {
    private let BOARD_SIZE = 3
    private var board = [[String]]()
    private var currentPlayer = "X"
    private var totalMoves = 0
    
    /**
     Default initializer, fills the board with underscores.
    */
    public init() {
        board = Array(repeating: Array(repeating: "_", count: BOARD_SIZE), count: BOARD_SIZE)
        totalMoves = BOARD_SIZE * BOARD_SIZE
    }
    
    public func getTokenAtRowAndCol(row:Int, col:Int) -> String {
        return board[row][col]
    }
    
    /**
     Checks to see if a given move is in bounds and legal.
     - parameters:
        - row: an Int value for the intended row coordinate in the range 0..<BOARD_SIZE
        - col: an Int value for the intended column coordinate in the range 0..<BOARD_SIZE
     - returns: Bool, true if the given coordinates are unoccupied.
     */
    public func checkForLegalMoveAtRowAndCol(row:Int, col:Int) -> Bool {
        return row >= 0 && row < BOARD_SIZE &&
                col >= 0 && col < BOARD_SIZE &&
                board[row][col] == "_"
    }
    
    public func placeTokenAtRowAndCol(row:Int, col:Int) {
        board[row][col] = currentPlayer
        totalMoves -= 1
    }
    
    public func getBoardSize() -> Int {
        return BOARD_SIZE
    }
    
    public func getMovesRemaining() -> Int {
        return totalMoves
    }
    
    public func getCurrentPlayer() -> String {
        return currentPlayer
    }
    
    public func switchPlayer() {
        currentPlayer = currentPlayer == "X" ? "O" : "X"
    }
    
    public func resetBrain() {
        for r in 0..<BOARD_SIZE {
            for c in 0..<BOARD_SIZE {
                board[r][c] = "_"
            }
        }
        currentPlayer = "X"
        totalMoves = BOARD_SIZE * BOARD_SIZE
    }
    
    public func checkForDraw() -> Bool {
        return totalMoves == 0
    }
    
    public func checkForWinner() -> Bool {
        for r in 0...BOARD_SIZE-1 {
            var count = 0
            for c in 0...BOARD_SIZE-1 {
                if(board[r][c] == currentPlayer) {
                    count += 1
                }
            }
            if count == BOARD_SIZE {
                return true
            }
        }
        
        for c in 0...BOARD_SIZE-1 {
            var count = 0
            for r in 0...BOARD_SIZE-1 {
                if(board[r][c] == currentPlayer) {
                    count += 1
                }
            }
            if count == BOARD_SIZE {
                return true
            }
        }
        
        var countTL = 0, countBL = 0
        for i in 0...BOARD_SIZE-1 {
            if(board[i][i] == currentPlayer) {
                countTL += 1
            }
            if(board[board.count-1-i][i] == currentPlayer) {
                countBL += 1
            }
        }
        if countTL == BOARD_SIZE || countBL == BOARD_SIZE {
            return true
        }
        
        return false
    }
}
