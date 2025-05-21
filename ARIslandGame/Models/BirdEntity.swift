//
//  BirdEntity.swift
//  ARIslandGame
//
//  Created by stephan on 20/05/25.
//

import RealityKit

final class BirdEntity: Entity, HasModel {
    override required init() {
        super.init()
        let model = try! Entity.loadModel(named: "crow")
        model.scale = .init(repeating: 0.00005)
        model.position = [0.004, 0.288, -0.00658]
        self.addChild(model)
        self.name = "bird"
    }
}
