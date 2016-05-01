//
//  HistoryTableViewCell.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/30/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var showerLengthLabel: UILabel!
	@IBOutlet weak var waterUsedLabel: UILabel!
	@IBOutlet weak var noDataLabel: UILabel!
	
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
