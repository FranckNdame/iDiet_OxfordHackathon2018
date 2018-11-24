//
//  NavigationViewAnimation.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

// MARK: - Animations
extension NavigationView {
    
    func animateIconColor(offset: CGFloat) {
        profileIconWhiteView.alpha = 1 - offset
        profileIconGrayView.alpha = offset
        intakeIconWhiteView.alpha = profileIconWhiteView.alpha
        intakeIconGrayView.alpha = profileIconWhiteView.alpha
    }
    
    func animateIconPosition(offset: CGFloat) {
        // Line the controls up along the bottom
        let finalDistanceFromBottom: CGFloat = 25.0
        var distance = scanButtonBottomConstraintConstant - finalDistanceFromBottom
        scanButtonBottomConstraint.constant = scanButtonBottomConstraintConstant - (distance * offset)
        distance = profileIconBottomConstraintConstant - finalDistanceFromBottom
        profileIconBottomConstraint.constant = profileIconBottomConstraintConstant - (distance * offset)
    }
    
    func animateIconScale(offset: CGFloat) {
        // Scale the controls using width constraints
        let finalWidthScale: CGFloat = scanButtonWidthConstraintConstant * 0.2
        scanButtonWidthConstraint.constant = scanButtonWidthConstraintConstant - (finalWidthScale * offset)
        let scale = profileIconWidthConstraintConstant * 0.2
        profileIconWidthConstraint.constant = profileIconWidthConstraintConstant - (scale * offset)
    }
    
    func animateIconCenter(offset: CGFloat) {

        let originalMultiplier = profileIconHorizontalConstraint.multiplier * bounds.width * 0.5
        let newMultiplier = (bounds.width * 0.54 * 0.5) - originalMultiplier
        profileIconHorizontalConstraint.constant = newMultiplier * offset
        intakeIconHorizontalConstraint.constant = -newMultiplier * offset
    }
    
    func animateBottomBar(percent: CGFloat) {
        // Controller Indicator Line
        let offset = abs(percent)
        let scaleTransform = CGAffineTransform(scaleX: offset, y: 1)
        let distance = 0.23 * bounds.width
        
        // use percent as it has the correct sign
        let transform =
            indicatorTransform.translatedBy(x: distance * percent,
                                            y: 0)
        indicator.transform = transform.concatenating(scaleTransform)
        indicator.alpha = offset
    }
    
}

