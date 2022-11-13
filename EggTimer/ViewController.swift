//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft" : 3, "Medium" : 5, "Hard" : 7]
    var totalTime : Float = 0
    var passedTime  : Float = 0

    
    var timer = Timer()
    @IBAction func eggPressed(_ sender: UIButton) {
        self.timer.invalidate()
        self.titleLabel.text = "Cooking..."
        progressBar.progress = 0
        let harder = sender.currentTitle!
        self.titleLabel.text = harder
        totalTime = Float(eggTimes[harder]!)

        timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if (self.passedTime < self.totalTime) {
                
                self.passedTime += 1
                print ("passed time: \(self.passedTime), total time:  \(self.totalTime)")
                
                
                let progressBr : Float = Float(self.passedTime / self.totalTime)
                print(progressBr)
                self.progressBar.progress = progressBr
                
                
            } else {
                self.titleLabel.text = "Your egg is ready"
                self.timer.invalidate()
                self.playSound()
                self.totalTime = Float(0)
                self.passedTime = Float(0)
            }
        }
    }
    

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
