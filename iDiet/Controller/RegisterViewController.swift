//
//  RegisterViewController.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - References
    var ref: DatabaseReference!
    var refCurrent: DatabaseReference!
    var refAllergy: DatabaseReference!
    var uid = ""
    
    // MARK: - Skeleton
    var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.contentSize.height = 2000
        sv.isScrollEnabled = true
        sv.backgroundColor = .clear
        return sv
    }()
    
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "user")
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let chooseImage : UIButton = {
       let cv = UIButton()
        cv.backgroundColor = .clear
        cv.addTarget(self, action: #selector(handleSelectProfileImageView), for: .touchUpInside)
        return cv
    }()
    
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
    
    let heightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Height"
        return tf
    }()
    
    let weightTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Weight"
        return tf
    }()
    
    let CalorieTargerTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Maximum Calorie Target"
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
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, bottom: self.view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        scrollView.addSubview(imageView)
        scrollView.anchor(top: scrollView.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 64, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 80, height: 80)
        scrollView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(chooseImage)
        chooseImage.anchor(top: scrollView.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 80, height: 80)
        chooseImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(nameTextField)
        nameTextField.anchor(top: imageView.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        nameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(emailTextField)
        emailTextField.anchor(top: nameTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(heightTextField)
        heightTextField.anchor(top: passwordTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        heightTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(weightTextField)
        weightTextField.anchor(top: heightTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        weightTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(CalorieTargerTextField)
        CalorieTargerTextField.anchor(top: weightTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        CalorieTargerTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(RegisterButton)
        RegisterButton.anchor(top: CalorieTargerTextField.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        RegisterButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        scrollView.addSubview(LoginButton)
        LoginButton.anchor(top: RegisterButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 32, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        LoginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        
        //creating flexible space
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // creating button
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        
        // adding space and button to toolbar
        keyboardToolbar.setItems([flexibleSpace,addButton], animated: false)
        nameTextField.inputAccessoryView = keyboardToolbar
        emailTextField.inputAccessoryView = keyboardToolbar
        passwordTextField.inputAccessoryView = keyboardToolbar
        heightTextField.inputAccessoryView = keyboardToolbar
        weightTextField.inputAccessoryView = keyboardToolbar
        CalorieTargerTextField.inputAccessoryView = keyboardToolbar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        available = false
    }
    
    // MARK: - Functions
    @objc func login() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func register() {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if error == nil {
                guard let user = authResult?.user else { return }
                
                let storageRef = Storage.storage().reference().child("users").child("\(user.uid).png")
                if let uploadData = self.imageView.image!.pngData() {
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            return
                        }
                        
                        storageRef.downloadURL(completion: { (url, err) in
                            if let err = err {
                                return
                            }
                            
                            guard let profileImageUrl = url?.absoluteString else {return}
                            
                            self.uid = user.uid
                            self.ref = Database.database().reference().child("Users").child(self.uid)
                            self.ref.setValue(["Name": self.nameTextField.text!, "Email": self.emailTextField.text!, "Password": self.passwordTextField.text!, "Height": self.heightTextField.text!, "Weight": self.weightTextField.text!, "Target": self.CalorieTargerTextField.text!, "Image": profileImageUrl])
                            
                            self.refCurrent = Database.database().reference().child("Status").child(self.uid)
                            self.refCurrent.setValue(["Current": "0", "Sugar": "0", "Fat": "0"])
                            
                            self.refAllergy  = Database.database().reference().child("Allergy").child(self.uid)
                            self.refAllergy.setValue(["Allergy": "null"])
                        })
                        
                        
                
                    })
                }
            
            

                print("You have successfully registered!!")
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            imageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
