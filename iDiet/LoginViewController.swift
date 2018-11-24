//
//  LoginViewController.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

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
        lb.addTarget(self, action: #selector(login), for: .touchUpInside)
        return lb
    }()
    
    let RegisterButton: UIButton = {
        let rb = UIButton()
        rb.setTitle("Register", for: .normal)
        rb.backgroundColor = .green
        rb.layer.cornerRadius = 10
        rb.addTarget(self, action: #selector(register), for: .touchUpInside)
        return rb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(emailTextField)
        emailTextField.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(emailLine)
        emailLine.anchor(top: emailTextField.bottomAnchor, left: emailTextField.leftAnchor, right: emailTextField.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 1)
        
        self.view.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailLine.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(passwordLine)
        passwordLine.anchor(top: passwordTextField.bottomAnchor, left: passwordTextField.leftAnchor, right: passwordTextField.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 1)
        
        self.view.addSubview(loginButton)
        loginButton.anchor(top: passwordLine.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 64, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 80)
        loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(RegisterButton)
        RegisterButton.anchor(top: loginButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 16, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 80)
        RegisterButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    // MARK: - Functions
    @objc func login() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Incorrect Username or Password!!", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func register() {
        let RegisterView = RegisterViewController()
        present(RegisterView, animated: true, completion: nil)
    }
}
