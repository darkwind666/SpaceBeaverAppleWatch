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
        let newBlockPosition = CGPoint(x: currentBlockPosition.x, y: currentBlockPosition.y - CGFloat(gameLogicController.blocksSpeed))
        block.blockGraphicNode.position = newBlockPosition
        
        //let loseHeight = (gameLogicController.blockHeight / 2)
        let loseHeight = -gameLogicController.blockHeight - 55
        
        if newBlockPosition.y < CGFloat(loseHeight) {
            
            block.placed = true
            block.blockGraphicNode.position = CGPoint(x: newBlockPosition.x, y: newBlockPosition.y + CGFloat(gameLogicController.blocksSpeed))
            
        } else {
            
            for blockForCollision in gameLogicController.currentBlocks.array {
                
                if blockForCollision !== block {
                    
                    if block.blockGraphicNode.frame.intersects(blockForCollision.blockGraphicNode.frame) || (block.blockGraphicNode.position.y < CGFloat(loseHeight)) {
                        
                        block.placed = true
                        let blockHeight = block.blockGraphicNode.frame.height
                        let blockForCollisionPosition = blockForCollision.blockGraphicNode.position
                        let finalPosition = CGPoint(x: blockForCollisionPosition.x, y: blockForCollisionPosition.y + CGFloat(gameLogicController.blocksSpeed) + blockHeight + 0.01 )
                        block.blockGraphicNode.position = finalPosition
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
}
