//
//  ViewController.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isLoggedIn == false {
        isLoggedIn = true
        let LoginView = LoginViewController()
        present(LoginView, animated: true, completion: nil)
        }
    }


}

