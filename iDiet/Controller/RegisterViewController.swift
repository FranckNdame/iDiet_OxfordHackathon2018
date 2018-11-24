//
//  RegisterViewController.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // MARK: - References
    var ref: DatabaseReference!
    
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
        rb.addTarget(self, action: #selector(register), for: .touchUpInside)
        return rb
    }()
    
    let LoginButton: UIButton = {
        let rb = UIButton()
        rb.setTitle("Already Registered?", for: .normal)
        rb.backgroundColor = .green
        rb.layer.cornerRadius = 10
        rb.addTarget(self, action: #selector(login), for: .touchUpInside)
        return rb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("Users").child(userID)
        
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
        LoginButton.anchor(top: RegisterButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        LoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: - Functions
    @objc func login() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func register() {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if error == nil {
                self.ref.setValue(["Name": self.nameTextField.text!, "Email": self.emailTextField.text!, "Password": self.passwordTextField.text!])
                print("You have successfully registered!!")
                guard let user = authResult?.user else { return }
                print(user.uid)
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }

        }
        
    }

}
