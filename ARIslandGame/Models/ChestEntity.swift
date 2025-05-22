//
//  ChestEntity.swift
//  ARIslandGame
//
//  Created by stephan on 20/05/25.
//

import RealityKit

final class ChestEntity: Entity, HasModel {
    override required init() {
        super.init()
        let model = try! Entity.loadModel(named: "gems")
        model.scale = .init(repeating: 0.00002)
        model.position = [0.016, 0.288, -0.00658]
        model.generateCollisionShapes(recursive: true)
//        model.name = self.name
        self.addChild(model)
        self.name = "gems"
    }
}
