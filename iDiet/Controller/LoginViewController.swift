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
    

    
    @objc func register() {
        let RegisterView = RegisterViewController()
        present(RegisterView, animated: true, completion: nil)
    }
    
    let logoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3125020266, green: 0.7018565536, blue: 0.9637499452, alpha: 1)
        
        let title = UILabel()
        title.text = "iDiet"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 40, weight: .black)
        view.addSubview(title)
        title.anchor(top: nil, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
//
//
        return view
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue:237/255, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    let logo: UIImageView = {
        let view = UIImageView()
//        view.image = #imageLiteral(resourceName: "camera-shutter-gray").withRenderingMode(.alwaysOriginal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
        
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        view.addSubview(logoContainerView)
        setupContainerView()
        setupLoginForm()
        setupFooter()
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        //creating flexible space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // creating button
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        
        // adding space and button to toolbar
        keyboardToolbar.setItems([flexibleSpace,addButton], animated: false)
        emailTextField.inputAccessoryView = keyboardToolbar
        

        
        // adding toolbar to input accessory view
        passwordTextField.inputAccessoryView = keyboardToolbar

        
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        available = false
    }
    
    fileprivate func setupContainerView() {
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 150)
    }
    
    fileprivate func  setupLoginForm() {
        let stackview = UIStackView(arrangedSubviews: [emailTextField,passwordTextField, loginButton])
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        
        view.addSubview(stackview)
        stackview.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 48, paddingLeft: 32, paddingRight: 32, paddingBottom: 0, width: 0, height: 150)
    }
    
    @objc func handleShowSignUp () {
        let RegisterView = RegisterViewController()
        present(RegisterView, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleTextInputChange() {
        let emailIsValid = emailTextField.text?.count ?? 0 > 4
        let passwordIsValid = passwordTextField.text?.count ?? 0 > 5
        
        if emailIsValid && passwordIsValid {
            loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue:237/255, alpha: 1)
            loginButton.isEnabled = true
            
        } else {
            loginButton.backgroundColor = UIColor(red: 149/255, green:204/255, blue:244/255, alpha: 1)
            loginButton.isEnabled = false
        }
    }
    
    @objc func handleLogin() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil {
                available = true
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Incorrect Username or Password!!", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func setupFooter() {
        view.addSubview(signupButton)
        signupButton.anchor(top: nil, left: view.leftAnchor, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 2, width: 0, height: 0)
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
