//
//  GradientView.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

class GradientView: UIView {

    private let gradient : CAGradientLayer = CAGradientLayer()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        let color = UIColor.random
        gradient.colors = [
            color.darker(by: 20)?.cgColor ?? color.cgColor,
            color.darker(by: 10)?.cgColor ?? color.cgColor,
            color.cgColor,
            color.darker(by: 20)?.cgColor ?? color.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.2, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
}
