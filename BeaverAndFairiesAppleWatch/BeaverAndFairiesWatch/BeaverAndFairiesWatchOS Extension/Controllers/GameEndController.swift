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
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func replayPressed() {
        pop()
    }
    
    @IBAction func backPressed() {
        popToRootController()
    }

}
