//
//  SceneDelegate.swift
//  EggTimer
//
//  Created by Siddharth Pillai on 24/12/2024.
//  Copyright © 2024 Siddharth Pillai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
   
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progressBar.progress = 0
        timer.invalidate() 
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            if let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") {
                do {
                    player = try! AVAudioPlayer(contentsOf: url)
                    player?.play()
                }
            }
        }
    }
}
