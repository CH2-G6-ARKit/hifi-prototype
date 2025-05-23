//
//  MapView.swift
//  ARIslandGame
//
//  Created by stephan on 21/05/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var gameData: GameModel
    
    let gemObject = Object(name: "gems", question: "2+2", choices: ["3", "4", "6", "8"], answer: 1)
    
    var body: some View {
        VStack {
            Text("Collected Fragments: \(gameData.collectedFragment) / 4")
                .padding(20)
            
            NavigationLink(destination: IslandView().environmentObject(gameData)
                .ignoresSafeArea(edges: .all)
            ) {
                Text("This is first map")
            }
            
            Text("This is second map")
            Text("This is third map")
            Text("This is first map")
        }
    }
}

#Preview {
    MapView()
        .environmentObject(GameModel())
}
