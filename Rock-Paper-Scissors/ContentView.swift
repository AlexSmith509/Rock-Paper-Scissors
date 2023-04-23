//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Alex Smith on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var game = GameOption.allCases
    @State private var shouldWin = false
    @State private var didWin = false
    @State private var correctAnswer = GameOption.rock
    @State private var computerItem = GameOption.rock
    @State private var score = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 20){
                Text(gameOptionToString(option: computerItem))
                    .font(.headline)
                    .onAppear {
                        computerItem = game[Int.random(in: 0...2)]
                    }
                Text("\(shouldWin ? "Win": "Lose")")
                    .onAppear {
                        shouldWin = Bool.random()
                    }
                ForEach(0..<3) { number in
                    Button {
                        gameFunction(selectedItem: game[number])
                    } label: {
                        Text(gameOptionToString(option: game[number]))
                    }
                }
                Text(score.description)
                    .alert(alertMessage, isPresented: $showAlert) {
                        if alertMessage ==  "New Score!" {
                            Button("\(didWin ? "Correct": "Incorrect")", role: .cancel) {
                            }
                        } else  {
                            Button("You Won!", role: .cancel) {
                                
                            }
                        }
                    }
            }
            .foregroundColor(.white)
            .font(.title)
        }
        
       
    }
    
    func gameOptionToString(option: GameOption) -> String {
        switch option {
        case .rock:
            return "Rock"
        case .scissors:
            return "Scissors"
        case .paper:
            return "Paper"
        }
    }
    
    func reset() {
        score = 0 
    }

    func gameFunction(selectedItem: GameOption) {
        if computerItem == .rock {
            if shouldWin {
                correctAnswer = .paper
            } else {
                correctAnswer = .scissors
            }
        } else if computerItem == .scissors {
            if shouldWin {
                correctAnswer = .rock
            } else {
                correctAnswer = .paper
            }
        } else if computerItem == .paper {
            if shouldWin {
                correctAnswer = .scissors
            } else {
                correctAnswer = .rock
            }
        }
        if correctAnswer == selectedItem {
            score += 1
            didWin = true
        } else {
            didWin = false
        }
        showAlert.toggle()
        if score == 3 {
            reset()
            alertMessage = "Game Over!"
        } else {
            alertMessage = "New Score!"
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

