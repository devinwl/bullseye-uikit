//
//  View.swift
//  BullsEyeUIKit
//
//  Created by Devin Lumley on 2020-01-07.
//  Copyright © 2020 Devin Lumley. All rights reserved.
//

import UIKit

final class View: UIView {

    static let minValue: Int = 1
    static let maxValue: Int = 100

    let targetLabel = UILabel()
    let targetValueLabel = UILabel()

    lazy var targetStack: UIStackView = {
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

        return label
    }()

    let sliderMaxLabel = UILabel()

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

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        configureText()

        addSubviews()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        targetStack.addArrangedSubview(targetLabel)
        targetStack.addArrangedSubview(targetValueLabel)
        addSubview(targetStack)

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

        bottomView.addArrangedSubview(roundView)
        roundView.addArrangedSubview(roundLabel)
        roundView.addArrangedSubview(roundValueLabel)
    }

    func configureText() {
        targetLabel.text = "Get the slider as close as you can to:"
        
        sliderMinLabel.text = "\(Self.minValue)"
        sliderMaxLabel.text = "\(Self.maxValue)"
        
        hitMeButton.setTitle("Hit Me!", for: .normal)
        resetButton.setTitle("Start Over", for: .normal)
        
        scoreLabel.text = "Score:"
        roundLabel.text = "Round:"
    }

    func addConstraints() {
        sliderAndButtonStack.apply(constraints: [
       sliderAndButtonStack.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
       sliderAndButtonStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
       sliderAndButtonStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
   ])
   
   targetStack.apply(constraints: [
       targetStack.bottomAnchor.constraint(equalTo: sliderAndButtonStack.topAnchor, constant: -60),
       targetStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
   ])

   bottomView.apply(constraints: [
       bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
       bottomView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
       bottomView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
   ])
    }
}
