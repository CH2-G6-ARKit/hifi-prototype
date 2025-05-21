//
//  HomeView.swift
//  ARIslandGame
//
//  Created by stephan on 21/05/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("This is the home page")
                
                NavigationLink(destination: MapView()) {
                    Text("Play")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
