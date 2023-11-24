//
//  ContentView.swift
//  rpsls
//
//  Created by Luis Rivera on 23/11/23.
//

import SwiftUI


struct ContentView: View {
    
    // MARK: - GAME PROPERTIES
    @State private var computerPlay : Int = Int.random(in: 0...4)
    @State private var userPlay : Int = 0
    @State private var plays: [String] = ["rock", "paper", "scissors", "lizard", "spock"].shuffled()
    @State private var playsOG: [String] = ["rock", "paper", "scissors", "lizard", "spock"]
    @State private var playsIcon = ["👊","📄","✁","🦎","👽"]
    
    // MARK: - SCORE PROPERTIES
    @State private var atemps : Int = 0
    @State private var wins : Int = 0
    
    //MARK: - ALERT CONTROL
    @State private var alertScore : Bool  = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    func playScore(_ number: Int){
        alertTitle = "Muggle haha"
        alertMessage = "you lose this one \n \(wins) vs \(wins - atemps)"
        if number == computerPlay{
            wins += 1
            alertTitle = "Nice!!"
            alertMessage = "incredible, you won this one \n \(wins) vs \(wins - atemps)"
        }
        
        atemps += 1
        alertScore.toggle()
        tryAgain()
    }
    
    func tryAgain(){
        plays.shuffle()
        computerPlay =  Int.random(in: 0...4)
        
    }
    
    //MARK: - alert gonna be deprecated soon
    func alertAtemp() -> Alert{
        Alert(title: Text(alertTitle) , message: Text(alertMessage), dismissButton: .default(Text("\(atemps < 10 ? "Okay" : "Try again")")) )
            
    }
    
    var body: some View {
        ZStack{
            Color.blue
                .frame(width: .infinity, height: .infinity)
                .ignoresSafeArea()
                .background(Color.blue.gradient)
            Image("bazinga")
                .resizable()
                .scaledToFit()
                .blur(radius: 5)
 
                VStack {
                    Text("Choose one!")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    ForEach(0..<playsOG.count, id: \.self){play in
                        Button{
                           
                            playScore(play)
                        }label: {
                            VStack{
                                Text(playsIcon[play])
                                Text(playsOG[play])
                            }
                            .frame(width: 75, height: 75)
                            .foregroundStyle(.black)
                            .fontWeight(.bold)
                            .background(.ultraThickMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                        }
                        .alert(isPresented: $alertScore, content: {
                            self.alertAtemp()
                        })
                    }
                  
                }
        }
    }
}

#Preview {
    ContentView()
}
