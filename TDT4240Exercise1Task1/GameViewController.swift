//
//  GameViewController.swift
//  TDT4240Exercise1Task1
//
//  Created by Kristoffer Larsen on 06.02.16.
//  Copyright (c) 2016 Kristoffer Larsen. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
