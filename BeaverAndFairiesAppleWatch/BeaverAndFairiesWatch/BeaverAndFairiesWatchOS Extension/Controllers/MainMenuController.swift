//
//  MainMenuController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/7/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import WatchKit
import Foundation


class MainMenuController: WKInterfaceController {
    
    @IBOutlet var scoresLabel: WKInterfaceLabel!
    
    var pauseGame = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
        GamePlayerController.setUpPlayerData()
        
        var playerScore = GamePlayerController.playerBestScore
        
        if GamePlayerController.currentPlayerScore > playerScore {
            playerScore = GamePlayerController.currentPlayerScore
        }
        
        scoresLabel.setText("Best: " + String(playerScore))
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func gameCenterButtonPressed() {
    }
    

}
