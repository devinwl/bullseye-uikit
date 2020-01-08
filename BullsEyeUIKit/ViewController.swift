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
        
        customView.updateScoreValueLabel(newScore: score)
        customView.updateRoundValueLabel(round: round)
    }
   
    @objc func handleHitMeButton() {
        let difference = abs(targetValue - Int(customView.getSliderValue()))
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
        
        customView.animatePointsOverScore(points: totalPoints)
    }
    
    @objc func handleResetButton() {
        if score != 0 && round != 1 {
            score = 0
            round = 1
            customView.updateScoreValueLabel(newScore: score)
            customView.updateRoundValueLabel(round: round)
        }
    }
   
    func generateNewTarget() {
        targetValue = Int.random(in: 1...100)
        customView.updateTargetValueLabel(newValue: targetValue)
    }
   
    func nextRound() {
        round += 1
        customView.resetSlider()
        customView.updateRoundValueLabel(round: round)
    }
   
    func addToScore(points: Int) {
        self.score += points
        customView.updateScoreValueLabel(newScore: self.score)
    }
}
