//
//  MemorizationGameApp.swift
//  MemorizationGame
//
//  Created by Ahmet Akıl on 12.11.2023.
//

import SwiftUI

@main
struct MemorizationGameApp: App {
    
    @StateObject var viewModel = MemorizationGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            MemorizationGameView(viewModel: viewModel)
        }
    }
}
