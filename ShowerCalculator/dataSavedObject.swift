//
//  dataSavedObject.swift
//  ShowerCalculator
//
//  Created by Steve Harlan on 4/28/16.
//  Copyright © 2016 Steve Harlan. All rights reserved.
//

import Foundation

class DataSaved: NSObject {
	let showerTime: String
	let waterUsed: Double
	let usingLiters: Bool
	let timeTaken: String
	
	 init(showerTime: String, waterUsed: Double, usingLiters: Bool, timeTaken: String) {
		self.showerTime = showerTime
		self.waterUsed = waterUsed
		self.usingLiters = usingLiters
		self.timeTaken = timeTaken
	}

}