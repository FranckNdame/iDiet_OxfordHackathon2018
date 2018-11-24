//
//  ProfileViewController.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    var ref: DatabaseReference!
    var height = ""
    var weight = ""
    var target = ""
    var bmi = 0.0
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var navigationUsernameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
    
    
    // MARK: - ATTRIBUTES
    var controllerColor: UIColor = UIColor(red: 0.23, green: 0.66, blue: 0.96, alpha: 1.0)
    
    // MARK: - CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        backgroundView.layer.cornerRadius = 0
        backgroundView.layer.masksToBounds = true
        navigationUsernameLabel.alpha = 0
        guard let user = Auth.auth().currentUser else {return}
        ref = Database.database().reference().child("Users").child(user.uid)
        ObserveStats()
    }
    
    func ObserveStats() {
        ref.observe(.value, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            self.height = value?["Height"] as! String
            self.weight = value?["Weight"] as! String
            self.target = value?["Target"] as! String
            self.weightLabel.text = "\(self.weight)kg"
            self.heightLabel.text = "\(self.height)cm"
            let heightstart = Int(self.height) ?? 0
            print(heightstart)
            let heightMeters = Double(heightstart) / 100
            print(heightMeters)
            let heightsquared = Double(heightMeters) * Double(heightMeters)
            print(heightsquared)
            let weightstart = Int(self.weight) ?? 0
            print(weightstart)
            self.bmi = Double(weightstart)/heightsquared
            self.bmiLabel.text = "\(self.bmi)"
        })
    }
    
    
    //MARK: - IBACTIONS
    @IBAction func handleLogoutButton(_ sender: UIButton) {
        try! Auth.auth().signOut()
        if Auth.auth().currentUser != nil {
            print("UserId: \(Auth.auth().currentUser?.uid ?? "User Not Found!")")
        } else {
            let LoginView = LoginViewController()
            present(LoginView, animated: true, completion: nil)
        }
    }
}

// MARK: - ColoredView
extension ProfileViewController: ColoredView {}

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y/150
        
//        print(1 - yOffset)
        if yOffset >= 0 && yOffset <= 1 {
            avatarView.alpha = 1 - yOffset - 0.2
            usernameLabel.alpha = 1 - yOffset - 0.2
            navigationUsernameLabel.alpha = yOffset - 0.2
        } else if 1 - yOffset >= 0.9  {
            avatarView.alpha = 1
            usernameLabel.alpha = 1
            navigationUsernameLabel.alpha = 0
        } else {
            avatarView.alpha = 0
            usernameLabel.alpha = 0
            navigationUsernameLabel.alpha = 1
        }
    }
}
