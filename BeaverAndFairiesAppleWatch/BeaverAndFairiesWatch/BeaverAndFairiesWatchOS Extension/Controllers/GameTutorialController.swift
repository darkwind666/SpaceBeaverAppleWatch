//
//  GameTutorialController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/15/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import SpriteKit

class GameTutorialController {
    
    var tutorialParts = ["tutorial1", "tutorial2", "tutorial3", "tutorial4"]
    var gameLogicController:GameScene!
    
    var currentTutorialIndex = 0
    var activeTutorial = false
    
    var currentTutorialNode: SKNode!
    
    func startTutorial() {
        
        currentTutorialIndex = 0
        if GamePlayerController.playerFinishTutorial == false
        {
            activeTutorial = true
            gameLogicController.pauseGame()
            currentTutorialNode = gameLogicController.childNode(withName: tutorialParts[currentTutorialIndex])
            currentTutorialNode.alpha = 1.0
        }
    }
    
    func update() {
        
        if activeTutorial == true {
            
            let playerSwipeDirection = gameLogicController.gameController.playerDirection
            
            if currentTutorialIndex == 0 && playerSwipeDirection == .Right {
                goToNextTutorial()
            }
            
            if currentTutorialIndex == 1 && playerSwipeDirection == .Left
            {
                goToNextTutorial()
            }
            
            if currentTutorialIndex == 2 && playerSwipeDirection == .Up
            {
                goToNextTutorial()
            }
            
            if currentTutorialIndex == 3 && playerSwipeDirection == .Down
            {
                activeTutorial = false
                currentTutorialNode.removeAllActions()
                currentTutorialNode.removeFromParent()
                GamePlayerController.playerFinishTutorial = true
                GamePlayerController.savePlayerData()
                gameLogicController.resumeGame()
            }
            
        }
    }
    
    func goToNextTutorial() {
        currentTutorialIndex += 1
        currentTutorialNode.removeAllActions()
        currentTutorialNode.alpha = 0.0
        currentTutorialNode = gameLogicController.childNode(withName: tutorialParts[currentTutorialIndex])
        currentTutorialNode.alpha = 1.0
    }
    
}
