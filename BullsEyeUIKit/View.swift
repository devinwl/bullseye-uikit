//
//  View.swift
//  BullsEyeUIKit
//
//  Created by Devin Lumley on 2020-01-07.
//  Copyright © 2020 Devin Lumley. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}

final class View: UIView {

    static let minValue: Int = 1
    static let maxValue: Int = 100
    
    // TODO: This should be set from the ViewController
    let maxGuessTime: Float = 4.0

    let targetValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 48)
        label.sizeToFit()
        return label
    }()

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

    let sliderMinLabel: UILabel = {
        let label = UILabel()
        label.text = "\(minValue)"
        return label
    }()

    let sliderMaxLabel: UILabel = {
        let label = UILabel()
        label.text = "\(maxValue)"
        return label
    }()

    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = Float(Self.minValue)
        slider.maximumValue = Float(Self.maxValue)
        slider.value = Float(Int(Self.minValue + Self.maxValue / 2))
        return slider
    }()

    let sliderAndButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        return stack
    }()

    let hitMeButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Hit Me!", for: .normal)
        return button
    }()
    
    let resetButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        let arrowCounterClockwiseCircle = UIImage(systemName: "arrow.counterclockwise.circle")
        button.setImage(arrowCounterClockwiseCircle, for: .normal)
        return button
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score:"
        return label
    }()
    
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
    
    static let circleRadius: CGFloat = 60.0
    static let circleLineWidth: Double = 20.0
    static let circleViewWidth = Double(circleRadius * 2) + circleLineWidth
    static let circleViewHeight = circleViewWidth
    
    var circleLayer = CAShapeLayer()
    
    lazy var countdownCircle: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Self.circleViewWidth, height: Self.circleViewHeight))
                
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: Self.circleViewWidth / 2, y: Self.circleViewHeight / 2), radius: Self.circleRadius, startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat((Double.pi * 2.0) - Double.pi / 2), clockwise: true)

        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.systemBlue.cgColor
        circleLayer.lineWidth = 20.0;

        view.layer.addSublayer(circleLayer)
        
        view.addSubview(targetValueLabel)
        
        targetValueLabel.apply(constraints: [
            targetValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            targetValueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground
        
        addSubviews()
        addConstraints()
        
        startCircleCountdown()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        sliderStack.addArrangedSubview(sliderMinLabel)
        sliderStack.addArrangedSubview(slider)
        sliderStack.addArrangedSubview(sliderMaxLabel)

        sliderAndButtonStack.addArrangedSubview(sliderStack)
        sliderAndButtonStack.addArrangedSubview(hitMeButton)
        addSubview(sliderAndButtonStack)

        addSubview(bottomView)
        bottomView.addArrangedSubview(resetButton)

        bottomView.addArrangedSubview(scoreView)
        scoreView.addArrangedSubview(scoreLabel)
        scoreView.addArrangedSubview(scoreValueLabel)
        
        addSubview(countdownCircle)
    }

    func addConstraints() {
        sliderAndButtonStack.apply(constraints: [
            sliderAndButtonStack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).priority(.defaultHigh),
           sliderAndButtonStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
           sliderAndButtonStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
       ])
   
        countdownCircle.apply(constraints: [
            countdownCircle.bottomAnchor.constraint(equalTo: sliderAndButtonStack.topAnchor, constant: -60),
            countdownCircle.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            countdownCircle.widthAnchor.constraint(equalToConstant: CGFloat(Self.circleViewWidth)),
            countdownCircle.heightAnchor.constraint(equalToConstant: CGFloat(Self.circleViewHeight)),
            countdownCircle.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

       bottomView.apply(constraints: [
           bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
           bottomView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
           bottomView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
       ])
    }
    
    func resetSlider() {
        slider.value = Float(Int(Self.minValue + Self.maxValue / 2))
    }
    
    func getSliderValue() -> Float {
        slider.value.rounded()
    }
    
    func updateTargetValueLabel(newValue: Int) {
        targetValueLabel.text = "\(newValue)"
        pulseElement(element: targetValueLabel)
    }
    
    func updateScoreValueLabel(newScore: Int) {
        scoreValueLabel.text = "\(newScore)"
        pulseElement(element: scoreValueLabel)
    }

    /** Animation stuff */
    func animatePointsOverScore(points: Int) {
        if (points > 0) {
            let floatingLabel = UILabel()
            floatingLabel.text = "+ \(points)"
            floatingLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(floatingLabel)
            floatingLabel.sizeToFit()

            let bottomConstraint = floatingLabel.bottomAnchor.constraint(equalTo: scoreValueLabel.bottomAnchor, constant: -18)

            NSLayoutConstraint.activate([
                bottomConstraint,
                floatingLabel.trailingAnchor.constraint(equalTo: scoreValueLabel.trailingAnchor)
            ])
            layoutIfNeeded()
            bottomConstraint.constant = -40

            UIView.animate(withDuration: 0.5, animations: {
                self.layoutIfNeeded()

                floatingLabel.alpha = 0
            }, completion: { completed in
                floatingLabel.removeFromSuperview()
            })
        }
    }
    
    func pulseElement(element: UIView) {
        UIView.animate(withDuration: 0.05, animations: {
            element.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { completed in
            UIView.animate(withDuration: 0.05, animations: {
                element.transform = CGAffineTransform.identity
            }, completion: nil)
        })
    }
    
    func startCircleCountdown() {
        countdownCircle.layer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = CFTimeInterval(maxGuessTime)
        animation.repeatCount = Float.infinity
        circleLayer.add(animation, forKey: nil)
    }
}
