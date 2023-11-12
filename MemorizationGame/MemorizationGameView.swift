//
//  MemorizationGameView.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import SwiftUI

struct MemorizationGameView: View {
    @ObservedObject var viewModel: MemorizationGameViewModel

    var body: some View {
        ScrollView{
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 90)),
                ]) {
                    ForEach(viewModel.cards, id: \.self) { card in
                        CardView(card)
                            .onTapGesture {
                                viewModel.rotateCard(card)
                            }
                    }
                }
        }
            .padding(.horizontal)
    }
}

#Preview {
    MemorizationGameView(
        viewModel: MemorizationGameViewModel()
    )
}
