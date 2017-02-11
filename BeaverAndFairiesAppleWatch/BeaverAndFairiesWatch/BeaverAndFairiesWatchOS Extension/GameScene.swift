//
//  GameScene.swift
//  BeaverAndFairiesWatchOS Extension
//
//  Created by Sasha Khotiashov on 1/29/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gameController: MainGameController!
    var scoreLabel:SKLabelNode!
    
    var stopGame = false
    
    let blockBordersTemplates = ["1-5", "1-6", "1-7", "1-8", "1-9", "1-10", "1-11"]
    let blockTasksTemplates = ["1-12", "1-13", "1-14", "1-15", "1-17-2"]
    
    let blockSize = CGSize(width: 309, height: 80)
    let blockTaskSize = CGSize(width: 60, height: 70)
    let loseBlocksCount = 5
    let distanceBetweeneTasks = 0.01
    let scaleAnimationDuration = 0.1
    
    var blockHeight = 0.0
    var score = 0
    var currentBlocks: Queue<GameBlockModel>!
    
    var blocksSpeed = 2.00
    var spawnTime = 100
    var blockTasksCount = 0
    var blockType = 0
    var randomTasksCount = false
    
    var currentSpawnTime = 0;
    var loseHeight = 0.0
    var lose = false
    
    var moveBlocksController: MoveBlocksController!
    var playerInputController: PlayerInputController!
    
    override func sceneDidLoad() {
        
        blockHeight = Double(blockSize.height)
        loseHeight = Double(loseBlocksCount) * blockHeight
        currentSpawnTime = 0
        currentBlocks = Queue<GameBlockModel>()
        score = 0
        moveBlocksController = MoveBlocksController()
        moveBlocksController.gameLogicController = self
        playerInputController = PlayerInputController()
        playerInputController.gameLogicController = self
        
        scoreLabel = childNode(withName: "playerScoreLabel") as? SKLabelNode
        scoreLabel.text = String(score)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if lose == false && stopGame == false {
            spawnNewBlock()
            playerInputController.getUserInput()
            moveBlocksController.moveDownBlocks()
            checkGameResult()
        }
        
        scoreLabel.text = String(score)
    }
    
    func spawnNewBlock() {
        
        currentSpawnTime += 1
        
        if currentSpawnTime >= spawnTime {
            
            currentSpawnTime = 0
            
            let newBlock = GameBlockModel()
            
            let borderIndex = Int(arc4random_uniform(UInt32(blockBordersTemplates.count)))
            let blockBorder = SKSpriteNode(imageNamed: blockBordersTemplates[borderIndex])
            blockBorder.size = blockSize
            blockBorder.position = CGPoint(x: blockBorder.position.x, y: 100)
            addChild(blockBorder)
            newBlock.blockGraphicNode = blockBorder
            
            var taskCount = blockTasksCount
            if(randomTasksCount)
            {
                taskCount = 1 + Int(arc4random_uniform(UInt32(blockTasksCount + 1)))
            }
            
            var tasksLength = 0.0
            
            for _ in 0...taskCount {
                
                var blockIndex = blockType
                if blockType == 0 {
                    blockIndex = Int(arc4random_uniform(UInt32(blockTasksTemplates.count - 1)))
                }
                
                let blockTaskModel = GameBlockTaskModel()
                blockTaskModel.taskType = blockIndex
                let blockTaskGraphic = SKSpriteNode(imageNamed: blockTasksTemplates[blockIndex])
                
                blockTaskGraphic.size = blockTaskSize
                blockTaskModel.blockTaskGraphicNode = blockTaskGraphic
                blockBorder.addChild(blockTaskGraphic)
                
                newBlock.blockTasks.append(blockTaskModel)
                tasksLength += Double(blockTaskGraphic.frame.width + CGFloat(distanceBetweeneTasks))
                
            }
            
            tasksLength -= distanceBetweeneTasks
            var startX = -tasksLength / 2.0
            
            for task in newBlock.blockTasks {
                
                let width = task.blockTaskGraphicNode.frame.width
                task.blockTaskGraphicNode.position = CGPoint( x: CGFloat(startX) + CGFloat(width / 2), y: task.blockTaskGraphicNode.position.y)
                startX += (Double(width) + distanceBetweeneTasks)
                
            }
            
            currentBlocks.enqueue(newBlock)
        }
        
    }
    
    func showErrorSwipeAnimation() {
        
        let firstBlock = currentBlocks.front
        let firstTask = firstBlock?.blockTasks[0]
        
        let startScale = firstTask?.blockTaskGraphicNode.scaleAsPoint
        let newScale = CGPoint(x: (startScale?.x)! * 1.5, y: (startScale?.y)! * 1.5)
        
        let scaleUpAction = SKAction.scale(to: CGSize(width: newScale.x, height: newScale.y), duration: scaleAnimationDuration)
        let scaleDownAction = SKAction.scale(to: CGSize(width: (startScale?.x)!, height: (startScale?.y)!), duration: scaleAnimationDuration)
        let sequence = SKAction.sequence([scaleUpAction, scaleDownAction])
        
        firstTask?.blockTaskGraphicNode.run(sequence)
    }
    
    func removeFirstBlock() {
        
        let firstBlock = currentBlocks.dequeue()
        firstBlock?.blockGraphicNode.removeFromParent()
        startMoveUpBlocks()
    }
    
    func startMoveUpBlocks() {
        for block in currentBlocks.array {
            
            if block.placed == true {
                block.placed = false
            }
            
        }
    }
    
    func checkGameResult() {
        for block in currentBlocks.array {
            
            if block.placed == true && block.blockGraphicNode.position.y > CGFloat(loseHeight * blockHeight) {
                lose = true;
                stopGame = true;
                break;
            }
            
        }
    }
    
    func pauseGame() {
        stopGame = true
    }
    
    func resumeGame() {
        stopGame = false
    }
    
}
