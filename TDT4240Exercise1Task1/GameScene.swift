//
//  GameScene.swift
//  TDT4240Exercise1Task1
//
//  Created by Kristoffer Larsen on 06.02.16.
//  Copyright (c) 2016 Kristoffer Larsen. All rights reserved.
//

import TDT4240Exercise1Task1
import SpriteKit

var cords : SKLabelNode!
var lastPoint = CGPoint.zero
var hasCurrentTouch = false;
var moved = false;
var rotate = false;
var player:Player!

class GameScene: SKScene,SKPhysicsContactDelegate{
    
    override func didMoveToView(view: SKView) {
        
        // SETUP GAMESCENE
        backgroundColor = (UIColor.whiteColor());
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame);
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.dynamic = true;
        physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        player = Player.getPlayer()
        // CREATE AND POSITION CORDINATES
        cords = SKLabelNode();
        cords.fontColor = UIColor.blackColor();
        cords.position = CGPoint(x:CGRectGetMinY(self.frame)+100, y:CGRectGetMaxY(self.frame)-30)
        addChild(cords);
        
        // CREATE A PLAYER
        player.body.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        player.feet.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(player.feet);
        addChild(player.body);
        player.walkPlayer()
        
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        
        let playerX = String(Int(player.body.position.x));
        let playerY = String(Int(player.body.position.y));
        cords.text = "X: "+playerX+" Y: "+playerY;
        player.feet.zRotation = player.body.zRotation
        player.feet.position = player.body.position

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        for touch in touches {
            
            if(hasCurrentTouch){
    
                rotate = true;
            
            } else {
                
                hasCurrentTouch = true;
                
            }
        
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if(!moved){
            
            for touch in touches {
            
            
                let location = touch.locationInNode(self)
                let diff = CGPointMake(location.x - player.body.position.x, location.y - player.body.position.y);
                let angleRadians = CGFloat(atan2f(Float(diff.y), Float(diff.x)));
            
                let rotate = SKAction.rotateToAngle(angleRadians, duration: 0.8)
                let move = SKAction.moveByX(diff.x, y: diff.y, duration: 2);
            
                let sequence = SKAction.sequence([rotate, move])
            
                player.body.runAction(sequence)
            
            
            }
        }
        
        hasCurrentTouch = false;
        moved = false;
        rotate = false;
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        moved = true;
        let touch = touches.first
        let currentPoint = touch!.locationInView(view)
        
        if(!rotate){
            
            if(currentPoint.y < lastPoint.y){
                player.feet.yScale += 0.01;
                player.feet.xScale += 0.01;
                player.body.yScale += 0.01;
                player.body.xScale += 0.01;
            }
        
            if(lastPoint.y < currentPoint.y){
                player.feet.yScale -= 0.01;
                player.feet.xScale -= 0.01;
                player.body.yScale -= 0.01;
                player.body.xScale -= 0.01;
            }
        }
        
        if(hasCurrentTouch && rotate){
            
            
            if(currentPoint.y < lastPoint.y){
                player.feet.zRotation += 0.1;
                player.body.zRotation += 0.1;
            }
            
            if(lastPoint.y < currentPoint.y){
                player.feet.zRotation -= 0.1;
                player.body.zRotation -= 0.1;
            }
            
        }
        
        lastPoint = currentPoint
        
        
    }
    

}
