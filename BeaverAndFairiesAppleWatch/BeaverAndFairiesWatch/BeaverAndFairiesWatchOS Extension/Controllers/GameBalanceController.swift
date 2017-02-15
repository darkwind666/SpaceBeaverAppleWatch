//
//  GameBalanceController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/14/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import Foundation

class GameBalanceController {
    
    var gameLogicController: GameScene!
    
    var currentStageIndex = 0
    var currentStageTimeInterval = 0
    var currentStageTime = 0
    
    var gameBalaceData = [GameStageModel]()
    
    var randomStage = false
    
    init() {
        setUpBalanceData()
    }
    
    func updateGameStage() {
        
        if gameLogicController.stopGame == false {
            currentStageTime += 1
            
            if currentStageTime >= currentStageTimeInterval {
                
                currentStageTime = 0
                
                if randomStage == false {
                    currentStageIndex += 1
                    
                    if currentStageIndex >= gameBalaceData.count {
                        
                        randomStage = true
                        currentStageIndex = Int(arc4random_uniform(UInt32(gameBalaceData.count)))
                        
                    }
                    
                } else {
                    currentStageIndex = Int(arc4random_uniform(UInt32(gameBalaceData.count)))
                }
                
                setNewBalance()
            }
        }
        
    }
    
    func setNewBalance() {
        
        let currentStageData = gameBalaceData[currentStageIndex]
        gameLogicController.blocksSpeed = currentStageData.speed * 2 * 25
        
        let spawnTime = (gameLogicController.blockHeight + (currentStageData.distanceBetweeneBlocks * 1)) / gameLogicController.blocksSpeed
        gameLogicController.spawnTime = Int(spawnTime)
        gameLogicController.currentSpawnTime = 0
        gameLogicController.blockTasksCount = currentStageData.taskCount
        gameLogicController.blockType = currentStageData.blocktype
        
        gameLogicController.randomTasksCount = true
        
        if currentStageData.randomTaskCount == 0 {
            gameLogicController.randomTasksCount = false
        }
        
        currentStageTimeInterval = currentStageData.timeInterval * 60
    }
    
    func setUpBalanceData() {
        
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 1.3, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 6))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 0.25, taskCount: 1, blocktype: 1, randomTaskCount: 0, timeInterval: 3))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 6))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 1.3, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 3))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 0.25, taskCount: 1, blocktype: 1, randomTaskCount: 0, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 3))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 2, blocktype: 1, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 2, blocktype: 0, randomTaskCount: 0, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 2, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.25, taskCount: 2, blocktype: 0, randomTaskCount: 1, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 2, blocktype: 1, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 1, blocktype: 1, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 2, blocktype: 0, randomTaskCount: 1, timeInterval: 3))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 0.25, taskCount: 2, blocktype: 0, randomTaskCount: 0, timeInterval: 1))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.7, taskCount: 2, blocktype: 0, randomTaskCount: 0, timeInterval: 1))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 1, blocktype: 1, randomTaskCount: 1, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.25, taskCount: 2, blocktype: 0, randomTaskCount: 1, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 2, blocktype: 0, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 2, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 1.3, taskCount: 2, blocktype: 1, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.25, taskCount: 1, blocktype: 1, randomTaskCount: 0, timeInterval: 6))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 3, blocktype: 1, randomTaskCount: 0, timeInterval: 6))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 2, blocktype: 1, randomTaskCount: 1, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 3, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.01, distanceBetweeneBlocks: 0.7, taskCount: 3, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 3, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.25, taskCount: 3, blocktype: 1, randomTaskCount: 0, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 3, blocktype: 1, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 2, blocktype: 0, randomTaskCount: 1, timeInterval: 3))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 3, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 3, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 4, blocktype: 1, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.7, taskCount: 4, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.7, taskCount: 4, blocktype: 0, randomTaskCount: 0, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.7, taskCount: 4, blocktype: 0, randomTaskCount: 1, timeInterval: 1))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.7, taskCount: 3, blocktype: 1, randomTaskCount: 1, timeInterval: 3))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 2, blocktype: 0, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.7, taskCount: 4, blocktype: 0, randomTaskCount: 1, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 0.7, taskCount: 4, blocktype: 0, randomTaskCount: 1, timeInterval: 1))
        gameBalaceData.append(GameStageModel(speed: 0.01, distanceBetweeneBlocks: 0.7, taskCount: 4, blocktype: 0, randomTaskCount: 1, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 2, blocktype: 1, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.25, taskCount: 1, blocktype: 0, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 5, blocktype: 1, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.3, taskCount: 5, blocktype: 0, randomTaskCount: 1, timeInterval: 6))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.7, taskCount: 5, blocktype: 0, randomTaskCount: 0, timeInterval: 2))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 0.7, taskCount: 1, blocktype: 1, randomTaskCount: 0, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.7, taskCount: 5, blocktype: 1, randomTaskCount: 1, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.06, distanceBetweeneBlocks: 1.7, taskCount: 2, blocktype: 0, randomTaskCount: 1, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.3, taskCount: 5, blocktype: 0, randomTaskCount: 1, timeInterval: 6))
        gameBalaceData.append(GameStageModel(speed: 0.04, distanceBetweeneBlocks: 1.7, taskCount: 5, blocktype: 1, randomTaskCount: 0, timeInterval: 5))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 0.7, taskCount: 5, blocktype: 0, randomTaskCount: 1, timeInterval: 4))
        gameBalaceData.append(GameStageModel(speed: 0.02, distanceBetweeneBlocks: 1.7, taskCount: 5, blocktype: 0, randomTaskCount: 1, timeInterval: 5))
        
        
    }
    
}
