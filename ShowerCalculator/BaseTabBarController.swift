//
//  BaseTabBarController.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/27/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
	@IBInspectable var defaultIndex: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		selectedIndex = defaultIndex
	}
}