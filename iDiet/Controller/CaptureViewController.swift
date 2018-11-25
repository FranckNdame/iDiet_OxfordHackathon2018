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

var FoodName: [String] = [String]()
var captureRef: CaptureViewController?

class CaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    // MARK: - References
    var ref: DatabaseReference!
    var delegate: LensDelegate?
    
    
    
    var FoodCalories: [String] = [String]()
    let captureSession = AVCaptureSession()
   
    var available = true
    var loop = 1
    
    override func viewWillAppear(_ animated: Bool) {
        mainViewRef?.delegate = self
//        lensRef?.delegate = self
//        captureRef = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        captureRef = self
         lensRef?.delegate = self
        print(lensRef)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mainViewRef?.delegate = self
    
        
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
        ref = Database.database().reference().child("Food")
        ObserveFood()
        
    }

    

    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        if available == true {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
//            print("this: \(firstObservation.identifier)")
            guard let singleResult = firstObservation.identifier.components(separatedBy: ",").first else {return}
            print("this: \(singleResult)")
            DispatchQueue.main.async {
                var i = 0
                for food in FoodName {
                    if singleResult == food {
//                        self.previewView.isHidden = false
//                        self.itemTitle.text = Food
//                        print(i)
//                        self.itemCalories.text = "Calories: \(self.FoodCalories[i])"
                        self.available = false
                        self.delegate?.foodItem(title: food, calories: "\(self.FoodCalories[i])", fat: "Fat: 100g", sugar: "Sugar: 500g")
                        
                    }
                    i = i + 1
                }
                
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        }
    }
    
    
    // MARK: - Functions
    
    func ObserveFood() {
        ref.observe(.childAdded, with: { snapshot in
            
            let value = snapshot.value as? NSDictionary
            FoodName.append(value?["Name"] as! String)
            self.FoodCalories.append(value?["Calories"] as! String)
            print("here")
        })
    }
    


}

extension CaptureViewController: CaptureDelegate {
    func mshouldAbortCapture() {
        available = false
    }
    
    func mshouldRestartCapture() {
        available = true
    }
    
    func shouldAbortCapture() {
//        captureSession.stopRunning()
        available = false
    }
    
    func shouldRestartCapture() {
//        captureSession.startRunning()
        available = true
    }
    
    
}
