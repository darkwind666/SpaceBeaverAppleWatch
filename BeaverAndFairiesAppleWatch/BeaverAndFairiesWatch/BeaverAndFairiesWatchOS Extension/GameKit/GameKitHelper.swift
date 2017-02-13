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
  
  var authenticationViewController: WKInterfaceController?
  var gameCenterEnabled = false
  
  func authenticateLocalPlayer() {
    
    #if !arch(i386) || !arch(x86_64)
        
    #else
        
        // 1
        GKLocalPlayer.localPlayer().authenticateHandler =
            { (viewController, error) in
                // 2
                self.gameCenterEnabled = false
                if viewController != nil {
                    // 3
                    self.authenticationViewController = viewController
                    NotificationCenter.default.post(name: NSNotification.Name(
                        GameKitHelper.PresentAuthenticationViewController),
                                                    object: self)
                } else if GKLocalPlayer.localPlayer().isAuthenticated {
                    // 4
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
  
  func reportScore(score: Int64, forLeaderboardID leaderboardID: String, errorHandler: ((Error?)->Void)? = nil) {
    guard gameCenterEnabled else {
      return
    }
    
    #if !arch(i386) || !arch(x86_64)
        
    #else
        
        //1
        let gkScore = GKScore(leaderboardIdentifier: leaderboardID)
        gkScore.value = score
        
        //2
        GKScore.report([gkScore], withCompletionHandler: errorHandler)
        
    #endif
    
  }
}
