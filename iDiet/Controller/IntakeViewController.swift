//
//  IntakeViewController.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase


var foodcalorie = [String]()
var foodFat = [String]()
var foodName = [String]()
var foodSugar = [String]()

class IntakeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var controllerColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)

    
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.cornerRadius = 0
        backgroundView.layer.masksToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchHistory()
    }
}

// MARK: - ColoredView
extension IntakeViewController: ColoredView {}


extension IntakeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    fileprivate func fetchHistory() {
        guard let user = Auth.auth().currentUser else {return}
        Database.database().reference().child("History").child(user.uid).observe(.childAdded, with: { (snapshot) in
            
            guard let values = snapshot.value as? [String:Any] else {return}
            
            foodName.append(values["Name"] as? String ?? "")
            foodFat.append(values["Fat"] as? String ?? "")
            foodcalorie.append(values["Calories"] as? String ?? "")
            foodSugar.append(values["Sugar"] as? String ?? "")

            self.collectionView.reloadData()
            
        }) { (err) in
            print("Failed to fetch history")
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "intakeCell", for: indexPath) as! IntakeCell
//        cell.foodLabel.text = intakeLabel[indexPath.row]
//        cell.foodCalories.text = intakeCalories[indexPath.row]
//        cell.foodPreview.image = intakeImage[indexPath.row]
        
        cell.foodLabel.text = foodName[indexPath.row]
        cell.foodCalories.text = foodcalorie[indexPath.row]
        cell.foodPreview.image = UIImage(named: foodName[indexPath.row])
        cell.fatsLabel.text = foodFat[indexPath.row]
        cell.sugarsLabel.text = foodSugar[indexPath.row]
        return cell
    }
    
    
}


extension IntakeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "intakeHeader", for: indexPath) as! IntakeCollectionViewHeaderCell
        header.backgroundColor = .white
        return header
    }
}
