//
//  ContentView.swift
//  guessTheFlag
//
//  Created by Bharath on 06/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var Qnos = 1
    @State private var numberTapped = 0
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score+=1
        }else{
            scoreTitle = "Wrong"
        }
        showingScore = true
        numberTapped = number
        Qnos+=1
    }
    
    func resetGame(){
        Qnos = 0
        score = 0
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)

                VStack(spacing: 20) {
                    Text(countries[correctAnswer]).font(.subheadline.weight(.semibold)).foregroundStyle(.white)
                    VStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number]).clipShape(.capsule).shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity).padding(.vertical, 20).background(.ultraThinMaterial).clipShape(.rect(cornerRadius: 20))
            }
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
        }.alert(scoreTitle, isPresented: $showingScore){
            if Qnos == 9{
                Button("Reset Game"){
                    resetGame()
                }
            }else{
                Button("Continue", action: askQuestion)
            }
        }message: {
            if scoreTitle == "Wrong" {
                Text("That is the flag of \(countries[numberTapped])")
            }
            Text("Your score is \(score)")
        }
    }
}

#Preview {
    ContentView()
}
