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
    var timer = Timer()
    let maxGuessTime = 4.0
    
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
        
        customView.updateScoreValueLabel(newScore: score)
        
        resetTimer()
    }
   
    @objc func handleHitMeButton() {
        let difference = abs(targetValue - Int(customView.getSliderValue()))
        let multiplier: Double
        let bonus: Int
       
        if difference == 0 {
            bonus = 100
            multiplier = 3.0
        } else if difference <= 2 {
            bonus = 50
            multiplier = max(1, timer.fireDate.timeIntervalSinceNow)
        } else {
            bonus = 0
            multiplier = 1
        }
       
        let startingPoints: Double = max(0, Double(25 - difference))
        let pointsWithMultiplier: Double = startingPoints * multiplier
        let totalPoints: Int = Int(pointsWithMultiplier.rounded()) + bonus
       
        addToScore(points: totalPoints)
        generateNewTarget()
        resetTimer()
        
        customView.resetSlider()
        customView.animatePointsOverScore(points: totalPoints)
    }
    
    @objc func handleResetButton() {
        if score != 0 {
            score = 0
            customView.updateScoreValueLabel(newScore: score)
            customView.resetSlider()
            resetTimer()
            generateNewTarget()
            customView.startCircleCountdown()
        }
    }
    
    @objc func handleTimerFired() {
        generateNewTarget()
    }
   
    func generateNewTarget() {
        targetValue = Int.random(in: 1...100)
        customView.updateTargetValueLabel(newValue: targetValue)
        customView.startCircleCountdown()
    }
   
    func addToScore(points: Int) {
        if points > 0 {
            self.score += points
            customView.updateScoreValueLabel(newScore: self.score)
        }
    }
    
    func resetTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: maxGuessTime, target: self, selector: #selector(handleTimerFired), userInfo: nil, repeats: true)
    }
}
