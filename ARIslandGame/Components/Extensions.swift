//
//  Extensions.swift
//  ARIslandGame
//
//  Created by Stephanie Staniswinata on 25/05/25.
//

import SwiftUI

extension Text {
    func outlinedText(strokeColor: Color = .black, textColor: Color = .white, lineWidth: CGFloat = 4) -> some View {
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

struct ShadowedRoundedBackground: View {
    var cornerRadius: CGFloat = 10
    var color: Color = .dark
    var strokeColor: Color = .dark
    var strokeWidth: CGFloat = 4
    var width: CGFloat = 400
    var height: CGFloat = 250
    var yOffset: CGFloat = 6

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundColor(color)
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: strokeWidth)
            )
            .offset(y: yOffset)
    }
}

struct WigglyShape: Shape {
    var waveStrength: CGFloat = 60
    var waveFrequency: CGFloat = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let step = rect.width / waveFrequency
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        for i in stride(from: CGFloat(0), through: rect.width, by: step) {
            let y = rect.minY + sin(i / rect.width * .pi * 2 * waveFrequency) * waveStrength
            path.addLine(to: CGPoint(x: i, y: y))
        }
        
        // Continue around the button (simplified; you can apply same logic to each edge)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

struct WigglyButton: View {
    var title: String
    var action: () -> Void
    var backgroundColor: Color = .accentColor
    var strokeColor: Color = .black

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .padding()
                .background(
                    ZStack {
                        backgroundColor
                        WigglyShape()
                            .stroke(strokeColor, lineWidth: 2)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                )
        }
        .buttonStyle(.plain)
    }
}
