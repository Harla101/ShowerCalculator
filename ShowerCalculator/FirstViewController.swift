//
//  FirstViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/23/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
	@IBOutlet var displayTimeLabel: UILabel!
	@IBOutlet weak var startStopButton: UIButton!
	@IBOutlet weak var gallonsUsedLabel: UILabel!
	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var gallonsUsedStaticLabel: UILabel!
	
	var startTime = NSTimeInterval()
	var timer:NSTimer = NSTimer()
	var waterPerMinute = 2.1
	
	var isConvertedToLiters = false
	

	@IBOutlet var calcBackground: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		displayTimeLabel.text = "00:00:00"
		
		if isConvertedToLiters {
			let gallonsToLiters = waterPerMinute * 3.785
			waterPerMinute = gallonsToLiters
			gallonsUsedStaticLabel.text = "Liters used"
		}
	}
	
	@IBAction func startStopButtonPressed(sender: UIButton) {
		if !timer.valid {
			displayTimeLabel.hidden = false
			gallonsUsedLabel.hidden = false
			gallonsUsedStaticLabel.hidden = false
		timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(FirstViewController.updateTime), userInfo: nil, repeats: true)
		startTime = NSDate.timeIntervalSinceReferenceDate()
		startStopButton.setImage(UIImage(named: "StopButton"), forState: .Normal)
			saveButton.hidden = true

		} else {
			timer.invalidate()
			startStopButton.setImage(UIImage(named: "StartButton"), forState: .Normal)
			saveButton.hidden = false
			
		}
	}
	
	@IBAction func resetButtonPressed(sender: AnyObject) {
			timer.invalidate()
			displayTimeLabel.text = "00:00:00"
			gallonsUsedLabel.text = "0.00"
			startStopButton.setImage(UIImage(named: "StartButton"), forState: .Normal)
			saveButton.hidden = true
			
	}

	
	func updateTime() {
		let currentTime = NSDate.timeIntervalSinceReferenceDate()
		
		//Find the difference between current time and start time.
		var elapsedTime: NSTimeInterval = currentTime - startTime
		
		//calculate the minutes in elapsed time.
		let minutes = UInt8(elapsedTime / 60.0)
		elapsedTime -= (NSTimeInterval(minutes) * 60)
		
		//calculate the seconds in elapsed time.
		let seconds = UInt8(elapsedTime)
		elapsedTime -= NSTimeInterval(seconds)
		
		//find out the fraction of milliseconds to be displayed.
		let fraction = UInt8(elapsedTime * 100)
		
		//add the leading zero for minutes, seconds and millseconds and store them as string constants
		
		let strMinutes = String(format: "%02d", minutes)
		let strSeconds = String(format: "%02d", seconds)
		let strFraction = String(format: "%02d", fraction)
		
		//calculate Water Used (in Gallons per minute)

		let gallonsUsed =  (Double(strMinutes)! * waterPerMinute) + (Double(strSeconds)! * (waterPerMinute / 60)) + (Double(strFraction)! * (waterPerMinute / 6000))
		let strGallonsUsed = String(format: "%.2f", gallonsUsed)

		
		//concatenate minuets, seconds and milliseconds as assign it to the UILabel
		displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
		gallonsUsedLabel.text = "\(strGallonsUsed)"
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	


}
