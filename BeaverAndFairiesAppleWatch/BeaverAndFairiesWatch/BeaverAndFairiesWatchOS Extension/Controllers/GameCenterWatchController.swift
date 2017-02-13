//
//  GameCenterWatchController.swift
//  BeaverAndFairiesWatch
//
//  Created by Sasha Khotiashov on 2/13/17.
//  Copyright © 2017 Sasha Khotiashov. All rights reserved.
//

import WatchKit
import Foundation


class GameCenterWatchController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    var playersRecords = [PlayerRecordModel]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if GameKitHelper.sharedInstance.gameCenterEnabled == true {
            loadRecordsFromGameCenter()
        } else {
            makeDefaultRecords()
        }
        
        setUpTableView()
    }
    
    func setUpTableView() {
        
        tableView.setNumberOfRows(playersRecords.count, withRowType: "RecordRow")
        
        for index in 0..<tableView.numberOfRows {
            guard let controller = tableView.rowController(at: index) as? PlayerRecordRowController else { continue }
            let playerRecordModel = playersRecords[index]
            controller.playerRecord.setText(String(index + 1) + "  " + playerRecordModel.playerName + ":  " + playerRecordModel.playerRecord)
        }
    }
    
    func makeDefaultRecords() {
        
        let record1 = PlayerRecordModel()
        record1.playerRecord = ""
        record1.playerName = ""
        
        let record2 = PlayerRecordModel()
        record2.playerRecord = ""
        record2.playerName = ""
        
        let record3 = PlayerRecordModel()
        record3.playerRecord = ""
        record3.playerName = ""
        
        playersRecords = [record1, record2, record3]
    }
    
    func loadRecordsFromGameCenter() {
        
        GameKitHelper.sharedInstance.getPlayerScores(succesCallback: { records in
            self.playersRecords = records
            self.setUpTableView()
        }) {
            self.makeDefaultRecords()
            self.setUpTableView()
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
