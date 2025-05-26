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
    @State private var currentPopUpType: PopUpView.Types? = nil
    @State private var showDialogue: Bool = true
    
    func handleAnswer(isCorrect: Bool) {
        currentPopUpType = .result(isCorrect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if isCorrect {
                currentPopUpType = .fragment
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showPopUp = false
                    selectedPart = nil
                    currentPopUpType = nil
                }
            } else {
                currentPopUpType = .question(gemObject)
            }
        }
    }
    
    
    let gemObject = Object(name: "gems", question: "2+2", choices: ["3", "4", "6", "8"], answer: 1)
    @State  var viewModel = DialogViewModel (
        dialogPages: [
            dialogPage(title:"\"Welcome to the first Island!\"", description: "In each island, you will need to find an object to open the riddle. the only guide you have is the sound faint, distant, but growing stronger as you approach"),
            dialogPage(title:"YOUR TASK", description: "1. Follow the sound: The island is alive with echoes-some are clues, others are distractions. The closer you get to the hidden object, the louder and clearer the sound becomes"),
            dialogPage(title:"YOUR TASK", description: "2. Solve the riddle: Each object you find will reveal a piece of the story and lead you to the next challenge. Pay attention to your surroundings; the answer might be hidden in plain sight"),
            dialogPage(title:"YOUR TASK", description: "3. Uncover the mystery: Once you answer the riddle, you will get a fragment of map that leads yo to get back the lost ship"),
            
        ])
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            ARViewContainer(selectedPart: $selectedPart)
                .ignoresSafeArea(edges: .all)
            
            
            DialogView(viewModel: viewModel , isPresented: $showDialogue)
            
            HStack{
                Image("check_frag")
                    .scaleImage(ratio: 0.7, imageName: "check_frag")
                    .padding(.horizontal, 10)
                Image("hint")
                    .scaleImage(ratio: 0.7, imageName: "hint")
            }
            .offset(x:300, y:-120)
            .zIndex(1)
            
            if let part = selectedPart, part != gemObject.name {
                VStack {
                    Spacer()
                    Text("clicked")
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: selectedPart)
            }
            else if let currentType = currentPopUpType {
                PopUpView(showPopUp: $showPopUp, type: currentType) { isCorrect in
                    handleAnswer(isCorrect: isCorrect)
                }
            }
        }
        // Listen to changes in selectedPart to control the popup
        .onChange(of: selectedPart) { newValue in
            if newValue == gemObject.name {
                currentPopUpType = .question(gemObject)
                showPopUp = true
            }
        }
    }
}
//
//#Preview {
//    IslandView()
//}
