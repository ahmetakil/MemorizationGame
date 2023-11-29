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
            GameView(viewModel: viewModel)
                .navigationDestination(isPresented: $viewModel.isGameOver) {
                    CongratsView(viewModel: viewModel)
                }
        }
    
    }
}




#Preview {
    MemorizationGameView(viewModel: MemorizationGameViewModel())
}
