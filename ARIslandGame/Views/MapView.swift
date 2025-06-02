//
//  MapView.swift
//  ARIslandGame
//
//  Created by stephan on 21/05/25.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var gameData: GameModel
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let islands = ["volcanoIsland", "lockedBottom", "lockedTop", "lockedBottom", "lockedTop"]
    
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    ButtonView(btnType: .icon("leftArrow"))
                    Text("Go back")
                        .foregroundColor(.black)
                }
            }
        }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                HStack {
                    ZStack{
                        ShadowedRoundedBackground(cornerRadius: 25, width: 25, height:25)
                        Image("leftArrow")
                            .renderingMode(.template)
                            .foregroundColor(.dark)
                            .background(.accent)
                            .clipShape(Circle())
                    }
                    Text("SELECT LEVEL")
                        .font(.londrinaBody)
                        .foregroundColor(.black)
                }
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
        .navigationBarItems(leading: btnBack)
    }
}

#Preview {
    MapView()
        .environmentObject(GameModel())
}
