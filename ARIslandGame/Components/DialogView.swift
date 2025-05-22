//
//  DialogView.swift
//  ARIslandGame
//
//  Created by Ardelia on 22/05/25.
//

import Foundation
import SwiftUI

struct mainView: View{
    @StateObject private var viewModel = DialogViewModel (
        dialogPages: [
            dialogPage(title:"\"Welcome to the first Island!\"", description: "In each island, you will need to find an object to open the riddle. the only guide you have is the sound faint, distant, but growing stronger as you approach"),
            dialogPage(title:"YOUR TASK", description: "1. Follow the sound: The island is alive with echoes-some are clues, others are distractions. The closer you get to the hidden object, the louder and clearer the sound becomes"),
            dialogPage(title:"YOUR TASK", description: "2. Solve the riddle: Each object you find will reveal a piece of the story and lead you to the next challenge. Pay attention to your surroundings; the answer might be hidden in plain sight"),
            dialogPage(title:"YOUR TASK", description: "3. Uncover the mystery: Once you answer the riddle, you will get a fragment of map that leads yo to get back the lost ship"),
            
        ])
    
    @State private var showDialog = false
    
    var body: some View{
        VStack {
            Button ("Show Dialog"){
                showDialog = true
            }
            .sheet(isPresented: $showDialog) {
                DialogView(viewModel: viewModel, isPresented: $showDialog)
            }
            
        }
        
        
    }
}



struct DialogView: View {
    @ObservedObject var viewModel: DialogViewModel
    @Binding var isPresented: Bool
    //    @State private var showSummary = false
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        HStack(){
            Spacer()
            Text("ONE TREASURE")
                .font(.largeTitle)
                .bold()
            Spacer()
            
            Button(){
                //                showSummary = true
                print("Show Summary")
            } label:{
                Image("hint")
                
            }.buttonStyle(.plain)
                .multilineTextAlignment(.trailing)
            //                .sheet(isPresented: $showSummary) {
            //                            DialogView(dialogPages: viewModel.dialogPages)
        }.padding()

        
        ZStack (alignment: .bottomLeading) {
                ScrollView (){
                    LazyVStack(alignment:.leading){
                        
                        Text(viewModel.dialogPages[viewModel.currentIndex].title)
                            .font(.londrinaHeadline)
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: 15, leading: 10, bottom: 2, trailing: 10))
                        
                        ExpandableTextView(text: viewModel.dialogPages[viewModel.currentIndex].description)
                            .font(.kanitRegularBody)
                        
                        
                        HStack(){
                            Button(){
                                if viewModel.isfirstPage(){
                                    
                                }else{
                                    viewModel.prevPage()
                                }
                            } label:{
                                Image("Left Arrow_Colored")
                            }.buttonStyle(.plain)
                            
                            
                            Button () {
                                if viewModel.isLastPage() {
                                    isPresented = false
                                }else {
                                    viewModel.nextPage()
                                }
                            } label: {
                                Image("Right Arrow_Colored")
                            }.buttonStyle(.plain)
                        }
                        .frame(maxWidth:.infinity, alignment: .bottomTrailing)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 20))
                        
                    }.background(Color("Color"))
                        .padding()
                        .border(Color("BorderColor"), width: 4)
                    
                }.padding(EdgeInsets(top: 100, leading: 2, bottom: 2, trailing: 2))

            Image("Char")
                .resizable()
                .aspectRatio(contentMode:.fit)
                .frame(width: 50, height: 50, alignment: .bottomLeading)
        }
 
    }
}

#Preview {
    mainView()
}

