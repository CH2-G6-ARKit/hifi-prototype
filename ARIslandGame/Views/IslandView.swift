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
    @State private var shouldRetry = false
    @State private var currentPopUpType: PopUpView.Types? = nil
    @State private var navigateToMap = false
    @State private var showDialog = true
    @State  var viewModel = DialogViewModel()
    
    @EnvironmentObject var gameData: GameModel
    
    
    func handleAnswer(isCorrect: Bool) {
        currentPopUpType = .result(isCorrect)
        
        if isCorrect {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameData.addCollectedFragment()
                currentPopUpType = .fragment(gameData.collectedFragment)
                gameData.resetChances()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showPopUp = false
                    selectedPart = nil
                    currentPopUpType = nil
                }
            }
        } else {
            shouldRetry = true
        }
    }
    
    func retryAction() {
        currentPopUpType = .question(gemObject)
        gameData.decreaseAnswerChances()
        shouldRetry = false
    }
    
    
    let gemObject = Object(name: "gems", question: "2+2", choices: ["3", "4", "6", "8"], answer: 1)
    
    
    var body: some View {
        ZStack{
            
            ZStack(alignment: .topTrailing) {
                
                ARViewContainer(selectedPart: $selectedPart)
                    .ignoresSafeArea(edges: .all)
                
                
                //            DialogView(viewModel: viewModel , isPresented: $showDialogue)
                    .sheet(isPresented: $showDialog) {
                        DialogView(viewModel: viewModel)
                    }
                
                
                HStack{
                    Image("check_frag")
                        .scaleImage(ratio: 0.7, imageName: "check_frag")
                        .padding(.horizontal, 10)
                    Button {
                        //                    for testing purposes -- remove this later
                        currentPopUpType = .question(gemObject)
                        showPopUp = true
                    } label: {
                        Image("hint")
                            .scaleImage(ratio: 0.7, imageName: "hint")
                    }
                    
                }
                .offset(x:300, y:-120)
                .zIndex(1)
                
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
                else if let currentType = currentPopUpType {
                    PopUpView(
                        showPopUp: $showPopUp,
                        type: currentType,
                        onAnswered: { isCorrect in
                            handleAnswer(isCorrect: isCorrect)
                        },
                        onRetry: {
                            retryAction()
                        }
                    )
                    
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
}
//
//#Preview {
//    IslandView()
//}
