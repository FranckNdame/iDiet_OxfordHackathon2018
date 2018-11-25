//
//  IntakeCell.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

class IntakeCell: UICollectionViewCell {
    
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodPreview: UIImageView!
    @IBOutlet weak var foodCalories: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var sugarsLabel: UILabel!
}

let intakeImage = [#imageLiteral(resourceName: "rice"),#imageLiteral(resourceName: "burger"),#imageLiteral(resourceName: "watermelon1"),#imageLiteral(resourceName: "pizza1"),#imageLiteral(resourceName: "coconut"),#imageLiteral(resourceName: "pasta"),#imageLiteral(resourceName: "chicken")]
let intakeLabel = ["Rice", "Burger","Watermelon","Pizza","Coconut","Spagetti Bolognaise","Chicken"]
let intakeCalories = ["87KJ","300KJ","70KJ","280KJ","20KJ","45KJ","78KJ"]
