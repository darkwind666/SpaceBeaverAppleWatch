//
//  GamePlayerController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/12/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import Foundation

class GamePlayerController {
    
    static var playerBestScore = 0
    static var playerFinishTutorial = false
    static var currentPlayerScore = 0
    static var newPlayerRecord = false
    
    static var playerBestScoreKey = "playerBestScoreKey"
    static var playerFinishTutorialKey = "playerFinishTutorialKey"
    
    static func setUpPlayerData() {
        
        GamePlayerController.playerBestScore = UserDefaults.standard.integer(
            forKey: playerBestScoreKey)
        GamePlayerController.playerFinishTutorial = UserDefaults.standard.bool(
            forKey: playerFinishTutorialKey)
        
    }
    
    static func savePlayerData() {
        
        UserDefaults.standard.set(GamePlayerController.playerBestScore,
                                  forKey: playerBestScoreKey)
        UserDefaults.standard.set(GamePlayerController.playerFinishTutorial,
                                  forKey: playerFinishTutorialKey)
        
    }
    
}
