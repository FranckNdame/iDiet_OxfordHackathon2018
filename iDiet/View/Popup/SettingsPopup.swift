//
//  SettingsPopup.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/25/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

class SettingsPopup: NSObject {
    
    var selected = "banana"
    var refAllery: DatabaseReference!
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissView))
        view.addGestureRecognizer(tapGesture)
        
        return view
        
    }()
    
    let titleLabel: UILabel = {
       let tl = UILabel()
        tl.textColor = UIColor.darkGray
        tl.text = "Settings"
        tl.textAlignment = .center
        tl.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return tl
    }()
    
    let separaterView : UIView = {
       let sv = UIView()
        sv.backgroundColor = .black
        return sv
    }()
    
    let subLabel: UILabel = {
        let tl = UILabel()
        tl.textColor = UIColor.darkGray
        tl.text = "Allergies"
        tl.textAlignment = .left
        tl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return tl
    }()
    
    let pickerView: UIPickerView = {
       let pv = UIPickerView()
        return pv
    }()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 25
        return cv
    }()
    
    lazy var addButton : UIButton = {
        let cb = UIButton(type: .system)
        cb.setTitle("Add", for: .normal)
        cb.tintColor = .white
        cb.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        cb.layer.cornerRadius = 30
        cb.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return cb
    }()
    //    var delegate: FoodPopupDelegate?
    
    @objc func handleAdd() {
        guard let userID = Auth.auth().currentUser else {return}
        self.refAllery = Database.database().reference().child("Allergy").child(userID.uid)
        self.refAllery.setValue(["Allergy": "\(selected)"])
        self.handleDismissView()
    }
    
    
    
    override init() {
        super.init()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    
    func showMenu() {
        //show menu
        guard let window = UIApplication.shared.keyWindow else {return}
        
        window.addSubview(blackView)
        window.addSubview(containerView)
        blackView.frame = window.frame
        let width: CGFloat = window.frame.width
        let y = window.frame.height - 600
        
        containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 500)
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.containerView.frame = CGRect(x: 0, y: y, width: width, height: 600)
        }, completion: nil)
        
        containerView.addSubview(addButton)
        addButton.anchor(top: nil, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: containerView.safeAreaLayoutGuide.bottomAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16, paddingBottom: 16, width: 0, height: 60)
        
        
        containerView.addSubview(titleLabel)
        titleLabel.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: nil, paddingTop: 16, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        containerView.addSubview(separaterView)
        separaterView.anchor(top: titleLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: nil, paddingTop: 64, paddingLeft: 16, paddingRight: 16, paddingBottom: 0, width: 0, height: 1)
        
        containerView.addSubview(subLabel)
        subLabel.anchor(top: separaterView.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: nil, paddingTop: 16, paddingLeft: 16, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        containerView.addSubview(pickerView)
        pickerView.anchor(top: subLabel.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 300)
        
    }
    
    @objc func handleDismissView() {
        dismissView()
    }
    
    fileprivate func dismissView() {
        guard let window = UIApplication.shared.keyWindow else {return}
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            self.containerView.frame = CGRect(x: 0, y: window.frame.height+1, width: window.frame.width, height: 400)
        }, completion: { (_) in
            self.blackView.removeFromSuperview()
        })
    }
    
}

extension SettingsPopup: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FoodName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return FoodName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = FoodName[row]
        print(selected)
    }
    
}
