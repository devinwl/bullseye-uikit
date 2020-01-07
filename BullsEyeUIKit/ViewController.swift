//
//  ViewController.swift
//  BullsEyeUIKit
//
//  Created by Devin Lumley on 2020-01-06.
//  Copyright © 2020 Devin Lumley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var targetLabel: UILabel!
    var targetValue: Int = Int.random(in: 1...100)
    var targetValueLabel: UILabel!
    var sliderMinLabel: UILabel!
    var sliderMaxLabel: UILabel!
    var slider: UISlider!
    var hitMeButton: UIButton!
    var resetButton: UIButton!
    
    var roundLabel: UILabel!
    var roundValueLabel: UILabel!
    var roundView: UIStackView!
    
    var scoreLabel: UILabel!
    var scoreValueLabel: UILabel!
    var scoreView: UIStackView!
    
    var bottomView: UIStackView!
    
    var score: Int = 0
    var round: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        targetLabel = UILabel(frame: .zero)
        targetLabel.translatesAutoresizingMaskIntoConstraints = false
        targetLabel.text = "Get the slider as close as you can to:"
        view.addSubview(targetLabel)
        
        targetValueLabel = UILabel(frame: .zero)
        targetValueLabel.translatesAutoresizingMaskIntoConstraints = false
        targetValueLabel.text = "\(targetValue)"
        view.addSubview(targetValueLabel)
        
        slider = UISlider(frame: .zero)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.value = 50
        view.addSubview(slider)
        
        sliderMinLabel = UILabel(frame: .zero)
        sliderMinLabel.text = "\(Int(slider.minimumValue))"
        sliderMinLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sliderMinLabel)
        
        sliderMaxLabel = UILabel(frame: .zero)
        sliderMaxLabel.text = "\(Int(slider.maximumValue))"
        sliderMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sliderMaxLabel)
        
        hitMeButton = UIButton(type: .system)
        hitMeButton.setTitle("Hit Me!", for: .normal)
        hitMeButton.translatesAutoresizingMaskIntoConstraints = false
        hitMeButton.addTarget(self, action: #selector(handleHitMeButton), for: UIControl.Event.touchUpInside)
        view.addSubview(hitMeButton)
        
        resetButton = UIButton(type: .system)
        resetButton.setTitle("Start Over", for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(handleResetButton), for: UIControl.Event.touchUpInside)
        
        scoreLabel = UILabel(frame: .zero)
        scoreLabel.text = "Score:"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scoreValueLabel = UILabel(frame: .zero)
        scoreValueLabel.text = "\(Int(score))"
        scoreValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scoreView = UIStackView()
        scoreView.axis = .horizontal
        scoreView.spacing = 5.0
        scoreView.addArrangedSubview(scoreLabel)
        scoreView.addArrangedSubview(scoreValueLabel)
        
        roundLabel = UILabel(frame: .zero)
        roundLabel.text = "Round:"
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        
        roundValueLabel = UILabel(frame: .zero)
        roundValueLabel.text = "\(round)"
        roundValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        roundView = UIStackView()
        roundView.axis = .horizontal
        roundView.spacing = 5.0
        roundView.addArrangedSubview(roundLabel)
        roundView.addArrangedSubview(roundValueLabel)
        
        bottomView = UIStackView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.axis = .horizontal
        bottomView.distribution = .equalSpacing
        bottomView.addArrangedSubview(resetButton)
        bottomView.addArrangedSubview(scoreView)
        bottomView.addArrangedSubview(roundView)
        view.addSubview(bottomView)
        
        constraintsInit()
    }
    
    func constraintsInit() {
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            targetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            targetValueLabel.leadingAnchor.constraint(equalTo: targetLabel.trailingAnchor, constant: 10),
            targetValueLabel.centerYAnchor.constraint(equalTo: targetLabel.centerYAnchor),
            
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            slider.topAnchor.constraint(equalTo: targetLabel.topAnchor, constant: 60),
            
            sliderMinLabel.trailingAnchor.constraint(equalTo: slider.leadingAnchor, constant: -20),
            sliderMinLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            
            sliderMaxLabel.leadingAnchor.constraint(equalTo: slider.trailingAnchor, constant: 20),
            sliderMaxLabel.centerYAnchor.constraint(equalTo: slider.centerYAnchor),
            
            hitMeButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
            hitMeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func handleHitMeButton() {
        let difference = abs(targetValue - Int(slider.value.rounded()))
        let bonus: Int
        
        if(difference == 0) {
            bonus = 100
        } else if (difference <= 2) {
            bonus = 50
        } else {
            bonus = 0
        }
        
        let score: Int = (100 - difference) + bonus
        
        addToScore(score: score)
        nextRound()
        generateNewTarget()
    }
    
    func generateNewTarget() {
        targetValue = Int.random(in: 1...100)
        targetValueLabel.text = "\(targetValue)"
    }
    
    func nextRound() {
        round += 1
        roundValueLabel.text = "\(self.round)"
    }
    
    func addToScore(score: Int) {
        self.score += score
        scoreValueLabel.text = "\(self.score)"
    }
    
    func updateScoreValueLabel() {
        scoreValueLabel.text = "\(self.score)"
    }
    
    func updateRoundValueLabel() {
        roundValueLabel.text = "\(self.round)"
    }
    
    @objc func handleResetButton() {
        score = 0
        round = 1
        updateScoreValueLabel()
        updateRoundValueLabel()
    }

}
