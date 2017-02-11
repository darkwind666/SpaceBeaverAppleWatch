//
//  InterfaceController.swift
//  BeaverAndFairiesWatchOS Extension
//
//  Created by Sasha Khotiashov on 1/29/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import WatchKit
import Foundation

enum PlayerDirection {
    case Tap
    case Right
    case Left
    case Up
    case Down
    case None
}

class MainGameController: WKInterfaceController {

    @IBOutlet var skInterface: WKInterfaceSKScene!
    
    var playerDirection: PlayerDirection = .None
    private var gameScene:GameScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = GameScene(fileNamed: "MainGameScene") {
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            scene.gameController = self
            gameScene = scene
            
            // Present the scene
            self.skInterface.presentScene(scene)
            
            // Use a value that will maintain a consistent frame rate
            self.skInterface.preferredFramesPerSecond = 30
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        gameScene.pauseGame()
    }
    
    @IBAction func resumeGamePressed() {
        pushController(withName: "GameEndController", context: Any?.self)
    }
    
    @IBAction func backPressed() {
        pop()
    }
    
    @IBAction func userTap(_ sender: Any) {
        playerDirection = .Tap
    }
    
    @IBAction func userSwapRight(_ sender: Any) {
        playerDirection = .Right
    }
    
    @IBAction func userSwapLeft(_ sender: Any) {
        playerDirection = .Left
    }
    
    @IBAction func userSwapUp(_ sender: Any) {
        playerDirection = .Up
    }
    
    @IBAction func userSwapDown(_ sender: Any) {
        playerDirection = .Down
    }

}
