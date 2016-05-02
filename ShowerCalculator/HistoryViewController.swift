//
//  HistoryViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/28/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var totalWaterLabel: UILabel!
	@IBOutlet weak var averageWaterLabel: UILabel!
	
	var savedShowers = [NSManagedObject]()
	var waterUsedArray = [Double]()
	var waterMeasureUnit = ""
	var waterTotal = 0.0
	
	let defaults = NSUserDefaults.standardUserDefaults()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
	
	override func viewWillAppear(animated: Bool) {
		updateTable()
		super.viewWillAppear(animated)
		checkForLiter()

		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		let managedContext = appDelegate.managedObjectContext
		let fetchRequest = NSFetchRequest(entityName: "SavedShower")
		do {
			let results =
				try managedContext.executeFetchRequest(fetchRequest)
			savedShowers = results as! [NSManagedObject]
		} catch let error as NSError {
			print("Could not fetch \(error), \(error.userInfo)")
		}
		
		for item in waterUsedArray {
			print(item)
		}
		waterUsedArray.removeAll()
		waterCalculations()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if savedShowers.isEmpty {
			return 1
		} else {
			return savedShowers.count
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("historyCell") as! HistoryTableViewCell
		if savedShowers.isEmpty {
			cell.dateLabel.hidden = true
			cell.showerLengthLabel.hidden = true
			cell.waterUsedLabel.hidden = true
			cell.noDataLabel.hidden = false
			return cell
		} else {
			let savedShowerCell = savedShowers[indexPath.row]
			cell.noDataLabel.hidden = true
			cell.dateLabel.hidden = false
			cell.showerLengthLabel.hidden = false
			cell.waterUsedLabel.hidden = false
			let waterLabelText = String(savedShowerCell.valueForKey("waterUsed") as! Double)
			cell.waterUsedLabel.text = waterLabelText
			
			let waterDoubleValue = savedShowerCell.valueForKey("waterUsed") as! Double
			waterUsedArray.append(waterDoubleValue)
			
			
			let dateLabelText = String(savedShowerCell.valueForKey("showerDate") as! String)
			cell.dateLabel.text = dateLabelText
			let showerLengthText = String(savedShowerCell.valueForKey("showerTimeLength") as! String)
			cell.showerLengthLabel.text = showerLengthText
			return cell
		}
	}

	func checkForLiter() {
		if defaults.boolForKey("useLiters") {
			waterMeasureUnit = "Liters"
		} else {
			waterMeasureUnit = "Gallons"
		}
	}
	
	func waterCalculations() {
		for i in 0  ..< savedShowers.count  {
			print(savedShowers[i].valueForKey("waterUsed") as! Double)
			let waterToAddToArray = savedShowers[i].valueForKey("waterUsed") as! Double
			waterUsedArray.append(waterToAddToArray)
		}
		
		if savedShowers.isEmpty {
			totalWaterLabel.text = "0.00 \(waterMeasureUnit)"
			averageWaterLabel.text = "0.00 \(waterMeasureUnit)"
			waterUsedArray.removeAll()

		} else {
			waterTotal = sumWaterUsedArray(waterUsedArray)
			totalWaterLabel.text = "\(String(waterTotal)) \(waterMeasureUnit)"
			let averageWater = waterTotal / Double(savedShowers.count)
			let averageWaterStr = String(format: "%.2f", averageWater)
			averageWaterLabel.text = "\(averageWaterStr) \(waterMeasureUnit)"
		}
	}
	
	func sumWaterUsedArray (arrayToSum: [Double]) -> Double {
		let answer = arrayToSum.reduce(0, combine: +)
		return answer
	}
	func updateTable () {
		dispatch_async(dispatch_get_main_queue()) {
			self.tableView.reloadData()
		}
	}
}
