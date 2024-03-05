//
//  GridView.swift
//  WatchApp Watch App
//
//  Created by Artemas on 3/4/24.
//

import SwiftUI

struct GridView: View {
    let rows = 3
    let columns = 3
    @State private var showAlert = false
    
    @State var color: Color = .blue

    var body: some View {
        VStack(spacing: 10) { // Vertical stack to hold our rows
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 10) { // Horizontal stack for each row
                    ForEach(0..<columns, id: \.self) { column in
                        Rectangle() // Create a rectangle
                            .aspectRatio(1.0, contentMode: .fit) // Ensure the rectangle remains square
                            .foregroundColor(color) // Set the rectangle color
                            .onTapGesture {
                                color = .red
                                self.showAlert = true
                            }
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Rectangle Tapped"),
                        // Optional: Use the tappedRectangle state to show which rectangle was tapped
                        message: Text("rect was tapped."),
                        dismissButton: .default(Text("OK"))
                    )
                }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
