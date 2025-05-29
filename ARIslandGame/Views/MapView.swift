//
//  MapView.swift
//  ARIslandGame
//
//  Created by stephan on 21/05/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var gameData: GameModel
    
    let islands = ["volcanoIsland", "lockedBottom", "lockedTop", "lockedBottom", "lockedTop"]
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Text("Collected Fragments: \(gameData.collectedFragment) / 4")
                    .zIndex(1).offset(x:280, y:-160)
                ScrollView(.horizontal, showsIndicators: false) {
                    ZStack{

                        Image("decoration")
                            .scaleImage(ratio: 0.2, imageName: "mapTrail")
                            .offset(x:-120)
                        Image("mapTrail")
                            .scaleImage(ratio: 0.22, imageName: "mapTrail")
                            .offset(x:-10)
                        HStack(spacing: 120) {
                            ForEach(islands, id: \.self) {i in
                                NavigationLink(destination: IslandView().environmentObject(gameData)
                                    .ignoresSafeArea(edges: .all)
                                ) {
                                    Image("\(i)")
                                        .scaleImage(ratio: 0.25, imageName: "\(i)")
                                }
                                
                            }
                        }
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(.accent)
        }
    }
}

#Preview {
    MapView()
        .environmentObject(GameModel())
}
