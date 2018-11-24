//
//  LoginViewController.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Skeleton
    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email Address"
        return tf
    }()
    
    let emailLine: UIView = {
       let el = UIView()
        el.backgroundColor = UIColor.darkGray
        return el
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        return tf
    }()
    
    let passwordLine: UIView = {
        let pl = UIView()
        pl.backgroundColor = UIColor.darkGray
        return pl
    }()
    
    let loginButton: UIButton = {
       let lb = UIButton()
        lb.setTitle("Login", for: .normal)
        lb.backgroundColor = .green
        lb.layer.cornerRadius = 10
        return lb
    }()
    
    let RegisterButton: UIButton = {
        let rb = UIButton()
        rb.setTitle("Register", for: .normal)
        rb.backgroundColor = .green
        rb.layer.cornerRadius = 10
        return rb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
