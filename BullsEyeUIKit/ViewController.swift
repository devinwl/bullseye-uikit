//
//  ViewController.swift
//  BullsEyeUIKit
//
//  Created by Devin Lumley on 2020-01-06.
//  Copyright © 2020 Devin Lumley. All rights reserved.
//
 
import UIKit
 
let minValue: Int = 1
let maxValue: Int = 100
 
class ViewController: UIViewController {
    
    var targetValue = 0
    var score = 0
    var round = 1
    
    let customView: View = {
        return View(frame: UIScreen.main.bounds)
    }()
    
    override func loadView() {
        view = customView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        customView.hitMeButton.addTarget(self, action: #selector(handleHitMeButton), for: UIControl.Event.touchUpInside)
        customView.resetButton.addTarget(self, action: #selector(handleResetButton), for: UIControl.Event.touchUpInside)
 
        generateNewTarget()
        updateScoreValueLabel()
        updateRoundValueLabel()
    }
   
    @objc func handleHitMeButton() {
        let difference = abs(targetValue - Int(customView.slider.value.rounded()))
        let bonus: Int
       
        if difference == 0 {
            bonus = 100
        } else if difference <= 2 {
            bonus = 50
        } else {
            bonus = 0
        }
       
        let totalPoints: Int = 100 - difference + bonus
       
        addToScore(points: totalPoints)
        nextRound()
        generateNewTarget()
        animatePointsOverScore(points: totalPoints)
    }
   
    func generateNewTarget() {
        targetValue = Int.random(in: 1...100)
        customView.targetValueLabel.text = "\(targetValue)"
        pulseText(element: customView.targetValueLabel)
    }
   
    func nextRound() {
        round += 1
        customView.slider.value = Float(Int(minValue + maxValue / 2))
        updateRoundValueLabel()
    }
   
    func addToScore(points: Int) {
        self.score += points
        updateScoreValueLabel()
    }
   
    func updateScoreValueLabel() {
        customView.scoreValueLabel.text = "\(self.score)"
        pulseText(element: customView.scoreValueLabel)
    }
   
    func updateRoundValueLabel() {
        customView.roundValueLabel.text = "\(self.round)"
        pulseText(element: customView.roundValueLabel)
    }
    
    func animatePointsOverScore(points: Int) {
        let location = customView.scoreValueLabel.convert(customView.scoreValueLabel.bounds, to: self.view)
        let floatingLabel = UILabel(frame: location)
        floatingLabel.text = "+ \(points)"
        view.addSubview(floatingLabel)
        floatingLabel.sizeToFit()

        UIView.animate(withDuration: 0.5, animations: {
            var frame = floatingLabel.frame
            frame.origin.y = frame.origin.y - 40
            floatingLabel.frame = frame
            floatingLabel.alpha = 0
        }, completion: { completed in
            floatingLabel.removeFromSuperview()
        })
    }
    
    func pulseText(element: UIView) {
        UIView.animate(withDuration: 0.05, animations: {
            element.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { completed in
            UIView.animate(withDuration: 0.05, animations: {
                element.transform = CGAffineTransform.identity
            }, completion: nil)
        })
    }
   
    @objc func handleResetButton() {
        if score != 0 && round != 1 {
            score = 0
            round = 1
            updateScoreValueLabel()
            updateRoundValueLabel()
        }
    }
 
}
