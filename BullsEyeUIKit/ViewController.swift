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
        sliderAndButtonStack.apply(constraints: [
            sliderAndButtonStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            sliderAndButtonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sliderAndButtonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        targetStack.apply(constraints: [
            targetStack.bottomAnchor.constraint(equalTo: sliderAndButtonStack.topAnchor, constant: -60),
            targetStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
 
        bottomView.apply(constraints: [
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
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
       
        let totalPoints: Int = 100 - difference + bonus
       
        addToScore(points: totalPoints)
        nextRound()
        generateNewTarget()
        animatePointsOverScore(points: totalPoints)
    }
   
    func generateNewTarget() {
        targetValue = Int.random(in: 1...100)
        targetValueLabel.text = "\(targetValue)"
        pulseText(element: targetValueLabel)
    }
   
    func nextRound() {
        round += 1
        updateRoundValueLabel()
    }
   
    func addToScore(points: Int) {
        self.score += points
        updateScoreValueLabel()
    }
   
    func updateScoreValueLabel() {
        scoreValueLabel.text = "\(self.score)"
        pulseText(element: scoreValueLabel)
    }
   
    func updateRoundValueLabel() {
        roundValueLabel.text = "\(self.round)"
        pulseText(element: roundValueLabel)
    }
    
    func animatePointsOverScore(points: Int) {
        let location = scoreValueLabel.convert(scoreValueLabel.bounds, to: self.view)
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
