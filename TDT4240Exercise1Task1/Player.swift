//
//  Player.swift
//  TDT4240Exercise1Task1
//
//  Created by Ragnhild Neset on 18.02.16.
//  Copyright © 2016 Kristoffer Larsen. All rights reserved.
//

import UIKit
import SpriteKit


class Player: SKSpriteNode {
    
    var initialized = false
    var feet : SKSpriteNode!
    var body : SKSpriteNode!
    var playerBody : [SKTexture]!
    var playerFeet : [SKTexture]!
    let playerAtlas = SKTextureAtlas(named: "Top_Down_Survivor")
    static var instance:Player = Player()
    
    private override init(texture: SKTexture!, color: UIColor!, size: CGSize){
        super.init(texture: texture, color: color, size: size)
        self.initPlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initPlayer(){
        var bodyFrames = [SKTexture]()
        var feetFrames = [SKTexture]()
        
        for var i=0; i<=19; ++i {
            let playerAnimationBody = "survivor-move_rifle_\(i)"
            bodyFrames.append(playerAtlas.textureNamed(playerAnimationBody))
            let playerAnimationFeet = "survivor-run_\(i)"
            feetFrames.append(playerAtlas.textureNamed(playerAnimationFeet))
        }
        
        playerBody = bodyFrames
        playerFeet = feetFrames
        
        let firstFeetFrame = playerFeet[0]
        feet = SKSpriteNode(texture: firstFeetFrame)
        feet.zPosition = 5
        feet.yScale = 0.5;
        feet.xScale = 0.5;
        feet.zRotation = 0.4;
        
        let firstBodyFrame = playerBody[0]
        body = SKSpriteNode(texture: firstBodyFrame)
        body.zPosition = 10
        body.yScale = 0.5;
        body.xScale = 0.5;
        body.zRotation = 0.4;
        body.physicsBody = SKPhysicsBody(rectangleOfSize: body.size)
        body.physicsBody?.collisionBitMask = 0b1;
        body.physicsBody?.contactTestBitMask = 1;
        body.physicsBody?.dynamic = true;
    }
    
    static func getPlayer()-> Player {
        return instance
    }
    
    func walkPlayer() {
        
        feet.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(playerFeet,
                timePerFrame: 0.05,
                resize: false,
                restore: true)),
            withKey:"walkingInPlacePlayer")
        
        body.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(playerBody,
                timePerFrame: 0.05,
                resize: false,
                restore: true)),
            withKey:"walkingInPlacePlayer")
    }
    

}
