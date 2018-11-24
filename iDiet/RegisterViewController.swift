//
//  RegisterViewController.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Skeleton
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name"
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        return tf
    }()
    
    let RegisterButton: UIButton = {
        let rb = UIButton()
        rb.setTitle("Register", for: .normal)
        rb.backgroundColor = .green
        rb.layer.cornerRadius = 10
        return rb
    }()
    
    let LoginButton: UIButton = {
        let rb = UIButton()
        rb.setTitle("Already Registered?", for: .normal)
        rb.backgroundColor = .green
        rb.layer.cornerRadius = 10
        return rb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(nameTextField)
        nameTextField.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        nameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(emailTextField)
        emailTextField.anchor(top: nameTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(RegisterButton)
        RegisterButton.anchor(top: passwordTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        RegisterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(LoginButton)
        LoginButton.anchor(top: LoginButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        LoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
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
