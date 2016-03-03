//
//  SevenYearsTableViewCell.swift
//  OneMinute
//
//  Created by Q on 16/3/2.
//  Copyright © 2016年 zwq. All rights reserved.
//

import UIKit

class SevenYearsTableViewCell: UITableViewCell {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var remainedPercentageLabe: UILabel!
    @IBOutlet weak var totalDaysLabel: UILabel!
    @IBOutlet weak var elapsedDaysLabel: UILabel!
    @IBOutlet weak var remainDaysLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        configureProgressView()
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureProgressView() {
        
        self.progressView.layer.cornerRadius = 3
        self.progressView.layer.borderColor = UIColor.blueColor().CGColor
        self.progressView.layer.borderWidth = 0.5
        self.progressView.clipsToBounds = true
        
    }
    
    func configurelifeLabel() {
        
    }

}
