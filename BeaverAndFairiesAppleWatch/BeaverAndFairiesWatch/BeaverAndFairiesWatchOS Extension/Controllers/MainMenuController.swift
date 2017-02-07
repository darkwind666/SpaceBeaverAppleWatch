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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        scoresLabel.setText("")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func gameCenterButtonPressed() {
    }
    

}
