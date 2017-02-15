//
//  GameStageModel.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/14/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import Foundation

class GameStageModel {
    
    var speed = 0.0
    var distanceBetweeneBlocks = 0.0
    var taskCount = 0
    var blocktype = 0
    var randomTaskCount = 0
    var timeInterval = 0
    
    init(speed: Double, distanceBetweeneBlocks: Double, taskCount: Int, blocktype: Int, randomTaskCount: Int, timeInterval: Int) {
        
        self.speed = speed
        self.distanceBetweeneBlocks = distanceBetweeneBlocks
        self.taskCount = taskCount
        self.blocktype = blocktype
        self.randomTaskCount = randomTaskCount
        self.timeInterval = timeInterval
        
    }
    
}
