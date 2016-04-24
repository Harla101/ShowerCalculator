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
	
	@IBOutlet weak var unitInputTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		unitInputTextField.becomeFirstResponder()
		
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

	
	@IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
		unitInputTextField.resignFirstResponder()
		dismissViewControllerAnimated(true, completion: nil)

	}
	
	@IBAction func doneButtonTapped(sender: UIBarButtonItem) {
		unitInputTextField.resignFirstResponder()
		
		dismissViewControllerAnimated(true, completion: nil)

	}
}
