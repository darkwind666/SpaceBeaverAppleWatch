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
    
    var blockHeight = 0.0
    var score = 0
    var currentBlocks: Queue<GameBlockModel>!
    
    var blocksSpeed = -1.00
    var spawnTime = 0
    var blockTasksCount = 0
    var blockType = 0
    var randomTasksCount = false
    
    var currentSpawnTime = 0;
    var loseHeight = 0.0
    var lose = false
    
    var moveBlocksController: MoveBlocksController!
    
    override func sceneDidLoad() {
        
        scoreLabel = childNode(withName: "playerScoreLabel") as? SKLabelNode
        scoreLabel.text = "11"
        
        let blockNode = SKNode()
        let blockBorder = SKSpriteNode(imageNamed: "1-5")
        blockBorder.size = CGSize(width: 309, height: 80)
        blockNode.addChild(blockBorder)
        addChild(blockNode)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
