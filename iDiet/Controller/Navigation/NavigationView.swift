//
//  NavigationView.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    
    // MARK: - Properties
    lazy var scanButtonWidthConstraintConstant: CGFloat = {
        return self.scanButtonWidthConstraint.constant
    }()
    lazy var scanButtonBottomConstraintConstant: CGFloat = {
        return self.scanButtonBottomConstraint.constant
    }()
    lazy var profileIconWidthConstraintConstant: CGFloat = {
        return self.profileIconWidthConstraint.constant
    }()
    lazy var profileIconBottomConstraintConstant: CGFloat = {
        return self.profileIconBottomConstraint.constant
    }()
    lazy var profileIconHorizontalConstraintConstant: CGFloat = {
        return self.profileIconHorizontalConstraint.constant
    }()
    lazy var intakeIconHorizontalConstraintConstant: CGFloat = {
        return self.intakeIconHorizontalConstraint.constant
    }()
    lazy var indicatorTransform: CGAffineTransform = {
        return self.scanButtonView.transform
    }()
    
    
    @IBOutlet var scanButtonView: UIView!
    @IBOutlet var scanButtonWhiteView: UIImageView!
    @IBOutlet var scanButtonGrayView: UIImageView!
    @IBOutlet var scanButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet var scanButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var profileIconView: UIView!
    @IBOutlet var profileIconWhiteView: UIImageView!
    @IBOutlet var profileIconGrayView: UIImageView!
    @IBOutlet var profileIconWidthConstraint: NSLayoutConstraint!
    @IBOutlet var profileIconBottomConstraint: NSLayoutConstraint! // might not work
    @IBOutlet var profileIconHorizontalConstraint: NSLayoutConstraint!
    
    @IBOutlet var intakeIconView: UIView!
    @IBOutlet var intakeIconWhiteView: UIImageView!
    @IBOutlet var intakeIconGrayView: UIImageView!
    @IBOutlet var intakeIconHorizontalConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var indicator: UIView!
    
    @IBOutlet var colorView: UIView!
    
    // MARK: - Internal
    func shadow(layer: CALayer, color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.5
    }
    
    func setup() {
        shadow(layer: scanButtonWhiteView.layer, color: .black)
        shadow(layer: profileIconWhiteView.layer, color: .darkGray)
        shadow(layer: intakeIconWhiteView.layer, color: .darkGray)
    }
    
    // MARK: - View Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        indicator.layer.cornerRadius = indicator.bounds.height / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
    
    func animate(to controller: UIViewController?, percent: CGFloat) {
        let offset = abs(percent)
        
        scanButtonWhiteView.alpha = 1 - offset
        scanButtonGrayView.alpha = offset
        
        animateIconColor(offset: offset)
        animateIconScale(offset: offset)
        animateIconCenter(offset: offset)
        animateIconPosition(offset: offset)
        
        animateBottomBar(percent: percent)
        
        if let controller = controller as? ColoredView {
            colorView.backgroundColor = controller.controllerColor
        }
        colorView.alpha = offset
        layoutIfNeeded()
    }
}
