//
//  GameScene.swift
//  pong_simple
//
//  Created by Jonathan Buie on 11/1/16.
//  Copyright © 2016 Jonathan Buie. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var ball = SKSpriteNode();
    var enemy = SKSpriteNode();
    var main = SKSpriteNode();
    
    var topLabel = SKLabelNode();
    var btmlabel = SKLabelNode();
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        startGame()
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        btmlabel = self.childNode(withName: "btmLabel") as! SKLabelNode
        
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        // Lets add a border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
    }
    
    
    func startGame() {
        score = [0,0]
        topLabel.text = "\(score[1])"
        btmlabel.text = "\(score[0])"
        
        
    }
    
    func addScore(playerWhoWon: SKSpriteNode){
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
            
        }else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
            
        }
        
        topLabel.text = "\(score[1])"
        btmlabel.text = "\(score[0])"
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            //move our paddle to location of touch
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before every frame
        
        // This determines how difficult the enemy is. 0.5 is pretty complicated lets start at 1.
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1))
        
        if ball.position.y <= main.position.y - 70 {
            
            //update enemy score
            addScore(playerWhoWon: enemy)
            
        }else if ball.position.y >= enemy.position.y + 70 {
            // update main score
            addScore(playerWhoWon: main)
            
            
        }
        
        
        
    }
}
