//
//  IslandView.swift
//  ARIslandGame
//
//  Created by Stephanie Staniswinata on 22/05/25.
//

import SwiftUI

struct IslandView: View {
    //    @Binding var isPresented: Bool
    @State var selectedPart: String? = nil
    @State var showPopUp = false
    
    let gemObject = Object(name: "gems", question: "2+2", choices: ["3", "4", "6", "8"], answer: 1)
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ARViewContainer(selectedPart: $selectedPart)
                .ignoresSafeArea(edges: .all)
            
            if let part = selectedPart, part != gemObject.name {
                VStack {
                    Spacer()
                    Text("clicked")
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: selectedPart)
            }
            else{
                PopUpView(showPopUp: $showPopUp, type: .question(gemObject))
            }
        }
        // Listen to changes in selectedPart to control the popup
        .onChange(of: selectedPart) { newValue in
            if newValue == gemObject.name {
                showPopUp = true
            }
        }
    }
}
//
//#Preview {
//    IslandView()
//}
