//
//  CongratsView.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 19.11.2023.
//

import SwiftUI

struct CongratsView: View {

    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MemorizationGameViewModel

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("🎉 Congratulations  🎉")
                .font(.largeTitle)
                .navigationBarBackButtonHidden()
            Text("You have completed the game in \(viewModel.movesCount) with the score of \(viewModel.score)")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
                .padding()

            if viewModel.reachedAllTimeHigh {
                Text("New Record!")

            }
            Button {
                viewModel.restartGame(resetPairOfCardsCount: true)
                dismiss()
            } label: {
                Text("Reset")
                    .font(.title3)
                    .padding(4)

            }
                .padding(.vertical)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)

            Spacer()
            Text("Your all time high score is \(viewModel.allTimeHigh)")
                .foregroundStyle(.primary)
                .font(.body)


        }
    }
}

#Preview {
    CongratsView(viewModel: MemorizationGameViewModel())
}
