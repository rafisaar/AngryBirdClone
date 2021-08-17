//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Rafi Saar on 17/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
    /* If we want to add a bird in code instead of directly in the GameScene.sks file:
         
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: -self.frame.width / 4, y: -self.frame.height / 4)
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
        */
    
    
        bird = childNode(withName: "bird") as! SKSpriteNode         // uses the name given in GameScene.sks
        
        let birdTexture = SKTexture(imageNamed: "bird")         // will be used just to get its size
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 13)            // divided by 10 because we made the original image smaller
        bird.physicsBody?.affectedByGravity = true
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.5                    // in kg
    
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)       // sets border of physics world so bird will stop falling
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
