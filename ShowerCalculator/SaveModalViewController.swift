//
//  SaveModalViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/27/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit
import CoreData

class SaveModalViewController: UIViewController {
	@IBOutlet weak var timeTakenLabel: UILabel!
	@IBOutlet weak var waterUsedLabel: UILabel!
	@IBOutlet weak var dateAndTimeLabel: UILabel!
	@IBOutlet weak var waterUnitLabel: UILabel!
	@IBOutlet weak var popUpView: UIView!
	
	let defaults = NSUserDefaults.standardUserDefaults()
	var savedShowersArray = [NSManagedObject]()
	
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
		let waterUsedAsDouble = Double(waterUsed)
		self.saveShower(waterUsedAsDouble!)
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func saveShower(waterUsed: Double) {
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
		let managedContext = appDelegate.managedObjectContext
		
		let entity = NSEntityDescription.entityForName("SavedShower", inManagedObjectContext: managedContext)
		
		let saveShower = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
		
		saveShower.setValue(waterUsed, forKey: "waterUsed")
		
		do {
			try managedContext.save()
			
			savedShowersArray.append(saveShower)
		} catch let error as NSError {
			print("Could not save \(error), \(error.userInfo)")
		}
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