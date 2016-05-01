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
	
	var savedShowers = [NSManagedObject]()
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.tableView.reloadData()
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
	
	override func viewWillAppear(animated: Bool) {
		
		super.viewWillAppear(animated)
		
		self.tableView.reloadData()
		
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
		let dateLabelText = String(savedShowerCell.valueForKey("showerDate") as! String)
			cell.dateLabel.text = dateLabelText
		let showerLengthText = String(savedShowerCell.valueForKey("showerTimeLength") as! String)
			cell.showerLengthLabel.text = showerLengthText
			
		return cell
		}
	}
}