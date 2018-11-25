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
    
    let collectionView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 25
        return cv
    }()
    
    
    override init() {
        super.init()
    }
    
    
    func showMenu() {
        //show menu
        guard let window = UIApplication.shared.keyWindow else {return}
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        blackView.frame = window.frame
        let width: CGFloat = window.frame.width
        let y = window.frame.height - 300
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 300)
        
        UIView.animate(withDuration: 0.65, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: y, width: width, height: 400)
        }, completion: nil)
        
        
    }
    
    @objc func handleDismissView() {
        dismissView()
    }
    
    fileprivate func dismissView() {
        guard let window = UIApplication.shared.keyWindow else {return}
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height+1, width: window.frame.width, height: 400)
        }, completion: { (_) in
            self.blackView.removeFromSuperview()
        })
    }
    
}
