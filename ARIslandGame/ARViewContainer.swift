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
    @Binding var selectedPart: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedPart: $selectedPart)
    }
    
    
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
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    class Coordinator: NSObject {
        weak var arView: ARView?
        @Binding var selectedPart: String?

        init(selectedPart: Binding<String?>) {
            _selectedPart = selectedPart
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            guard let arView = arView else { return }
            let location = gesture.location(in: arView)

            if let entity = arView.entity(at: location) {
                print("Tapped entity: \(entity.name) \(entity)")
                selectedPart = entity.name
            }
        }
    }
}
