//
//  ProfileViewController.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase
import MKRingProgressView
import Kingfisher

class ProfileViewController: UIViewController {
    
    var settingsLauncher = SettingsPopup()
    var ref: DatabaseReference!
    var refCurrent: DatabaseReference!
    var current = ""
    var fat = ""
    var sugar = ""
    
    var logginIn = true
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var navigationUsernameLabel: UILabel!
    @IBOutlet weak var navigationAvatarView: UIView!
    
    // User stats
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    // Circular View
    @IBOutlet weak var caloriesView: RingProgressView!
    @IBOutlet weak var proteinsView: RingProgressView!
    @IBOutlet weak var carbsView: RingProgressView!
    @IBOutlet weak var fatsView: RingProgressView!
    
    //User Image
    @IBOutlet weak var mainUserImageView: UIImageView!
    @IBOutlet weak var roundedUserImageView: UIImageView!
    
    
//    guard let url = URL(string: loggedUser.profileImageUrl!) else {return}
//    let resource = ImageResource(downloadURL: url, cacheKey: loggedUser.uid)
//    self.userProfileImage.kf.setImage(with: resource)
//    let name = NSNotification.Name(rawValue: "UpdateProfile")
//    NotificationCenter.default.post(name: name, object: nil)
    
    
    
    
    // MARK: - ATTRIBUTES
    var controllerColor: UIColor = UIColor(red: 0.23, green: 0.66, blue: 0.96, alpha: 1.0)
    
    // MARK: - CLASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.masksToBounds = true
        navigationUsernameLabel.alpha = 0
        navigationAvatarView.alpha = 0
        guard let user = Auth.auth().currentUser else {return}
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let user = Auth.auth().currentUser else {return}
        if logginIn == true {
        ObserveStats()
        logginIn = false
        }
        
        caloriesView.progress = 0
        proteinsView.progress = 0
        carbsView.progress = 0
        fatsView.progress = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        caloriesView.progress = 0.5
        proteinsView.progress = 0.2
        carbsView.progress = 0.4
        fatsView.progress = 0.1
    }
    

    
    func ObserveStats() {
        guard let user = Auth.auth().currentUser else {return}
        
        Database.fetchCurrentuser(uid: user.uid) { (user) in
            guard let weight = user.weight, let height = user.height, let target = user.target else {return}
            self.calorieLabel.text = "\(self.current)/\(target)cal"
            self.navigationUsernameLabel.text = user.name
            self.usernameLabel.text = user.name
            self.weightLabel.text = "\(weight)kg"
            self.heightLabel.text = "\(height)cm"
            
            let bmiValue = bmi(weight: weight, height: height)
            self.bmiLabel.text = "\(bmiValue)"
            if bmiValue >= 30 {
                self.statusLabel.text = "Obese"
            } else if bmiValue >= 25 && bmiValue <= 29.9  {
                self.statusLabel.text = "Overweight"
            } else if bmiValue >= 18.5 && bmiValue <= 24.9 {
                self.statusLabel.text = "Normal weight"
            } else if bmiValue < 18.5 {
                self.statusLabel.text = "Underweight"
            }
            
            self.ObserveCurrent(target: target)
            
                guard let url = URL(string: user.image!) else {return}
                let resource = ImageResource(downloadURL: url, cacheKey: user.uid)
                self.mainUserImageView.kf.setImage(with: resource)
                self.roundedUserImageView.kf.setImage(with: resource)

        }
    }
    
    func ObserveCurrent(target: String) {
        guard let userID = Auth.auth().currentUser else {return}
        refCurrent = Database.database().reference().child("Status").child(userID.uid)
        refCurrent.observe(.value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            self.current = value?["Current"] as! String
            self.fat = value?["Fat"] as! String
            self.sugar = value?["Sugar"] as! String
            self.calorieLabel.text = "\(self.current)/\(target)cal"
            self.caloriesView.progress = Double(self.current)!/Double(target)!
            self.proteinsView.progress = Double(self.sugar)!/Double(target)!
            self.fatsView.progress = Double(self.fat)!/Double(target)!
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
    @IBAction func handleSettings(_ sender: UIButton) {
        settingsLauncher.showMenu()
    }
}

// MARK: - ColoredView
extension ProfileViewController: ColoredView {}

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y/150
        
//        print(1 - yOffset)
        if 1 - yOffset >= 0 && 1 - yOffset < 1 {
            avatarView.alpha = 1 - yOffset - 0.2
            usernameLabel.alpha = 1 - yOffset - 0.2
            navigationUsernameLabel.alpha = yOffset - 0.2
            navigationAvatarView.alpha = yOffset - 0.2
        } else if 1 - yOffset >= 1  {
            avatarView.alpha = 1
            usernameLabel.alpha = 1
            navigationUsernameLabel.alpha = 0
            navigationAvatarView.alpha = 0
        } else {
            avatarView.alpha = 0
            usernameLabel.alpha = 0
            navigationUsernameLabel.alpha = 1
            navigationAvatarView.alpha = 1
        }
    }
}
