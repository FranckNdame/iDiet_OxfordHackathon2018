//
//  Extensions.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/24/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation


func bmi(weight: String, height:String) -> Double {
    let heightstart = Int(height) ?? 0
    let heightMeters = Double(heightstart) / 100
    let heightsquared = Double(heightMeters) * Double(heightMeters)
    let weightstart = Int(weight) ?? 0
    let bmi = Double(weightstart)/heightsquared
    return Double(round(100*bmi)/100)
}
var audioPlayer : AVAudioPlayer!
func playSound(_ soundFile: String, withExtension ext: String) {
    let soundURL = Bundle.main.url(forResource: soundFile, withExtension: ext)!
    
    do {
        try audioPlayer = AVAudioPlayer(contentsOf: soundURL)
    }
    catch {
        print(error)
    }
    audioPlayer.play()
}

let impact = UIImpactFeedbackGenerator()
