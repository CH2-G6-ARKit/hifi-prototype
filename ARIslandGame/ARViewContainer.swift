//
//  ARViewContainer.swift
//  ARIslandGame
//
//  Created by stephan on 21/05/25.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        
        arView.session.run(config)
        
        let anchor = AnchorEntity(plane: .horizontal)
        let island = IslandEntity()
        let chest = ChestEntity()
        let bird = BirdEntity()
        
        anchor.addChild(island)
        island.addChild(chest)
        island.addChild(bird)
        
        AudioManager.attachBirdSound(to: bird)
        
        arView.scene.anchors.append(anchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
