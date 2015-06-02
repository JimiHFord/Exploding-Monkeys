//
//  GameScene.swift
//  ExplodingMonkeys
//
//  Created by James Ford on 6/2/15.
//  Copyright (c) 2015 JWorks. All rights reserved.
//

import SpriteKit

enum CollisionTypes: UInt32 {
    case Banana = (1 << 0)
    case Building = (1 << 1)
    case Player = (1 << 2)
}

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
