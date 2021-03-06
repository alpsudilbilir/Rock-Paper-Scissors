//
//  ContentView.swift
//  Rock-Paper-Scissors
//
//  Created by Alpsu Dilbilir on 14.10.2021.
//

import SwiftUI
//Text style that will be used in texts.
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.italic())
            .foregroundColor(.white)
    }
}
extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    let rockPaperScissor = ["rock", "paper", "scissors"]
    //Three boolean parameters for three user choice. This is used for animating and disabling buttons.
    @State private var isClicked1 = false
    @State private var isClicked2 = false
    @State private var isClicked3 = false
    
    //Random numbers that refers rock paper or scissors.
    @State private var gameChoice = Int.random(in: 0...2)
    
    @State private var userScore = 0
    @State private var computerScore = 0
    
    //Background color of computer choice change according the who win the game.
    @State private var changeColor = false

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue, .red]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Score")
                    .titleStyle()
                    .padding(10)
                HStack(spacing: 50){
                    Text("\(userScore)")
                        .titleStyle()
                    Text("-")
                        .titleStyle()
                    Text("\(computerScore)")
                        .titleStyle()
                }
                
                HStack {
                    
                    VStack {
                        //Button that refers rock
                        Button(action: {
                            self.animation1()
                            gameLogic(rockPaperScissor[0])
                            }) {
                            Image("\(rockPaperScissor[0])")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .background(isClicked1 ? Color.green : Color.blue) //Background will be green after clicked.
                                .clipShape(Capsule())
                                .rotationEffect(isClicked1 ? .degrees(0) : .degrees(180)) //Button will turn 180 degree to other side.
                                .animation(.spring())
                                
                            }.disabled(isClicked1 || isClicked2 || isClicked3) //All buttons will be deactived after clicking.
                        
                        //Button that refers paper
                        Button(action: {
                            self.animation2()
                            gameLogic(rockPaperScissor[1])
                            }) {
                            Image("\(rockPaperScissor[1])")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .background(isClicked2 ? Color.green : Color.blue)
                                .clipShape(Capsule())
                                .rotationEffect(isClicked2 ? .degrees(0) : .degrees(180))
                                .animation(.spring())
                            }.disabled(isClicked1 || isClicked2 || isClicked3)
                        
                        //Button that refers scissor
                        Button(action: {
                            self.animation3()
                            gameLogic(rockPaperScissor[2])
                            }) {
                            Image("\(rockPaperScissor[2])")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .background(isClicked3 ? Color.green : Color.blue)
                                .clipShape(Capsule())
                                .rotationEffect(isClicked3 ? .degrees(0) : .degrees(180))
                                .animation(.spring())
                                
                            }.disabled(isClicked1 || isClicked2 || isClicked3)
                    }
                    .padding()
                    
                    VStack {
                        //Image of computer choice.
                        Image("\(rockPaperScissor[gameChoice])")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .background(changeColor ? Color.red : Color.gray)
                            .clipShape(Capsule())
                            .rotationEffect(isClicked1 || isClicked3 || isClicked2 ? .degrees(180) : .degrees(0))
                            .animation(.spring())
                            .padding(1)
                        
                    }
                }
                //Button will reset the round.
                Button(action: {
                    resetRound()
                }){
                    Text("Next Round")
                        .frame(width: 210, height: 75)
                        .font(.largeTitle.italic())
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    
                }
            }
        }
    }
    //Animation for rock button
    func animation1() {
        self.isClicked1.toggle()
        gameChoice = Int.random(in: 0...2) //Again random number chosen for next round.
    }
    
    //Animation for paper button
    func animation2() {
        self.isClicked2.toggle()
        gameChoice = Int.random(in: 0...2) //Again random number chosen for next round.
    }
    
    //Animation for scissor button
    func animation3() {
        self.isClicked3.toggle()
        gameChoice = Int.random(in: 0...2) //Again random number chosen for next round.
    }
    
    //Will reset the round for next round.
    func resetRound() {
        self.isClicked1 = false
        self.isClicked2 = false
        self.isClicked3 = false
        changeColor = false
        
    }
    
    func gameLogic(_ selection: String){
        if selection == rockPaperScissor[gameChoice]{ //When selections same.

        }
        if selection == "rock" && gameChoice == 1 { //When user is rock and game paper
            computerScore += 1
            changeColor = true
        }
        if selection == "rock" && gameChoice == 2 { //When user is rock and game is scissor
            userScore += 1
        }
        if selection == "paper" && gameChoice == 0 { //When user is paper and game is rock
            userScore += 1
        }
        if selection == "paper" && gameChoice == 2 { //When user is paper and game is scissor
            computerScore += 1
            changeColor = true
        }
        if selection == "scissors" && gameChoice == 0 { //When user is scissor and game is rock
            computerScore += 1
            changeColor = true
        }
        if selection == "scissors" && gameChoice == 1 { //When user is scissor and game is paper
            userScore += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
