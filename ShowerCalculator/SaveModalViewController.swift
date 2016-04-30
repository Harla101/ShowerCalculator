//
//  SaveModalViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/27/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit

class SaveModalViewController: UIViewController {
	@IBOutlet weak var timeTakenLabel: UILabel!
	@IBOutlet weak var waterUsedLabel: UILabel!
	@IBOutlet weak var dateAndTimeLabel: UILabel!
	@IBOutlet weak var waterUnitLabel: UILabel!
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	var timeTaken = ""
	var waterUsed = ""
	
	let timeNow = NSDate()
	let dateFormatter = NSDateFormatter()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		updateLabels()
		
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	@IBAction func cancelButtonTapped(sender: UIButton) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	@IBAction func saveButtonTapped(sender: UIButton) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	
	func updateLabels() {
		checkForLiters()
		timeTakenLabel.text = timeTaken
		waterUsedLabel.text = waterUsed
		
		dateFormatter.locale = NSLocale.currentLocale()
		dateFormatter.dateStyle = .MediumStyle
		dateFormatter.timeStyle = .ShortStyle
		let convertedDateStr = dateFormatter.stringFromDate(timeNow)
		dateAndTimeLabel.text = convertedDateStr
		
	}
	
	func checkForLiters () {
		let usingLiters = defaults.boolForKey("useLiters")
		if usingLiters {
			waterUnitLabel.text = "Liters used:"
		} else {
			waterUnitLabel.text = "Gallons used:"
		}
	}
	
	}