//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Güray Gül on 27.09.2023.
//

import SwiftUI



struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var currentScore = 0
    @State private var questionCounter = 1
    @State private var showFinalScore = false
    
    @State private var countries = allCountries.shuffled()
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(currentScore)")
        }
        
        .alert("Game Over", isPresented: $showFinalScore) {
            Button("Reset the game", action: newGame)
        } message: {
            Text("Your final score was: \(currentScore)")
        }
    }
    func flagTapped(_ number: Int){
        showingScore = true
        
        if number == correctAnswer{
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong! The correct answer was in option: \(correctAnswer + 1)."
            currentScore -= 1
        }
        
        if questionCounter == 8 {
            showFinalScore = true
        }   else {
            showingScore = true
        }

    }
    func askQuestion(){
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func newGame(){
        questionCounter = 0
        currentScore = 0
        countries = Self.allCountries
        askQuestion()
    }
}

#Preview {
    ContentView()
}
