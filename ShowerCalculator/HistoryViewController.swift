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
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
		if savedShowers.isEmpty {
			cell!.textLabel!.text = "You have not saved any shower times"
			return cell!
		} else {
		let savedShowerCell = savedShowers[indexPath.row]
		let waterLabelText = String(savedShowerCell.valueForKey("waterUsed") as! Double)
		cell!.textLabel!.text = waterLabelText
		return cell!
		}
	}

}
