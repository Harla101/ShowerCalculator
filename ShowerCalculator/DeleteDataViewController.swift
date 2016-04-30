//
//  DeleteDataViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/30/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit
import CoreData

class DeleteDataViewController: UIViewController {
	@IBOutlet weak var clearDataButton: UIButton!
	@IBOutlet weak var confirmButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


	@IBAction func cancelButtonTapped(sender: UIButton) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	@IBAction func clearDataTapped(sender: UIButton) {
		clearDataButton.enabled = false
		clearDataButton.hidden = true
		
		confirmButton.enabled = true
		confirmButton.hidden = false
		
		
	}

	@IBAction func confirmedButtonTapped(sender: UIButton) {
		dismissViewControllerAnimated(true, completion: nil)
		deleteIncidents()
	}
	
//	func deleteAllData(entity: String)
//	{
//		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//		let managedContext = appDelegate.managedObjectContext
//		let fetchRequest = NSFetchRequest(entityName: entity)
//		fetchRequest.returnsObjectsAsFaults = false
//		
//		do
//		{
//			let results = try managedContext.executeFetchRequest(fetchRequest)
//			for managedObject in results
//			{
//				let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
//				managedContext.deleteObject(managedObjectData)
//			}
//		} catch let error as NSError {
//			print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
//		}
//	}
	
	func deleteIncidents() {
		let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
		let context = appDel.managedObjectContext
		let coord = appDel.persistentStoreCoordinator
		
		let fetchRequest = NSFetchRequest(entityName: "SavedShower")
		let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
		
		do {
			try coord.executeRequest(deleteRequest, withContext: context)
		} catch let error as NSError {
			debugPrint(error)
		}
	}
}
