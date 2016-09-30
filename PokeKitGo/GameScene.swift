//
//  GameScene.swift
//  PokeKitGo
//
//  Created by Matheus Martins on 9/19/16.
//  Copyright © 2016 MatheusMCardoso. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

class GameScene: SKScene {
    
    let displaySize = UIScreen.main.bounds.size
    
    override func sceneDidLoad() {
        self.setup()
    }
    
    func setup() {
        self.createStartLabel()
        self.createHighScore()
        self.createTitleLabel()
    }
    
    func createStartLabel() {
        let position = CGPoint(x: self.displaySize.width * 0.5, y: self.displaySize.height * 0.5)
        
        let label = SKLabelNode(text: "Aperte para começar!")
        label.position = position
        
        self.addChild(label)
    }
    
    func createHighScore() {
        let position = CGPoint(x: self.displaySize.width * 0.5, y: self.displaySize.height * 0.25)
        
        let label = SKLabelNode(text: "???")
        label.position = position
        
        if let data = UserDefaults.standard.object(forKey: "time") {
            let time = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Int!
            label.text = "Best time - \(time!)"
        }
        
        self.addChild(label)
    }
    
    func createTitleLabel() {
        let position = CGPoint(x: self.displaySize.width * 0.5, y: self.displaySize.height * 0.75)
        
        let label = SKLabelNode(text: "PokeCatch!")
        label.position = position
        
        self.addChild(label)
    }
    
    func playGame() {
        let scene = GridGameScene(size: self.displaySize)
        
        let transition = SKTransition.fade(withDuration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.playGame()
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
