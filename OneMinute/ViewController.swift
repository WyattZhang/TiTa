//
//  ViewController.swift
//  OneMinute
//
//  Created by Q on 16/1/31.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let progress = GradientCircularProgress()
    var timer: NSTimer?
    var v: Double = 0.0
    var available: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.progress.showAtRatio(display: true, style: BlueDarkStyle())
        self.startProgressAtRatio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    func startProgressAtRatio() {
        self.v = 0.0
        self.timer = NSTimer.scheduledTimerWithTimeInterval(
            0.01,
            target: self,
            selector: "updateProgressAtRatio",
            userInfo: nil,
            repeats: true
        )
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
    }
    
    func updateProgressAtRatio() {
        self.v += 0.001
        
        self.progress.updateRatio(CGFloat(v))
        
        if self.v > 1.00 {
            self.timer!.invalidate()
            self.progress.dismiss() { Void in
                self.available = true
            }
            return
        }
    }
}

