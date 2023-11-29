//
//  GameView.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 27.11.2023.
//

import SwiftUI
import AVFoundation

struct GameView: View {

    @ObservedObject var viewModel: MemorizationGameViewModel

    @State var matchAudioPlayer: AVAudioPlayer?
    @State var flipAudioPlayer: AVAudioPlayer?

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 90)),
                ]) {

                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            viewModel.rotateCard(card)
                            flipAudioPlayer?.play()
                        }
                    }
                        .onChange(of: card.isMatched) { oldValue, newValue in
                        self.matchAudioPlayer?.play()
                    }
                }

            }
                .padding(.horizontal)
                .toolbar {
                ToolbarItem(id: "score", placement: .bottomBar) {
                    HStack {
                        Text("Moves: \(viewModel.movesCount)")
                            .foregroundStyle(.secondary)
                            .font(.title3)
                        Spacer()
                        Text("Score: \(viewModel.score)")
                            .foregroundStyle(.secondary)
                            .font(.title3)
                    }

                }
                ToolbarItem(id: "plus", placement: .primaryAction) {
                    Button {
                        withAnimation {
                            viewModel.incrementCards()
                        }
                    }
                    label: {
                        Image(systemName: "plus.circle")
                    }
                }
                ToolbarItem(id: "minus", placement: .primaryAction) {
                    Button {
                        withAnimation {
                            viewModel.decrementCards()
                        }
                    }
                    label: {
                        Image(systemName: "minus.circle")
                    }
                }
            }
        }
            .onAppear {

            let matchSound: String? = Bundle.main.path(forResource: "match", ofType: "mp3")
            let flipSound: String? = Bundle.main.path(forResource: "flip", ofType: "mp3")

            if let matchSound {
                self.matchAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: matchSound))

            }

            if let flipSound {
                self.flipAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: flipSound))
            }


        }
    }

}

#Preview {
    GameView(viewModel: MemorizationGameViewModel())
}
