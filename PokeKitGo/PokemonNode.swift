//
//  PokemonNode.swift
//  PokeKitGo
//
//  Created by Matheus Martins on 9/20/16.
//  Copyright © 2016 MatheusMCardoso. All rights reserved.
//

import SpriteKit
import GameplayKit

enum PokemonType {
    case fire
    case water
    case electric
}

class PokemonNode : SKNode {
    
    var type: PokemonType
    
    var sprite: SKSpriteNode
    
    init(withType type: PokemonType, andTexture texture: SKTexture) {
        self.type = type
        
        let texture = PokemonNode.randomPokemonTextureOfType(type: type)
        
        
        let container = SKSpriteNode(texture: texture)
        container.name = "\(type)"
        container.color = SKColor.clear
        
        self.sprite = SKSpriteNode(texture: texture)
        self.sprite.zPosition = -1
        
        super.init()
        
        container.addChild(self.sprite)
        self.addChild(container)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonNode {
    
    static let textures = (fire: [#imageLiteral(resourceName: "charmander"), #imageLiteral(resourceName: "charmeleon"), #imageLiteral(resourceName: "charizard"),
                                  #imageLiteral(resourceName: "arcanine"), #imageLiteral(resourceName: "flareon"), #imageLiteral(resourceName: "growlithe"),
                                  #imageLiteral(resourceName: "magmar"), #imageLiteral(resourceName: "moltres"), #imageLiteral(resourceName: "ninetails"),
                                  #imageLiteral(resourceName: "ponyta"), #imageLiteral(resourceName: "rapidash")],
                           
                           water: [#imageLiteral(resourceName: "squirtle"), #imageLiteral(resourceName: "wartortle"), #imageLiteral(resourceName: "blastoise"),
                                   #imageLiteral(resourceName: "shellder"), #imageLiteral(resourceName: "cloyster"), #imageLiteral(resourceName: "lapras"),
                                   #imageLiteral(resourceName: "articuno"), #imageLiteral(resourceName: "psyduck"), #imageLiteral(resourceName: "golduck"),
                                   #imageLiteral(resourceName: "krabby"), #imageLiteral(resourceName: "kingler"), #imageLiteral(resourceName: "magikarp"),
                                   #imageLiteral(resourceName: "gyarados"), #imageLiteral(resourceName: "seel"), #imageLiteral(resourceName: "dewgong"),
                                   #imageLiteral(resourceName: "vaporeon"), #imageLiteral(resourceName: "horsea"), #imageLiteral(resourceName: "seadra"),
                                   #imageLiteral(resourceName: "poliwag"), #imageLiteral(resourceName: "poliwhirl"), #imageLiteral(resourceName: "poliwrath"),
                                   #imageLiteral(resourceName: "slowpoke"), #imageLiteral(resourceName: "slowbro"), #imageLiteral(resourceName: "staryu"),
                                   #imageLiteral(resourceName: "starmie"), #imageLiteral(resourceName: "tentacool"), #imageLiteral(resourceName: "tentacruel"),
                                   #imageLiteral(resourceName: "goldeen"), #imageLiteral(resourceName: "seaking")],
                           
                           electric: [#imageLiteral(resourceName: "pikachu"), #imageLiteral(resourceName: "raichu"), #imageLiteral(resourceName: "voltorb"),
                                      #imageLiteral(resourceName: "electrode"), #imageLiteral(resourceName: "jolteon"), #imageLiteral(resourceName: "magnemite"),
                                      #imageLiteral(resourceName: "magneton"), #imageLiteral(resourceName: "zapdos"), #imageLiteral(resourceName: "electabuzz")])
    
    static func randomPokemonOfType(type: PokemonType) -> PokemonNode {
        return PokemonNode(withType: type, andTexture: self.randomPokemonTextureOfType(type: type))
    
    }
    
    static func randomPokemonTextureOfType(type: PokemonType) -> SKTexture {
        let random = GKRandomSource()
        
        switch type {
        case .fire:
            return SKTexture(image: self.textures.fire[random.nextInt(upperBound: self.textures.fire.count)])
        case .water:
            return SKTexture(image: self.textures.water[random.nextInt(upperBound: self.textures.water.count)])
        case .electric:
            return SKTexture(image: self.textures.electric[random.nextInt(upperBound: self.textures.electric.count)])
        }
    }
}
