//
//  MapView.swift
//  ARIslandGame
//
//  Created by stephan on 21/05/25.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        Button() {
            ARViewContainer()
                .ignoresSafeArea(edges: .all)
        } label: {
            Text("This is first map")
        }
        
        Text("This is second map")
        Text("This is third map")
        Text("This is first map")
    }
}

#Preview {
    MapView()
}
