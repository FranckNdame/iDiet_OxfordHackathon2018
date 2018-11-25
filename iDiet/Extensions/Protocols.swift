//
//  Protocols.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

protocol CaptureDelegate {
    func shouldAbortCapture()
    func shouldRestartCapture()
}

//protocol DueceCaptureDelegate {
//    func mshouldAbortCapture()
//    func mshouldRestartCapture()
//}

protocol LensDelegate {
    func foodItem(title: String, calories: String, fat: String, sugar: String)
}

protocol FoodPopupDelegate {
    func shouldAddFood()
    func shouldCancelFood()
}
