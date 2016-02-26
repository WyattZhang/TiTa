//
//  OneMinuteViewController.swift
//  OneMinute
//
//  Created by Q on 16/2/25.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class OneMinuteViewController: UIViewController {
    
    private var timer: NSTimer?
    private var progress: UInt = 0
    private var counter = 60
    private var fourColorCircularProgress: KYCircularProgress!
    private var potoCircularProgress: KYCircularProgress!
    
    @IBOutlet weak var countDownCircularProgress: KYCircularProgress!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func drawPoto() {
        let potoCircularProgressFrame = CGRectMake(fourColorCircularProgress.frame.origin.x+10.0,fourColorCircularProgress.frame.origin.y+10.0, CGRectGetWidth(fourColorCircularProgress.frame)-20.0, CGRectGetHeight(fourColorCircularProgress.frame)-20.0)
        potoCircularProgress = KYCircularProgress(frame: potoCircularProgressFrame)
        
//        fourColorCircularProgress.colors = [UIColor(rgba: 0xA6E39D11), UIColor(rgba: 0xAEC1E355), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xF3C0ABFF)]
        potoCircularProgress.colors = [UIColor.purpleColor(), UIColor(rgba: 0xFFF77A55), UIColor.orangeColor()]
        potoCircularProgress.progress = 1
        view.addSubview(potoCircularProgress)

    }
    
    func drawImus() {
        let fourColorCircularProgressFrame = CGRectMake(countDownCircularProgress.frame.origin.x+10.0,countDownCircularProgress.frame.origin.y+10.0, CGRectGetWidth(countDownCircularProgress.frame)-20.0, CGRectGetHeight(countDownCircularProgress.frame)-20.0)
        fourColorCircularProgress = KYCircularProgress(frame: fourColorCircularProgressFrame)
        
        fourColorCircularProgress.colors = [UIColor(rgba: 0xA6E39D11), UIColor(rgba: 0xAEC1E355), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xF3C0ABFF)]
        fourColorCircularProgress.progress = 1
        view.addSubview(fourColorCircularProgress)
    }
    
    func update() {
        if counter >= 0 {
            counter--
            updateProgress()
            updateTime()
        } else {
            timer!.invalidate()
            timer = nil
            timeLabel.removeFromSuperview()
            counter = 60
            drawImus()
            drawPoto()
        }
    }
    
    func updateProgress() {
        countDownCircularProgress.progress = (1.0 - Double(counter) / 600)
    }
    
    func updateTime() {
        timeLabel.text = "\(Int(counter / 10))"
    }

}
