//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ali on 12/11/23.
//

import SwiftUI

struct FlagImage: View {
    var countries: [String]
    var number: Int
    
    var body: some View {
        Image(countries[number])
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userScore = 0
    
    @State private var feedback = ""
    
    @State private var questionTracker = 1
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
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
                            FlagImage(countries: countries, number: number)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestions)
        } message: {
            Text(feedback)
        }
    }
    
    func flagTapped(_ number: Int) {
        if questionTracker == 8 {
            scoreTitle = "You Scored \(userScore + 1) out of 8"
            feedback = userScore > 4 ? "Your Good" : "You Suck"
            userScore = 0
            questionTracker = 1
        } else if number == correctAnswer {
            scoreTitle = "Correct"
            userScore = userScore + 1
            questionTracker = questionTracker + 1
            print(userScore)
        } else {
            scoreTitle = "Wrong"
            feedback = "That's the Flag of \(countries[number])"
            userScore = userScore - 1
            questionTracker = questionTracker + 1
            print(userScore)
        }
        
        showingScore = true
    }
    
    func askQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        feedback = ""
    }
    
    //    func showResult(_ number: Int) {
    //        if number == 7 {
    //            scoreTitle = "Challenge is finished"
    //            feedback = "Your Score: \(userScore)"
    //        }
    
}


#Preview {
    ContentView()
}
