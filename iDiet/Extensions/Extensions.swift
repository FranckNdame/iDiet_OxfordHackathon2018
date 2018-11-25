//
//  Extensions.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase


func bmi(weight: String, height:String) -> Double {
    let heightstart = Int(height) ?? 0
    let heightMeters = Double(heightstart) / 100
    let heightsquared = Double(heightMeters) * Double(heightMeters)
    let weightstart = Int(weight) ?? 0
    let bmi = Double(weightstart)/heightsquared
    return Double(round(100*bmi)/100)
}
