//
//  ViewController.swift
//  BullsEye
//
//  Created by Pavel Prokofyev on 28.11.16.
//  Copyright © 2016 pavelprokofyev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var winCondition: UILabel!
    
    var winValue = 0
    var roundsCount = 0
    var scoreValue = 0
    
    var sliderValue: Int {
        get {
            return Int(slider.value * 100)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sliderThumbImage = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(sliderThumbImage, for: .normal)
        
        let sliderThumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(sliderThumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let sliderTrackLeft = #imageLiteral(resourceName: "SliderTrackLeft")
        let sliderTrackLeftResizable = sliderTrackLeft.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(sliderTrackLeftResizable, for: .normal)
        
        let sliderTrackRight = #imageLiteral(resourceName: "SliderTrackRight")
        let sliderTrackRightResizable = sliderTrackRight.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(sliderTrackRightResizable, for: .normal)
        
        startNewRound()
    }
    
    @IBAction func startButtonPressed() {
        startNewRound()
    }
    
    @IBAction func hitButtonPressed() {
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.startNewRound()
        })
        
        let roundScore = calculateScore(winScore: winValue, userScore: sliderValue)
        scoreValue += roundScore
        let message = "You hit \(sliderValue)!\nYour score is \(roundScore)"
        
        var title: String
        
        switch roundScore {
        case 0...50:
            title = "Not even close!"
        case 51...80:
            title = "Good enough!"
        case 81...100:
            title = "Bull's Eye!"
        default:
            title = "Wow how did you get here?"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(OKAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func calculateScore(winScore: Int, userScore: Int) -> Int {
        return 100 - abs(winScore - userScore)
    }
    
    func startNewRound() {
        winValue = Int(arc4random_uniform(100))
        roundsCount += 1
        updateValues()
    }
    
    func updateValues() {
        winCondition.text = "Put the Bull's Eye as close as you can to \(winValue)"
        score.text = "Score: \(scoreValue)"
        round.text = "Round \(roundsCount)"
        slider.value = 0.5
    }
}

