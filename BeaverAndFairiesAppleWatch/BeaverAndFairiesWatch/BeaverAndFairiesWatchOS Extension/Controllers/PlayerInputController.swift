//
//  PlayerInputController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/10/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import SpriteKit

class PlayerInputController {
    
    var gameLogicController: GameScene!
    
    func getUserInput() {
        
        if gameLogicController.currentBlocks.count > 0 {
            
            let firstBlock = gameLogicController.currentBlocks.front
            let blockTasks = firstBlock?.blockTasks
            let firstBlockTask = blockTasks?[0]
            let blockType = firstBlockTask?.taskType
            
            var rigthSwipe = false
            
            if blockType == 0 && gameLogicController.gameController.playerDirection == .Left {
                firstBlock?.blockTasks.removeFirst()
                firstBlockTask?.blockTaskGraphicNode.removeFromParent()
                gameLogicController.score += 1
                rigthSwipe = true
            }
            
            if blockType == 1 && gameLogicController.gameController.playerDirection == .Right {
                firstBlock?.blockTasks.removeFirst()
                firstBlockTask?.blockTaskGraphicNode.removeFromParent()
                gameLogicController.score += 1
                rigthSwipe = true
            }
            
            if blockType == 2 && gameLogicController.gameController.playerDirection == .Up {
                firstBlock?.blockTasks.removeFirst()
                firstBlockTask?.blockTaskGraphicNode.removeFromParent()
                gameLogicController.score += 1
                rigthSwipe = true
            }
            
            if blockType == 3 && gameLogicController.gameController.playerDirection == .Down {
                firstBlock?.blockTasks.removeFirst()
                firstBlockTask?.blockTaskGraphicNode.removeFromParent()
                gameLogicController.score += 1
                rigthSwipe = true
            }
            
            if blockType == 4 && gameLogicController.gameController.playerDirection == .Tap {
                firstBlock?.blockTasks.removeFirst()
                firstBlockTask?.blockTaskGraphicNode.removeFromParent()
                gameLogicController.score += 1
            }
            
            if (firstBlock?.blockTasks.count)! <= 0 {
                gameLogicController.removeFirstBlock()
            }
            
            if(blockType! < 5 && rigthSwipe == false &&
                gameLogicController.gameController.playerDirection != .None && gameLogicController.currentBlocks.count > 0){
                gameLogicController.showErrorSwipeAnimation()
            }
            
        }
        
        GamePlayerController.currentPlayerScore = gameLogicController.score
        gameLogicController.gameController.playerDirection = .None
        
    }
    
}
