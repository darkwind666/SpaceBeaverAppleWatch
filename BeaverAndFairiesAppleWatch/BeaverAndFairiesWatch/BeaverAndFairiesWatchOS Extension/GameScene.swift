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
    var backgroundSound: SKAudioNode!
    
    var stopGame = false
    
    let blockBordersTemplates = ["1-5", "1-6", "1-7", "1-8", "1-9", "1-10", "1-11"]
    let blockTasksTemplates = ["Left", "Right", "Up", "Down", "Tap"]
    
    let blockSize = CGSize(width: 309, height: 80)
    let blockTaskSize = CGSize(width: 60, height: 70)
    let loseBlocksCount = 5
    let distanceBetweeneTasks = 0.01
    let scaleAnimationDuration = 0.3
    let finalPosition = 140
    
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
    var gameBalanceController: GameBalanceController!
    
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
        gameBalanceController = GameBalanceController()
        gameBalanceController.gameLogicController = self
        
        scoreLabel = childNode(withName: "playerScoreLabel") as? SKLabelNode
        scoreLabel.text = String(score)
        
        backgroundSound = childNode(withName: "gameBackgroundSound") as? SKAudioNode
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if lose == false && stopGame == false {
            gameBalanceController.updateGameStage()
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
            
            if currentBlocks.array.count > 0 {
                
                let lastBlockPosition = currentBlocks.array.last!.blockGraphicNode.position
                let finalHeight = Double(lastBlockPosition.y + CGFloat(blockHeight / 2))
                let newBlockBottomHeight = Double(finalPosition) - blockHeight / 2
                
                if finalHeight < newBlockBottomHeight {
                    self.createNewBlockOnYPosition(yPosition: CGFloat(finalPosition))
                } else {
                    self.createNewBlockOnYPosition(yPosition: CGFloat(finalHeight + blockHeight / 2) + 1)
                }
                
            } else {
                self.createNewBlockOnYPosition(yPosition: CGFloat(finalPosition))
            }
            
        }
        
    }
    
    func createNewBlockOnYPosition(yPosition: CGFloat) {
        
        currentSpawnTime = 0
        let newBlock = GameBlockModel()
        
        let borderIndex = Int(arc4random_uniform(UInt32(blockBordersTemplates.count)))
        let blockBorder = SKSpriteNode(imageNamed: blockBordersTemplates[borderIndex])
        blockBorder.size = blockSize
        blockBorder.position = CGPoint(x: blockBorder.position.x, y: yPosition)
        
        
        addChild(blockBorder)
        newBlock.blockGraphicNode = blockBorder
        
        var taskCount = blockTasksCount - 1
        if(randomTasksCount)
        {
            taskCount = Int(arc4random_uniform(UInt32(blockTasksCount)))
        }
        
        var tasksLength = 0.0
        
        for _ in 0...taskCount {
            
            var blockIndex = blockType
            if blockType == 0 {
                blockIndex = Int(arc4random_uniform(UInt32(blockTasksTemplates.count)))
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
    
    func showErrorSwipeAnimation() {
        
        let firstBlock = currentBlocks.front
        let firstTask = firstBlock?.blockTasks[0]
        let firstTaskSize = firstTask?.blockTaskGraphicNode.frame.size
        
        let upScaleSize = CGSize(width: (firstTaskSize?.width)! * 1.5, height: (firstTaskSize?.height)! * 1.5)
        let downScaleSize = firstTaskSize
        
        let scaleUpAction = SKAction.scale(to: upScaleSize, duration: scaleAnimationDuration)
        let scaleDownAction = SKAction.scale(to: downScaleSize!, duration: scaleAnimationDuration)
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
            if block.placed == true && block.blockGraphicNode.position.y >= CGFloat(finalPosition) {
                endGame()
                break
            }
        }
    }
    
    func endGame() {
        
        lose = true;
        stopGame = true
        
        GamePlayerController.currentPlayerScore = score
        
        if score > GamePlayerController.playerBestScore {
            GamePlayerController.playerBestScore = score
            GamePlayerController.newPlayerRecord = true
            GamePlayerController.savePlayerData()
            reportScoreToGameCenter()
        }
        
        gameController.showEndGamePopUp()
    }
    
    func reportScoreToGameCenter() {
        GameKitHelper.sharedInstance.reportScore(score: Int64(score))
    }
    
    func pauseGame() {
        stopGame = true
    }
    
    func resumeGame() {
        stopGame = false
    }
    
    func replayGame() {
        
        score = 0
        scoreLabel.text = String(score)
        
        lose = false
        
        for block in currentBlocks.array {
            block.blockGraphicNode.removeAllChildren()
            block.blockGraphicNode.removeFromParent()
        }
        
        currentBlocks = Queue<GameBlockModel>()
    }
    
}
