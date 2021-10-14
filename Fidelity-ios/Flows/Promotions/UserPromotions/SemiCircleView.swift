//
//  HalfCircleView.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

class SemiCirleView: UIView {

    var semiCirleLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if semiCirleLayer == nil {
            let arcCenter = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
            let circleRadius = bounds.size.width / 2
            let circlePath = UIBezierPath(arcCenter: arcCenter, radius: circleRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)

            semiCirleLayer = CAShapeLayer()
            semiCirleLayer.path = circlePath.cgPath
            semiCirleLayer.fillColor = UIColor.white.cgColor
            layer.addSublayer(semiCirleLayer)
            backgroundColor = UIColor.clear
        }
    }
}
