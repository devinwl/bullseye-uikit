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
 
    let targetLabel = UILabel()
    let targetValueLabel = UILabel()
    
    let targetStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5.0
        return stack
    }()
 
    let sliderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20.0
        stack.isUserInteractionEnabled = true
        return stack
    }()
 
    let sliderMinLabel = UILabel()
    let sliderMaxLabel = UILabel()
 
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(Int(minValue + maxValue / 2))
        return slider
    }()
    
    let sliderAndButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        return stack
    }()
 
    let hitMeButton = UIButton(type: .system)
    let resetButton = UIButton(type: .system)
   
    let roundLabel = UILabel()
    let roundValueLabel = UILabel()
    let roundView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5.0
        return stack
    }()
   
    let scoreLabel = UILabel()
    let scoreValueLabel = UILabel()
    let scoreView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5.0
        return stack
    }()
   
    let bottomView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
   
    var score = 0
    var round = 1
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
 
        configureText()
 
        addSubviews()
        addConstraints()
 
        hitMeButton.addTarget(self, action: #selector(handleHitMeButton), for: UIControl.Event.touchUpInside)
        resetButton.addTarget(self, action: #selector(handleResetButton), for: UIControl.Event.touchUpInside)
 
        generateNewTarget()
        updateScoreValueLabel()
        updateRoundValueLabel()
    }
 
    func addSubviews() {
        targetStack.addArrangedSubview(targetLabel)
        targetStack.addArrangedSubview(targetValueLabel)
        view.addSubview(targetStack)
 
        sliderStack.addArrangedSubview(sliderMinLabel)
        sliderStack.addArrangedSubview(slider)
        sliderStack.addArrangedSubview(sliderMaxLabel)
        
        sliderAndButtonStack.addArrangedSubview(sliderStack)
        sliderAndButtonStack.addArrangedSubview(hitMeButton)
        view.addSubview(sliderAndButtonStack)
 
        view.addSubview(bottomView)
        bottomView.addArrangedSubview(resetButton)
 
        bottomView.addArrangedSubview(scoreView)
        scoreView.addArrangedSubview(scoreLabel)
        scoreView.addArrangedSubview(scoreValueLabel)
 
        bottomView.addArrangedSubview(roundView)
        roundView.addArrangedSubview(roundLabel)
        roundView.addArrangedSubview(roundValueLabel)
    }
 
    func configureText() {
        targetLabel.text = "Get the slider as close as you can to:"
 
        sliderMinLabel.text = "\(minValue)"
        sliderMaxLabel.text = "\(maxValue)"
       
        hitMeButton.setTitle("Hit Me!", for: .normal)
        resetButton.setTitle("Start Over", for: .normal)
 
        scoreLabel.text = "Score:"
        roundLabel.text = "Round:"
    }
 
    func addConstraints() {
        targetStack.apply(constraints: [
            targetStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            targetStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        
        sliderAndButtonStack.apply(constraints: [
            sliderAndButtonStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            sliderAndButtonStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
 
        bottomView.apply(constraints: [
            bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
   
    @objc func handleHitMeButton() {
        let difference = abs(targetValue - Int(slider.value.rounded()))
        let bonus: Int
       
        if difference == 0 {
            bonus = 100
        } else if difference <= 2 {
            bonus = 50
        } else {
            bonus = 0
        }
       
        let score: Int = 100 - difference + bonus
       
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
        updateRoundValueLabel()
    }
   
    func addToScore(score: Int) {
        self.score += score
        updateScoreValueLabel()
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
