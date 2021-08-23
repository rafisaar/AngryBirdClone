//
//  GameScene.swift
//  AngryBirdClone
//
//  Created by Rafi Saar on 17/08/2021.
//  Copyright © 2021 Syncopa Productions. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
//    var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()

    var gameStarted = false
    
    var birdOriginalPosition : CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
        // case Ground = 4   just an example - should be exponents of 2
        // case Tree = 8
    }
    
    override func didMove(to view: SKView) {
        
    /* If we want to add a bird in code instead of directly in the GameScene.sks file:
         
        let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: -self.frame.width / 4, y: -self.frame.height / 4)
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)
        */

        
        // PHISICS BODY
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)       // sets border of physics world so bird will stop falling
        self.scene?.scaleMode = .aspectFit                          // will fix the scaling so that we see all the elements on screen
        self.physicsWorld.contactDelegate = self

        
        // BIRD
        bird = childNode(withName: "bird") as! SKSpriteNode         // uses the name given in GameScene.sks
        
        let birdTexture = SKTexture(imageNamed: "bird")         // will be used just to get its size
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 13)            // divided by 10 because we made the original image smaller
        bird.physicsBody?.affectedByGravity = false             // so bird won't fall when we start, will set this to true in touchesEnded
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15                    // in kg
        birdOriginalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue           // these will be needed to identify collision
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue              // in bird put Box and in box coliisionBitMask put Bird
    
        
        // BOXES
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 7, height: boxTexture.size().height / 7)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true             // will allow box to rotate when hit
        box1.physicsBody?.mass = 0.4
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.allowsRotation = true             // will allow box to rotate when hit
        box2.physicsBody?.mass = 0.4
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true             // will allow box to rotate when hit
        box3.physicsBody?.mass = 0.4
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true             // will allow box to rotate when hit
        box4.physicsBody?.mass = 0.4
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true             // will allow box to rotate when hit
        box5.physicsBody?.mass = 0.4
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue

        
        // SCORE LABEL
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)

        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {            // detects contact
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    /* example on how to move bird by touching à la Flappy Bird style:
        bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 100))
        bird.physicsBody?.affectedByGravity = true
    */
        
        if gameStarted == false {                           // means we're starting now
            
            score = 0
            scoreLabel.text = String(score)
            
            if let touch = touches.first {                  // gives the 1st point the user has touched
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)       // to understand if the user touched the bird
                
                if touchNodes.isEmpty == false {                // so we did touch some node
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation   // will move the bird to the location where the user is touching
                            }
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // copying same code from touchesBegan because we need the bird move to continue as long as we touch
        if gameStarted == false {                           // means we're starting now
            
            if let touch = touches.first {                  // gives the 1st point the user has touched
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)       // to understand if the user touched the bird
                
                if touchNodes.isEmpty == false {                // so we did touch some node
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation   // will move the bird to the location where the user is touching
                            }
                        }
                    }
                    
                }
                
            }
        }

        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // here we know that the user let go of the touch
        // so copying again the same code as above, but this time we will change the bird's position according to the user's touch
        
        if gameStarted == false {                           // means we're starting now
            
            if let touch = touches.first {                  // gives the 1st point the user has touched
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)       // to understand if the user touched the bird
                
                if touchNodes.isEmpty == false {                // so we did touch some node
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = touchLocation.x - birdOriginalPosition!.x      // calculates x difference between the bird's original position and current touch position
                                let dy = touchLocation.y - birdOriginalPosition!.y      // same for y position
                                
                                let impulse = CGVector(dx: -dx, dy: -dy)                // need to throw the bird in the opposite direction so added - signs
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true              // now we can turn this on
                                
                                gameStarted = true                                      // so further touches to the bird won't be affected
                                
                            }
                        }
                    }
                    
                }
                
            }
        }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let birdPhysicsBody = bird.physicsBody {                         // to make it not optional
            
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {      // going to reset trhe game only if bird has almost stopped moving
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = birdOriginalPosition!
                bird.zRotation = 0
                                
                gameStarted = false
                
            }
        }
        
        
    }
}
