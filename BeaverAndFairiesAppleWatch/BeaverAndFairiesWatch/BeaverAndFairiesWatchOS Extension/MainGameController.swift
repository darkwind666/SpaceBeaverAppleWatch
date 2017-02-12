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
        
        if let scene = GameScene(fileNamed: "MainGameScene") {
            
            scene.scaleMode = .aspectFill
            scene.gameController = self
            gameScene = scene
            self.skInterface.presentScene(scene)
            self.skInterface.preferredFramesPerSecond = 30
            
        }
    }
    
    override func willActivate() {
        super.willActivate()
        
        if gameScene.lose == true {
            gameScene.replayGame()
        }
        
        gameScene.resumeGame()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        savePlayerScore()
        gameScene.pauseGame()
    }
    
    func savePlayerScore() {
        if gameScene.score > GamePlayerController.playerBestScore {
            GamePlayerController.playerBestScore = gameScene.score
            GamePlayerController.savePlayerData()
        }
    }
    
    func showEndGamePopUp() {
        pushController(withName: "GameEndController", context: Any?.self)
    }
    
    @IBAction func resumeGamePressed() {
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
