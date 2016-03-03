//
//  TouchIDAuthViewController.swift
//  OneMinute
//
//  Created by Q on 16/3/3.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDAuthViewController: UIViewController {
    
    weak var parentVC: SevenYearsTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authenticateUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authenticateUser() {
        let touchIDManager : PITouchIDManager = PITouchIDManager()
        
        touchIDManager.authenticateUser(success: { () -> () in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                //                self.loadDada()
                let isAuthed = UIApplication.sharedApplication().delegate as! AppDelegate
                isAuthed.isAuthed = true
                
                guard let pvc = self.parentVC else {
                    print("nil")
                    return
                }
                pvc.dismissViewControllerAnimated(true, completion: nil)
                
                })
            }, failure: { (evaluationError: NSError) -> () in
                switch evaluationError.code {
                case LAError.SystemCancel.rawValue:
                    print("Authentication cancelled by the system")
                    //                    self.statusLabel.text = "Authentication cancelled by the system"
                case LAError.UserCancel.rawValue:
                    print("Authentication cancelled by the user")
                    //                    self.statusLabel.text = "Authentication cancelled by the user"
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        self.authenticateUser()
                    })
                    
                case LAError.UserFallback.rawValue:
                    print("User wants to use a password")
                    //                    self.statusLabel.text = "User wants to use a password"
                    // We show the alert view in the main thread (always update the UI in the main thread)
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        //                        self.showPasswordAlert()
                    })
                case LAError.TouchIDNotEnrolled.rawValue:
                    print("TouchID not enrolled")
                    //                    self.statusLabel.text = "TouchID not enrolled"
                case LAError.PasscodeNotSet.rawValue:
                    print("Passcode not set")
                    //                    self.statusLabel.text = "Passcode not set"
                default:
                    print("Authentication failed")
                    //                    self.statusLabel.text = "Authentication failed"
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        //                        self.showPasswordAlert()
                    })
                }
        })
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
