//
//  ContentView.swift
//  Memorize
//
//  Created by Kafui Kpoh on 30/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojis: Array<String> = []
    
    
    @State var cardCount: Int = 12
    @State var cardColourTheme: Color = .white
    
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            
            ScrollView {
                cards
            }
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Button(action: {
                    emojis = theme(name: "vehicles")
                    cardColourTheme = .orange
                }, label: {
                    VStack {
                        Image(systemName: "car").imageScale(.large)
                        Text("Vehicles")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    emojis = theme(name: "halloween")
                    cardColourTheme = .red
                }, label: {
                    VStack {
                        Image(systemName: "party.popper").imageScale(.large)
                        Text("Halloween")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    emojis = theme(name: "party")
                    cardColourTheme = .yellow
                }, label: {
                    VStack {
                        Image(systemName: "balloon").imageScale(.large)
                        Text("Party")
                    }
                })
            }.padding()
        }
        .padding()
    }
    
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            .imageScale(.large)
//            .font(.largeTitle)
//
//            Spacer()
//
//            cardAdder
//            .imageScale(.large)
//            .font(.largeTitle)
//        }
//    }
//
//    func cardCountAdjusters (by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            cardCount += offset
//
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
    func theme(name: String) -> [String] {
        var emojiList: [String] = []
        
        switch name {
        case "vehicles":
            
            emojiList = ["🚗","🚕","🚌","🏎️","🚚","🚔","🚗","🚕","🚌","🏎️","🚚","🚔"]
            
        case "halloween":
            
            emojiList = ["👻", "🎃", "🕷️", "👹", "💀", "🕸️","👻", "🎃", "🕷️", "👹", "💀", "🕸️"]
            
        case "party":
            
            emojiList = ["🍤","🍕","🍢","🎂","🥳","🪅", "🍤","🍕","🍢","🎂","🥳","🪅"]
            
        default:
            emojiList = []
        }
        
        return emojiList.shuffled()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            
            ForEach(0..<cardCount, id: \.self){ index in
                
                CardView(content: emojis.count > 0 ? emojis[index] : "")
                    .aspectRatio(2/3, contentMode: .fit)
            }
            
        }
        .foregroundColor(cardColourTheme)
    }
//
//    var cardRemover: some View {
//        cardCountAdjusters(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//
//    var cardAdder: some View {
//        cardCountAdjusters(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
                
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
