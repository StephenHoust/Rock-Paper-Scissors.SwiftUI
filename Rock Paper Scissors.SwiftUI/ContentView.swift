//
//  ContentView.swift
//  Rock Paper Scissors.SwiftUI
//
//  Created by Stephen Houst on 10/24/22.
//

import SwiftUI

struct ContentView: View {
    enum gameMoves: String, CaseIterable, Identifiable {
        case rock
        case paper
        case scissors
        
        var id: gameMoves { self }
    }
    
    @State private var playerScore = 0
    @State private var numberOfRounds = 0
    @State private var shouldWin = Bool.random()
    @State private var opponentMove = gameMoves.allCases.randomElement()!
    
    var playerGoal: String {
        if shouldWin {
            return "WIN"
        } else {
            return "LOSE"
        }
    }
    
    func moveEmoji(move: gameMoves) -> String {
        switch move {
        case .rock: return "🪨"
        case .paper: return "📃"
        case .scissors: return "✂️"
        }
    }
    
    func setupRound() -> Void {
        opponentMove = gameMoves.allCases.randomElement()!
        
        if numberOfRounds == 0 {
            shouldWin = Bool.random()
        } else {
            shouldWin.toggle()
        }
    }
    
    func selectMove(move: gameMoves) -> Void {
        
    }
    
    var body: some View {
        VStack {
            Text("Rock Paper Scissors").font(.largeTitle)
                .padding()
            Text("Score: \(playerScore)")
                .padding()
            Text("Opponent's Move: ") + Text(moveEmoji(move: opponentMove)).font(.largeTitle)
            Text("Goal this round: \(playerGoal)")
                .padding()
            ForEach (gameMoves.allCases) { move in
                Button(moveEmoji(move: move)) {
                    selectMove(move: move)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
