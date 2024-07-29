//
//  ContentView.swift
//  Memorize2024
//
//  Created by Chris Beloglazov on 7/28/24.
//

import SwiftUI

// a View is a rectangular area on screen that draws something. Views are immutable
// Swift is a very strongly typed language, use type inference

struct ContentView: View { // protocol oriented programming, behaves like a View
//    let emojis: Array<String> = ["👻", "🎃", "🕷️", "😈"]
//    let emojis: [String] = ["👻", "🎃", "🕷️", "😈"]
    let emojis = ["👻", "🎃", "🕷️", "😈", "🧟", "🦇", "🕸️", "🧛", "🌙", "🧙", "🍬", "🔮"]
    @State var cardCount = 4
    var body: some View { // of type some View, a computed property
        ZStack {
            ScrollView {
                cards
            }
            VStack {
                Spacer()
                cardCountAdjusters
            }
            .padding()
        }
//        .padding()
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120)), GridItem(.adaptive(minimum: 120)), GridItem(.adaptive(minimum: 120))]) { // implicit return
            ForEach(0..<cardCount, id:\.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View{
        HStack{
            cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
            Spacer()
            cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true // without @State we have an error
    var body: some View { // only lets in View because it's read-only
        ZStack { // trailing closure syntax
            let base = RoundedRectangle(cornerRadius: 12) // type inference
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
//            print("tapped")
//            isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
        // the stuff in curly brackets is a function
        // VStack(content: {Image() Text()})
    }
}
















#Preview {
    ContentView()
}
