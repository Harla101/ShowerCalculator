//
//  FirstViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/23/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit



class ShowerTimerViewController: UIViewController {
	@IBOutlet var displayTimeLabel: UILabel!
	@IBOutlet weak var startStopButton: UIButton!
	@IBOutlet weak var gallonsUsedLabel: UILabel!
	@IBOutlet weak var saveButton: UIButton!
	@IBOutlet weak var gallonsUsedStaticLabel: UILabel!
	
	var startTime = NSTimeInterval()
	var timer:NSTimer = NSTimer()
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	
	var waterPerMinute: Double = 2.1
	var usingLiters = false
	
	

	@IBOutlet var calcBackground: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		checkForLiters()
		displayTimeLabel.text = "00:00:00"
		gallonsUsedLabel.adjustsFontSizeToFitWidth = true
		
			}
	
	@IBAction func startStopButtonPressed(sender: UIButton) {
		if !timer.valid {
			waterPerMinute = defaults.doubleForKey("waterPerMinute") as Double

		timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(ShowerTimerViewController.updateTime), userInfo: nil, repeats: true)
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
			checkForLiters()
			
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

		
		//concatenate minutes, seconds and milliseconds as assign it to the UILabel
		displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
		gallonsUsedLabel.text = "\(strGallonsUsed)"
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewWillAppear(animated: Bool) {
		checkForLiters()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showSaveModal" {
			if let destinationVC = segue.destinationViewController as? SaveModalViewController {
				destinationVC.waterUsed = gallonsUsedLabel.text!
				destinationVC.timeTaken = displayTimeLabel.text!
							}
		}
	}
	

	func checkForLiters () {
		usingLiters = defaults.boolForKey("useLiters")
		if usingLiters {
			gallonsUsedStaticLabel.text = "Liters used:"
		} else {
			gallonsUsedStaticLabel.text = "Gallons used:"
		}

	}

}
