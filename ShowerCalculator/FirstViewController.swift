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
	
	var startTime = NSTimeInterval()
	
	var timer:NSTimer = NSTimer()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		displayTimeLabel.text = "00:00:00"
	}
	
	@IBAction func startStopButtonPressed(sender: UIButton) {
		if !timer.valid {
		timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(FirstViewController.updateTime), userInfo: nil, repeats: true)
		startTime = NSDate.timeIntervalSinceReferenceDate()
		startStopButton.setTitle("Stop", forState: .Normal)
		} else {
			timer.invalidate()
			startStopButton.setTitle("Start", forState: .Normal)
			
		}
	}
	
	@IBAction func resetButtonPressed(sender: AnyObject) {
			timer.invalidate()
			displayTimeLabel.text = "00:00:00"
			startStopButton.setTitle("Start", forState: .Normal)
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
		
		//concatenate minuets, seconds and milliseconds as assign it to the UILabel
		displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
	}
	
	func updateGallons() {
		let gallonsPerMinute = 2.1
		
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
