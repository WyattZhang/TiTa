//
//  OneMinuteViewController.swift
//  OneMinute
//
//  Created by Q on 16/2/25.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class OneMinuteViewController: UIViewController {
    
    
    @IBOutlet weak var circularProgressView = GradientCircularProgressView()
//    let progress = GradientCircularProgress()
    var timer: NSTimer?
    var v: Double = 0.0
    var available: Bool = true
    var counter = 60
    
    private var viewRect: CGRect?
    private var blurView: UIVisualEffectView?
//    private var progressAtRatioView: ProgressAtRatioView?
//    private var circularProgressView: CircularProgressView?
    internal var prop: Property?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    @IBAction func startOneMinute(sender: UIButton) {
        self.circularProgressView!.progress.showAtRatio(display: true, style: BlueDarkStyle())
        self.startProgressAtRatio()
    }

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
        self.v = self.v + 1/60
        
        self.circularProgressView?.progress.updateRatio(CGFloat(v))
        
        self.circularProgressView?.progress.updateString("\(Int(counter/10) + 1)")
        
        if self.v > 1.00 {
            self.timer!.invalidate()
            timer = nil
//            self.progress.dismiss() {
//                Void in
            self.available = true
            self.circularProgressView?.progress.updateString("0")
            self.counter = 60
//            }
            return
        }
    }

}
