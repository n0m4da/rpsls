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
    @State private var plays: [String] = ["rock", "paper", "scissors", "lizard", "spock"]
    @State private var playsOG: [String] = ["rock", "paper", "scissors", "lizard", "spock"]
    @State private var playsIcon = ["👊","📄","✁","🦎","👽"]
    @State private var options : [String] = ["2,3", "0,4","1,3","1,4","0,2"]
    
    // MARK: - SCORE PROPERTIES
    @State private var attemps : Int = 0
    @State private var wins : Int = 0
    @State private var draws : Int = 0
    @State private var pcwins: Int = 0
    
    //MARK: - ALERT CONTROL
    @State private var alertScore : Bool  = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
  

    
    func playoption(_ me : Int, _ pc: Int) -> Bool {
        let option = options[me]
        let result = option.contains(String(pc))

        return result
    }
    
    func playScore(_ number: Int){
        
//        alertTitle = "Muggle haha"
//        alertMessage = "you lose this one \n \(wins) vs \(wins - atemps)"
        attemps += 1
        alertScore.toggle()
        tryAgain()
        let textgame = "\n me(\(plays[number])) \(wins) vs \(pcwins) pc(\(plays[computerPlay]))"
        if number == computerPlay{
            draws += 1
            alertTitle = "Dmn!!"
            alertMessage = "incredible, it's a draw "
        }else if playoption(number, computerPlay) {
            
            wins += 1
            alertTitle = "Hmm you won!"
            alertMessage = " \(textgame)"
          
        }else{
            pcwins += 1
            alertTitle = "You lost"
            alertMessage = "Bazinga \(textgame)"
        }
       
        if(attemps == 10){
            alertTitle = "END GAME"
            alertMessage = "Final score \(textgame)"
            attemps = 0
            wins = 0
            pcwins = 0
        }
        
    }
    
    func tryAgain(){
        computerPlay =  Int.random(in: 0...4)
        
    }
    
    //MARK: - alert gonna be deprecated soon
    func alertAtemp() -> Alert{

        Alert(title: Text(alertTitle) , message: Text(alertMessage), dismissButton: .default(Text("\(attemps < 10 ? "Okay" : "Try again")")) )
            
    }
    
    //MARK: - body
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
             Spacer()
                    
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
                Text("Score")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.title)
                Text("\(wins) vs \(pcwins)")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.subheadline)
            Spacer()
                    HStack(alignment: .lastTextBaseline){
                        Text("Attemps: \(attemps)")
                            .frame(width: nil, height: nil, alignment: .trailing)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .font(.footnote)
                    }
                    
                    Spacer()
                }
        }
    }
}

#Preview {
    ContentView()
}
