//
//  GridView.swift
//  WatchApp Watch App
//
//  Created by Artemas on 3/4/24.
//

import SwiftUI

struct GridView: View {
    @State private var showAlert = false
    @State private var game = TicTacToe(startingPlayer: .x)
    
    @State var color: Color = .blue
    
    func resolveColor(row: Int, column: Int) -> Color {
        if game.cells[game.index(row: row, column: column)].isEmpty {
            return .gray
        } else {
            if game.cells[game.index(row: row, column: column)].player == .x {
                return .red
            } else {
                return .blue
            }
        }
    }
    
    func resolveMessage() -> String{
        if game.winner == nil {
            return "It was a draw."
        } else if game.winner == .x {
            return "Red wins."
        } else {
            return "Blue wins."
        }
    }

    var body: some View {
        VStack(spacing: 10) { // Vertical stack to hold our rows
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 10) { // Horizontal stack for each row
                    ForEach(0..<3, id: \.self) { column in
                        Rectangle() // Create a rectangle
                            .aspectRatio(1.0, contentMode: .fit) // Ensure the rectangle remains square
                            .foregroundColor(resolveColor(row: row, column: column)) // Set the rectangle color
                            .onTapGesture {
                                if game.cells[game.index(row: row, column: column)].isEmpty {
                                    game.play(at: game.index(row: row, column: column))
                                }
                                if(!game.isOngoing) {
                                    showAlert = true
                                }
                            }
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Game Over"),
                // Optional: Use the tappedRectangle state to show which rectangle was tapped
                message: Text(resolveMessage()),
                dismissButton: .default(Text("OK"), action: {
                    game = TicTacToe(startingPlayer: .x)
                })
            )
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
