//
//  UIView Autolayout.swift
//  BullsEyeUIKit
//
//  Created by Devin Lumley on 2020-01-07.
//  Copyright © 2020 Devin Lumley. All rights reserved.
//

import UIKit

@objc extension UIView {
    @objc func apply(constraints: [NSLayoutConstraint] ){
        guard superview != nil else {
            assert(false, "\(self) must have a superview for constraints to be added")
            return
        }
 
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
