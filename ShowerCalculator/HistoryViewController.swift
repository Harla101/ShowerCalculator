//
//  HistoryViewController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/28/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	var savedShowers = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
//		title = "\"Your Shower Stats\""
//		tableView.registerClass(UITableViewCell, forCellReuseIdentifier: "Cell")
		

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
