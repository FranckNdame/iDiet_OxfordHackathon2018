//
//  MainViewController.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

protocol ColoredView {
    var controllerColor: UIColor { get set }
}
var mainViewRef: MainViewController?

class MainViewController: UIViewController {
    
    
    // MARK: - Properties
    var scrollViewController: ScrollViewController!
    
    lazy var profileViewController: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
    }()
    
    lazy var intakesViewController: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "IntakeViewController")
    }()
    
    lazy var lensViewController: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "LensViewController")
    }()
    
    var delegate: CaptureDelegate?
    var scanViewController: ScanViewController!
    
    // MARK: - IBOutlets
    @IBOutlet var navigationView: NavigationView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ScanViewController {
            scanViewController = controller
        } else if let controller = segue.destination as? ScrollViewController {
            scrollViewController = controller
            scrollViewController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewRef = self
        print(mainViewRef)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            available = false
            print("UserId: \(Auth.auth().currentUser?.uid ?? "User Not Found!")")
        } else {
            let LoginView = LoginViewController()
            present(LoginView, animated: true, completion: nil)
            available = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mainViewRef = self
    }
}


// MARK: - IBActions
extension MainViewController {
    @IBAction func handleChatIconTap(_ sender: UITapGestureRecognizer) {
        print("red")
        scrollViewController.setController(to: profileViewController, animated: true)
        
    }
    
    @IBAction func handleDiscoverIconTap(_ sender: UITapGestureRecognizer) {
        print("green")
        print(intakesViewController)
        scrollViewController.setController(to: intakesViewController, animated: true)
    }
    
    @IBAction func handleCameraButton(_ sender: UITapGestureRecognizer) {
        scrollViewController.setController(to: lensViewController, animated: true)
    }

}

extension MainViewController: ScrollViewControllerDelegate {
    func scrollViewDidScroll() {
        let min: CGFloat = 0
        // 375
        let max: CGFloat = scrollViewController.pageSize.width
        let x = scrollViewController.scrollView.contentOffset.x
        // Subtract 1 to make the value range from -1 to +1
        let result = ((x - min) / (max - min)) - 1
        
        var controller: UIViewController?
        
        if scrollViewController.isControllerVisible(profileViewController){
            controller = profileViewController
        } else if scrollViewController.isControllerVisible(intakesViewController) {
            controller = intakesViewController
            
        }
        navigationView.animate(to: controller, percent: result)
        
        switch result {
        case -1:
            print("should stop processing")
            print(delegate)
            delegate?.shouldAbortCapture()
        case 1:
            print("should stop processing")
            delegate?.shouldAbortCapture()
        default:
            delegate?.shouldRestartCapture()
        }
    }
    
  
    
    
    
    var viewControllers: [UIViewController?] {
        return [profileViewController,lensViewController,intakesViewController]
    }
    
    var initialViewController: UIViewController {
        return lensViewController
    }
    
}
