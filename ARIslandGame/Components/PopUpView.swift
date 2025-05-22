//
//  PopUpView.swift
//  onetreasure
//
//  Created by Stephanie Staniswinata on 19/05/25.
//
import SwiftUI

extension Text {
    func outlinedText(strokeColor: Color = .black, textColor: Color = .white, lineWidth: CGFloat = 2) -> some View {
        ZStack {
            // Stroke layers
            ForEach([
                CGSize(width: -lineWidth, height: 0),
                CGSize(width: lineWidth, height: 0),
                CGSize(width: 0, height: -lineWidth),
                CGSize(width: 0, height: lineWidth),
                CGSize(width: -lineWidth, height: -lineWidth),
                CGSize(width: -lineWidth, height: lineWidth),
                CGSize(width: lineWidth, height: -lineWidth),
                CGSize(width: lineWidth, height: lineWidth),
            ], id: \.self) { offset in
                self
                    .foregroundColor(strokeColor) // Stroke color
                    .offset(x: offset.width, y: offset.height+3)
            }

            // Main centered text
            self
                .foregroundColor(textColor)
        }
    }
}


struct PopUpView: View {
    @Binding var showPopUp: Bool
    let type: Types
    var onAnswered: ((Bool) -> Void)? = nil
    
    func buttonAction(num: String, item: Object) {
            let isCorrect = num == item.choices[item.answer]
            onAnswered?(isCorrect)
        }
    
    enum Types {
        case question(Object)
        case result(Bool)
        case fragment
        case lost
    }
    
    var body: some View {
        if showPopUp {
            ZStack {
                Color.black.opacity(0.3).ignoresSafeArea()
                
                switch type {
                case .question(let item):
                    ZStack {
                        VStack {
                            VStack(spacing: 16) {
                                Text(item.question)
                                    .foregroundColor(.black)
                                    .font(.londrinaCallout)
                                    .multilineTextAlignment(.center)
                                    .padding([.top])
                                    .bold()
                                
                                let fixedColumns = [
                                    GridItem(.fixed(150)),
                                    GridItem(.fixed(150))
                                ]
                                
                                LazyVGrid(columns: fixedColumns, spacing: 8) {
                                    ForEach(item.choices, id: \.self) { choice in
                                        Button {
                                            buttonAction(num: choice, item: item)
                                        } label: {
                                            Text(choice)
                                                .font(.londrinaLightBody)
                                                .frame(width: 150, height: 50)
                                                .foregroundColor(.black)
                                                .background(.white)
                                                .cornerRadius(10)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(.black, lineWidth: 2)
                                                )
                                        }
                                    }
                                }
                            }
                            .frame(width: 550, height: 250)
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 2)
                        )
//                        .frame(height: 500)
                        .padding(.horizontal, 100)
                        .transition(.scale.combined(with: .opacity))
                        
                        Button {
                            showPopUp = false
                        } label: {
                            Image(systemName: "multiply.circle")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                        .offset(x:250, y:-100)
                        .buttonStyle(.plain)
                        
                        Text("SOLVE THE RIDDLE")
                            .font(.londrinaHeadline)
                            .frame(width: 180, height: 50)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 2)
                            )
                            .offset(y: -(500/4))
                        
                    }
                    
                case .result(let isCorrect):
                    ZStack{
                        Image(isCorrect ? "right" : "wrong")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text(isCorrect ? "RIDDLE \n SOLVED!" : "WRONG \n ANSWER")
                            .font(.jaroBig)
                            .outlinedText(strokeColor: .black, textColor: .white, lineWidth: 5.5)
                            .multilineTextAlignment(.center)
                            .padding()
                            .offset(y:95)
                    }
                    
                case .fragment:
                    ZStack {
                        VStack {
                            Image("map")
                                .resizable()
                                .frame(width:200, height:150)
                            
//                            NavigationLink(destination: MapView()
//                                .ignoresSafeArea(edges: .all)
//                            ) {
//                                Text("OK")
//                                    .padding()
//                                    .padding(.horizontal, 20)
//                                    .foregroundColor(.white)
//                                    .background(.black)
//                                    .cornerRadius(10)
//                            }
                        }
                        .frame(width: 400, height: 250)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 2)
                        )
                        .padding(.horizontal, 100)
                        .transition(.scale.combined(with: .opacity))
                        
//                        Button {
//                            showPopUp = false
//                        } label: {
//                            Image(systemName: "multiply.circle")
//                                .foregroundColor(.black)
//                                .font(.title2)
//                        }
//                        .offset(x:170, y:-100)
//                        .buttonStyle(.plain)
                        
                        Text("YOU GOT NEW FRAGMENT!")
                            .font(.londrinaHeadline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(.black)
                            .cornerRadius(10)
                            .offset(y: -(500/4))
                        
                    }
                    
                case .lost:
                    ZStack{
                        Image("lost")
                            .resizable()
                            .frame(width: 200, height: 200)
                        Text("YOU LOST")
                            .font(.jaroBigX)
                            .outlinedText(strokeColor: .black, textColor: .white, lineWidth: 5.5)
                            .multilineTextAlignment(.center)
                            .padding()
                            .offset(y:95)
                    }
                }
            }
        }
    }
}


#Preview {
    var long = Object(name: "pancakes", question: "I have no legs, but I travel the seas. \n I bury no gold, yet I hold treasures with ease. \n My home is below where the sun cannot see. \n What kind of pirate treasure could I be?", choices: ["A Kraken", "A Shipwreck", "A Treasure Map", "A Parrot"], answer: 1)
    
    var short = Object(name: "pancakes", question: "2+2", choices: ["2", "3", "4", "5"], answer: 2)
//    PopUpView(showPopUp: .constant(true), type: .question(short))
//    PopUpView(showPopUp: .constant(true), type: .question(long))
//            PopUpView(showPopUp: .constant(true), type: .result(true))
        PopUpView(showPopUp: .constant(true), type: .result(false))
//        PopUpView(showPopUp: .constant(true), type: .fragment)
//    PopUpView(showPopUp: .constant(true), type: .lost)
}
