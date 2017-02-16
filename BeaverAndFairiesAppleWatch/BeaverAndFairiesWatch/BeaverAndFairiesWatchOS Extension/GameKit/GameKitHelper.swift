/*
 * Copyright (c) 2016-2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import WatchKit
import Foundation

#if !arch(i386) || !arch(x86_64)
    
#else
    import GameKit
#endif

class GameKitHelper: NSObject {
  
  static let sharedInstance = GameKitHelper()
  static let PresentAuthenticationViewController =
    "PresentAuthenticationViewController"
  static let leaderboardId = "CgkIqZnn8MUPEAIQAA"
  
  var authenticationViewController: WKInterfaceController?
  var gameCenterEnabled = false
  
  func authenticateLocalPlayer() {
    
    #if !arch(i386) || !arch(x86_64)
        
    #else
        
        GKLocalPlayer.localPlayer().authenticateHandler =
            { (viewController, error) in
                
                if let error = error {
                    self.gameCenterEnabled = false
                }
                else {
                    self.gameCenterEnabled = true
                }
        }
        
    #endif
    
  }
  
  func showGKGameCenterViewController(viewController: WKInterfaceController) {
    guard gameCenterEnabled else {
      return
    }
    
    #if !arch(i386) || !arch(x86_64)
        
    #else
        
        //1
        let gameCenterViewController = GKGameCenterViewController()
        
        //2
        gameCenterViewController.gameCenterDelegate = self
        
        //3
        viewController.present(gameCenterViewController,
                               animated: true, completion: nil)
        
    #endif
    
  }
  
  func reportScore(score: Int64, errorHandler: ((Error?)->Void)? = nil) {
    guard gameCenterEnabled else {
      return
    }
    
    #if !arch(i386) || !arch(x86_64)
        
    #else
        
        //1
        let gkScore = GKScore(leaderboardIdentifier: leaderboardId)
        gkScore.value = score
        
        //2
        GKScore.report([gkScore], withCompletionHandler: errorHandler)
        
    #endif
    }

    func getPlayerScores(succesCallback: @escaping ([PlayerRecordModel])->(), errorCallback: @escaping ()->()) {
        
        #if !arch(i386) || !arch(x86_64)
            errorCallback()
        #else
            
            let leaderBoardRequest = GKLeaderboard()
            leaderBoardRequest.identifier = leaderboardId // my GC Leaderboard ID
            leaderBoardRequest.playerScope = GKLeaderboardPlayerScope.Global
            leaderBoardRequest.timeScope = GKLeaderboardTimeScope.AllTime
            leaderBoardRequest.range = NSMakeRange(1,10) // top 10
            
            leaderBoardRequest.loadScoresWithCompletionHandler
                { (scores, error) -> Void in
                    if (error != nil)
                    {
                        errorCallback()
                    } else if (scores != nil)
                    {
                        
                        var records = [PlayerRecordModel]()
                        
                        for score in scores {
                            let record = PlayerRecordModel()
                            record.playerRecord = score.value
                            record.playerName = score.player.alias!
                            records.append(record)
                        }
                        
                        succesCallback(records)
                        
                    } else {
                        errorCallback()
                    }
            }
            
        #endif
        
    }
    
}
