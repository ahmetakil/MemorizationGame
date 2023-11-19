//
//  MemorizationGameView.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import SwiftUI

struct MemorizationGameView: View {
    @ObservedObject var viewModel: MemorizationGameViewModel
    @State var showContextMenu = false

    var body: some View {
        NavigationStack {
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
                .padding(.horizontal)
                .toolbar {
                ToolbarItem(id: "plus", placement: .primaryAction) {
                    Button {
                        viewModel.incrementCards()
                    }
                    label: {
                        Image(systemName: "plus.circle")
                    }
                }
                ToolbarItem(id: "minus", placement: .primaryAction) {
                    Button {
                        viewModel.decrementCards()
                    }
                    label: {
                        Image(systemName: "minus.circle")
                    }
                }
            }
        }

    }
}

#Preview {
    MemorizationGameView(
        viewModel: MemorizationGameViewModel()
    )
}
