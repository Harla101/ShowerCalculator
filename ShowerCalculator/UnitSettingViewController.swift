//
//  UnitSettingViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/24/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit

class UnitSettingViewController: UIViewController {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var measurementSwitch: UISwitch!
	@IBOutlet weak var doneButton: UIBarButtonItem!
	@IBOutlet weak var unitInputTextField: UITextField!
	@IBOutlet weak var invalidInputLabel: UILabel!
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		unitInputTextField.text = String(defaults.doubleForKey("waterPerMinute"))
		measurementSwitch.on = defaults.boolForKey("useLiters")
		useLiters()
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	
	
	@IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
		unitInputTextField.resignFirstResponder()
		dismissViewControllerAnimated(true, completion: nil)
		
	}
	
	@IBAction func doneButtonTapped(sender: UIBarButtonItem) {
		let waterPerMinute = Double(unitInputTextField.text!)
		defaults.setDouble(waterPerMinute!, forKey: "waterPerMinute")
		unitInputTextField.resignFirstResponder()
		dismissViewControllerAnimated(true, completion: nil)
	}
	@IBAction func unitInputTextFieldChanged(sender: UITextField) {
		if Double(unitInputTextField.text!) == nil || Double(unitInputTextField.text!) <= 0 {
			doneButton.enabled = false
			invalidInputLabel.hidden = false
		} else {
			doneButton.enabled = true
			invalidInputLabel.hidden = true
		}
	}
	
	@IBAction func unitSwitchTapped(sender: UISwitch) {
		useLiters()
	}
	
	func useLiters () {
		if measurementSwitch.on {
			titleLabel.text = "Liters Per Minute"
			defaults.setBool(true, forKey: "useLiters")
			
		} else {
			titleLabel.text = "Gallons Per Minute"
			defaults.setBool(false, forKey: "useLiters")
		}
		
	}
}
