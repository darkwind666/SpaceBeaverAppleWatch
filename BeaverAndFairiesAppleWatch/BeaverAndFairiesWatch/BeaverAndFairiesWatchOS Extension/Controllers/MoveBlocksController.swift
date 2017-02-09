//
//  MoveBlocksController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/9/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import SpriteKit

class MoveBlocksController {
    
    var gameLogicController: GameScene!
    
    func moveDownBlocks() {
        for block in gameLogicController.currentBlocks.array {
            if block.placed == false {
                tryToMoveDownBlock(block: block)
            }
        }
    }
    
    func tryToMoveDownBlock(block: GameBlockModel) {
        
        let currentBlockPosition = block.blockGraphicNode.position
        let newBlockPosition = CGPoint(x: currentBlockPosition.x, y: currentBlockPosition.y - gameLogicController.blocksSpeed)
        block.blockGraphicNode.position = newBlockPosition
        
        var loseHeight = (gameLogicController._blockHeight / 2)
        
        if newBlockPosition.y < loseHeight {
            
            block.placed = true
            block.blockGraphicNode.position = CGPoint(x: newBlockPosition.x, y: newBlockPosition.y + gameLogicController.blocksSpeed)
            
        } else {
            
            for blockForCollision in gameLogicController.currentBlocks.array {
                
                if blockForCollision != block {
                    
                    if block.blockGraphicNode.frame.intersects(blockForCollision.blockGraphicNode.frame || block.blockGraphicNode.position.y < loseHeight) {
                        
                        var index = gameLogicController.currentBlocks.array.indexOf(block)
                        block.placed = true
                        var blockHeight = block.blockGraphicNode.frame.height
                        var blockForCollisionPosition = blockForCollision.blockGraphicNode.position
                        var finalPosition = CGPoint(x: blockForCollisionPosition.x, y: blockForCollisionPosition.y + gameLogicController.blocksSpeed + blockHeight + 0.01)
                        block.blockGraphicNode.position = finalPosition
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
}
