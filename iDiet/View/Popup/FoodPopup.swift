//
//  FoodPopup.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 25/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

class FoodPopUp: NSObject {
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        view.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissView))
        view.addGestureRecognizer(tapGesture)
        
        return view
        
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
//        print(delegate)
//        delegate?.shouldAddFood()
    }
    
    
    
    override init() {
        super.init()
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
