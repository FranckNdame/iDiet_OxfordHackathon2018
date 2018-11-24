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
    
    var FoodName: [String] = [String]()
    var FoodCalories: [String] = [String]()
    let captureSession = AVCaptureSession()
   
    var available = true
    
    
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
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        
//    }
//    
    override func viewWillAppear(_ animated: Bool) {
        mainViewRef?.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.previewView.isHidden = true
//        mainViewRef?.delegate = self
        
        let userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("Food")
        refInsert = Database.database().reference().child("Status").child(userID)
        
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
        
        captureSession.addOutput(dataOutput)
        
        ObserveFood()
        
        setupView()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if available == true {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            print("this: \(firstObservation.identifier)")
            
            DispatchQueue.main.async {
                var i = 0
                for Food in self.FoodName {
                    if firstObservation.identifier == Food {
                        self.previewView.isHidden = false
                        self.itemTitle.text = Food
                        print(i)
                        self.itemCalories.text = self.FoodCalories[i]
                    }
                    i = i + 1
                }
                
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
    }
    
    
    // MARK: - Functions
    
    func setupView() {
        
        self.view.addSubview(previewView)
        previewView.anchor(top: nil, left: nil, right: nil, bottom: self.view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 16, width: 343, height: 462)
        previewView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        previewView.addSubview(itemImage)
        itemImage.anchor(top: previewView.topAnchor, left: previewView.leftAnchor, right: previewView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 150)
        
        previewView.addSubview(itemTitle)
        itemTitle.anchor(top: itemImage.bottomAnchor, left: previewView.leftAnchor, right: previewView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        previewView.addSubview(itemCalories)
        itemCalories.anchor(top: itemTitle.bottomAnchor, left: previewView.leftAnchor, right: previewView.rightAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        previewView.addSubview(addButton)
        addButton.anchor(top: itemCalories.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        addButton.centerXAnchor.constraint(equalTo: previewView.centerXAnchor).isActive = true
        
        previewView.addSubview(cancelButton)
        cancelButton.anchor(top: addButton.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 200, height: 0)
        cancelButton.centerXAnchor.constraint(equalTo: previewView.centerXAnchor).isActive = true
        
    }
    
    @objc func cancelItem() {
       self.previewView.isHidden = true
        
    }
    
    @objc func addItem() {
       let key = refInsert.childByAutoId().key!
        self.refInsert.child(key).setValue(["banana": 1])
        self.previewView.isHidden = true
    }
    
    func ObserveFood() {
        ref.observe(.childAdded, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            self.FoodName.append(value?["Name"] as! String)
            self.FoodCalories.append(value?["Calories"] as! String)
        
        })
    }
    


}

extension CaptureViewController: CaptureDelegate {
    func shouldAbortCapture() {
//        captureSession.stopRunning()
        available = false
    }
    
    func shouldRestartCapture() {
//        captureSession.startRunning()
        available = true
    }
    
    
}
