//
//  HomeView.swift
//  ARIslandGame
//
//  Created by stephan on 21/05/25.
//

import SwiftUI

enum Views: Hashable{
    case home
    case map
    case island
    case popup
}

struct HomeView: View {
    @StateObject var gameData = GameModel()
    @State private var showMap = false
    //    @State private var path: [Views] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    ZStack{
                        Image("bg_map")
                            .resizable()
                            .scaledToFit()
                        Image("trail")
                        //                        .renderingMode(.template)
                            .scaleImage(ratio: 0.22, imageName: "trail")
                        //                        .foregroundColor(.red)
                            .offset(x:-20)
                        Image("compas")
                            .scaleImage(ratio: 0.25, imageName: "compas")
                            .offset(x:220, y:90)
                        VStack{
                            Image("title")
                                .scaleImage(ratio: 0.24, imageName: "title")
                            NavigationLink(destination: MapView().environmentObject(gameData)) {
                                ButtonView(btnType: .text("PLAY"))
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(.accent)
            }
        }
    }
}

#Preview {
    HomeView()
//        .background(.accent)
}
