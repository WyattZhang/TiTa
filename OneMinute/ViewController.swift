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
    
    var counter = 600

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
            0.1,
            target: self,
            selector: "updateProgressAtRatio",
            userInfo: nil,
            repeats: true
        )
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
    }
    
    func updateProgressAtRatio() {
        counter--
        self.v = self.v + 1/600
        
        self.progress.updateRatio(CGFloat(v))
        
        self.progress.updateString("\(Int(counter/10) + 1)")
        
        if self.v > 1.00 {
            self.timer!.invalidate()
            timer = nil
//            self.progress.dismiss() { Void in
                self.available = true
            self.progress.updateString("0")
//            }
            return
        }
    }
}

