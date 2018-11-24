//
//  CaptureViewController.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import AVKit
import Vision
import Firebase

class CaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    // MARK: - References
    var ref: DatabaseReference!
    var refInsert: DatabaseReference!
    
    
    // MARK: - Skeleton
    let previewView: UIView = {
       let pv = UIView()
        pv.backgroundColor = .white
        pv.layer.cornerRadius = 15
        pv.layer.shadowOffset = CGSize(width: 0, height: 10)
        pv.layer.shadowOpacity = 0.25
        pv.layer.shadowRadius = 10
        return pv
    }()
    
    let itemImage: UIImageView = {
       let ii = UIImageView()
        ii.contentMode = .scaleAspectFill
        ii.clipsToBounds = true
        return ii
    }()
    
    let itemTitle: UILabel = {
        let it = UILabel()
        it.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        it.textColor = .black
        it.text = "item"
        it.textAlignment = .center
        return it
    }()
    
    let itemCalories : UILabel = {
        let ic = UILabel()
        ic.textColor = .black
        ic.text = "1000"
        ic.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        return ic
    }()
    
    let cancelButton : UIButton = {
        let cb = UIButton()
        cb.setTitle("Cancel", for: .normal)
        cb.backgroundColor = .orange
        cb.addTarget(self, action: #selector(cancelItem), for: .touchUpInside)
        return cb
    }()
    
    let addButton : UIButton = {
        let cb = UIButton()
        cb.setTitle("Add Item", for: .normal)
        cb.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        cb.backgroundColor = .green
        return cb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.previewView.isHidden = true
        
        let userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("Food")
        refInsert = Database.database().reference().child("Status").child(userID)
    }
    
    
    // MARK: - Functions
    
    @objc func cancelItem() {
       self.previewView.isHidden = true
        
    }
    
    @objc func addItem() {
       let key = refInsert.childByAutoId().key!
        self.refInsert.child(key).setValue(["banana": 1])
        self.previewView.isHidden = true
    }

}
