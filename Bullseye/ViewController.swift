//
//  ViewController.swift
//  Bullseye
//
//  Created by Earl Ashleigh M. Dela Cruz on 5/18/17.
//  Copyright © 2017 Earl Ashleigh M. Dela Cruz. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResiable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResiable, for: .normal)
        
        
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title:String
        if difference == 0 {
            title = "PERFECT!!!"
            points += 100
        } else if difference < 5 {
            title = "NOICE!!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Good job!"
        } else {
            title = "Damn bruh, you forreal?"
        }
        
        score += points
        
        let message = "You scored \(points) points" + "\nTarget value: \(targetValue)" + "\nYour value: \(currentValue)" + "\nDifference: \(difference)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in
                                                                                self.startNewRound()
                                                                                self.updateLabels()
                                                                        })

        
        alert.addAction(action)
        present(alert, animated: true, completion:nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        view.layer.add(transition, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = "\(score)"
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
}

