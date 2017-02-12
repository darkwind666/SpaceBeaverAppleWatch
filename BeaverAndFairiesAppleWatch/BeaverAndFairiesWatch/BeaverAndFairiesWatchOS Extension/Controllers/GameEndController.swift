//
//  GamePauseController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/7/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import WatchKit
import Foundation


class GameEndController: WKInterfaceController {
    @IBOutlet var scoreLabel: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
        
        var firstLabelText = "Score: "
        
        if GamePlayerController.newPlayerRecord == true {
            firstLabelText = "New record: "
            GamePlayerController.newPlayerRecord = false
        }
        
        scoreLabel.setText(firstLabelText + String(GamePlayerController.currentPlayerScore))
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func replayPressed() {
        pop()
    }
    
    @IBAction func backPressed() {
        popToRootController()
    }

}
