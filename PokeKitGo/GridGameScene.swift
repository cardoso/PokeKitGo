//
//  GridGameScene.swift
//  PokeKitGo
//
//  Created by Augusto Falcão on 9/25/16.
//  Copyright © 2016 MatheusMCardoso. All rights reserved.
//

import SpriteKit
import GameplayKit

class GridGameScene: SKScene {
    
    private var lastUpdateTime : TimeInterval = 0
    var actualTime: TimeInterval = 0
    var counter: SKLabelNode?
    
    var blocked = false
    
    let displaySize = UIScreen.main.bounds.size
    
    var typePokemon: PokemonType?
    var firePokemons: Int?
    var waterPokemons: Int?
    var eletricPokemons: Int?
    
    var score: Int?
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.isUserInteractionEnabled = false
        
        self.isPaused = false
        
        self.score = 0
        
        self.resetPokemons()
        self.createGrid()
        self.createCounter()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
        if (self.isPaused == true) {
            self.backToMenu()
            //self.restart()
        }
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
    
    func randomTypeNumber() -> PokemonType {
        let number = arc4random() % 3
        var type: PokemonType = .fire
        switch number {
        case 0:
            type = .water
            self.waterPokemons = self.waterPokemons! + 1
            break
        case 1:
            type = .electric
            self.eletricPokemons = self.eletricPokemons! + 1
            break
        case 2:
            type = .fire
            self.firePokemons = self.firePokemons! + 1
            break
        default:
            break
        }
        return type
    }
    
    func resetPokemons() {
        self.waterPokemons = 0
        self.firePokemons = 0
        self.eletricPokemons = 0
    }
    
    func createGrid() {
        var i = 0
        while(i < 4) {
            
            let a = Double((i % 4) + 1)
            let c = a / 5.0
            let x = CGFloat(Double(self.displaySize.width) * c)
            
            var j = 0
            while(j < 6) {
                let side = self.displaySize.width * 0.22
                let pokemon = PokemonNode.randomPokemonOfType(type: self.randomTypeNumber())
                pokemon.sprite.size = CGSize(width: side, height: side)
                pokemon.delegate = self
                
                let b = Double((j % 6) + 1)
                let d = b / 8.0
                let y = CGFloat(Double(self.displaySize.height) * d)
                let position = CGPoint(x: x, y: y)
                
                print(c)
                print(d)
                
                pokemon.position = position
                self.addChild(pokemon)
                
                j += 1
            }
            
            i += 1
        }
        self.isUserInteractionEnabled = true
    }
    
    func createCounter() {
        self.counter = SKLabelNode(text: "0.00")
        self.counter!.name = "congrats"
        self.counter!.fontColor = SKColor.white
        self.counter!.fontSize = 40
        self.counter!.position = CGPoint(x: self.displaySize.width * 0.5, y: self.displaySize.height * 0.9)
        self.addChild(self.counter!)
        
    }
    
    
    func increaseScore() {
        self.score = self.score! + 1
        
        var max = 0

        if self.typePokemon == PokemonType.water {
            max = self.waterPokemons!
        }
        
        if self.typePokemon == PokemonType.fire {
            max = self.firePokemons!
        }
        
        if self.typePokemon == PokemonType.electric {
            max = self.eletricPokemons!
        }
        
        print(max)
        print(self.score)
        
        if self.score! >= max - 1 {
            self.finishVictory()
        }
    }
    
    func finishLose() {
        self.removeAllChildren()
        
        self.typePokemon = nil
        
        let congrats = SKLabelNode(text: "Errou!")
        congrats.name = "congrats"
        congrats.fontColor = SKColor.white
        congrats.fontSize = 40
        congrats.position = CGPoint(x: self.displaySize.width * 0.5, y: self.displaySize.height * 0.5)
        self.addChild(congrats)
        
        self.isPaused = true
        
    }
    
    func finishVictory() {
        self.removeAllChildren()
        
        self.typePokemon = nil
        
        let seconds = lround(self.actualTime)
        let str = String(format: "%.2d", seconds)
        
        let congrats = SKLabelNode(text: "Voce ganhou em \(str)s!")
        congrats.name = "congrats"
        congrats.fontColor = SKColor.white
        congrats.fontSize = 40
        congrats.position = CGPoint(x: self.displaySize.width * 0.5, y: self.displaySize.height * 0.5)
        self.addChild(congrats)
        
        var previousTime = 666
        
        if let data = UserDefaults.standard.object(forKey: "time") {
            previousTime = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! Int!
        }
        
        if seconds < previousTime {            
            let data = NSKeyedArchiver.archivedData(withRootObject: seconds)
            UserDefaults.standard.set(data, forKey: "time")
        }
        
        
        self.isPaused = true
    }
    
    func restart() {
        self.lastUpdateTime = 0
        self.blocked = true
        self.removeAllActions()
        self.removeAllChildren()
        self.sceneDidLoad()
    }
    
    func backToMenu() {
        let scene = GameScene(size: self.displaySize)
        
        let transition = SKTransition.fade(withDuration: 0.5)
        
        self.view?.presentScene(scene, transition: transition)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        
        self.actualTime = currentTime - self.lastUpdateTime
        let str = String(format: "%.2d", lround(self.actualTime))
        self.counter?.text = str
    }
}

extension GridGameScene: PokemonNodeDelegate {
    func didTapPokemonNode(pokemonNode: PokemonNode) {
        if self.blocked == false {
            if self.typePokemon == nil {
                self.typePokemon = pokemonNode.type
            }
            else if pokemonNode.type == self.typePokemon {
                self.increaseScore()
            }
            else {
                self.finishLose()
            }
            pokemonNode.removeFromParent()
        }
        else {
            self.blocked = false
        }
    }
}
