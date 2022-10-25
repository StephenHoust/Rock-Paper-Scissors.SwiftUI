//
//  ContentView.swift
//  Rock Paper Scissors.SwiftUI
//
//  Created by Stephen Houst on 10/24/22.
//

import SwiftUI

struct ContentView: View {
    enum gameMoves: String, CaseIterable, Identifiable {
        case rock, paper, scissors
        
        var id: gameMoves { self }
    }
    
    @State private var playerScore = 0
    @State private var numberOfRounds = 0
    @State private var shouldWin = Bool.random()
    @State private var opponentMove = gameMoves.allCases.randomElement()!
    
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = ""
    
    var correctInput: gameMoves {
        switch opponentMove {
        case .rock:
            switch shouldWin {
            case true: return .paper
            case false: return .scissors
            }
            
        case .paper:
            switch shouldWin {
            case true: return .scissors
            case false: return .rock
            }
            
        case .scissors:
            switch shouldWin {
            case true: return .rock
            case false: return .paper
            }
        }
    }
    
    func moveEmoji(move: gameMoves) -> String {
        switch move {
        case .rock: return "🪨"
        case .paper: return "📃"
        case .scissors: return "✂️"
        }
    }
    
    func newGame() {
        playerScore = 0
        numberOfRounds = 0
        setupRound()
    }
    
    func setupRound() {
        opponentMove = gameMoves.allCases.randomElement()!
        shouldWin.toggle()
    }
    
    func selectMove(playerMove: gameMoves) {
        if playerMove == correctInput {
            scoreTitle = "Correct!"
            playerScore += 1
        } else {
            scoreTitle = "Incorrect!"
            playerScore -= 1
        }
        
        numberOfRounds += 1
        
        if numberOfRounds >= 8 {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    
    var body: some View {
        VStack {
            Text("Rock Paper Scissors").font(.largeTitle)
                .padding()
            Text("Score: \(playerScore)")
                .padding()
            Text("Opponent's Move: ") + Text(moveEmoji(move: opponentMove)).font(.largeTitle)
            Text("Goal this round: \(shouldWin ? "WIN" : "LOSE")")
                .padding(.bottom)
            
            ForEach (gameMoves.allCases) { move in
                Button(moveEmoji(move: move)) {
                    selectMove(playerMove: move)
                }
                .font(.largeTitle)
                .padding(.vertical)
                .frame(minWidth: 150)
                .foregroundStyle(.primary)
                .background(Color.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
            }
            Spacer()
        }
        .padding()
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: setupRound)
        } message: {
            Text(scoreTitle == "Correct!"
                 ? "Good job!"
                 : "The correct answer was \(moveEmoji(move: correctInput))."
            )
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("New Game", action: newGame)
        } message: {
            Text("\(scoreTitle) Your final score was \(playerScore)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
