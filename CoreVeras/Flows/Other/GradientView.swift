//
//  GradientView.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

class GradientView: UIView {
    
    private let gradient : CAGradientLayer = CAGradientLayer()
    private let colorGradients: [[CGColor]] = [
        [UIColor.init(rgb: 0xFFB703).cgColor, UIColor.init(rgb: 0xE38C4E).cgColor],
        [UIColor.init(rgb: 0x339ABA).cgColor, UIColor.init(rgb: 0x6A92DD).cgColor],
        [UIColor.init(rgb: 0x75AB70).cgColor, UIColor.init(rgb: 0x007602).cgColor],
        [UIColor.init(rgb: 0xCC6AA0).cgColor, UIColor.init(rgb: 0xF1A1CC).cgColor],
        [UIColor.init(rgb: 0xB491F8).cgColor, UIColor.init(rgb: 0x815EDD).cgColor],
        [UIColor.init(rgb: 0xE65D51).cgColor, UIColor.init(rgb: 0xEF8277).cgColor],
        [UIColor.init(rgb: 0xFAC817).cgColor, UIColor.init(rgb: 0xFFB703).cgColor],
        
    ]
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
        
        let shapeLayer = CAShapeLayer(layer: self.layer)
        shapeLayer.path = self.pathSemiCirclesPathForView(givenView: self, circlesDistance: (self.bounds.width/2)-45).cgPath
        shapeLayer.frame = self.bounds
        shapeLayer.masksToBounds = true
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 3
        self.layer.mask = shapeLayer
    }
    
    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        guard let gradientColor = self.colorGradients.randomElement() else { return }
        gradient.colors = gradientColor
        gradient.startPoint = CGPoint(x: 0.2, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
        
    }
    
    func pathSemiCirclesPathForView(givenView: UIView, ciclesRadius:CGFloat = 15, circlesDistance : CGFloat = 20) -> UIBezierPath {
        let width = givenView.frame.size.width
        let height = givenView.frame.size.height
        
        let semiCircleWidth = CGFloat(ciclesRadius*2)
        
        let semiCirclesPath = UIBezierPath()
        semiCirclesPath.move(to: CGPoint(x:0, y:0))
        
        var x = CGFloat(0)
        var i = 0
        while x < width {
            x = (semiCircleWidth) * CGFloat(i) + (circlesDistance * CGFloat(i))
            let pivotPoint = CGPoint(x: x + semiCircleWidth/2, y: height)
            if i % 2 != 0 {
                semiCirclesPath.addArc(withCenter: pivotPoint, radius: ciclesRadius, startAngle: -180 * .pi / 180.0, endAngle: 0 * .pi / 180.0, clockwise: true)
            } else {
                semiCirclesPath.addArc(withCenter: pivotPoint, radius: ciclesRadius, startAngle: -180 * .pi / 180.0, endAngle: -180 * .pi / 180.0, clockwise: true)
            }
            semiCirclesPath.addLine(to: CGPoint(x: semiCirclesPath.currentPoint.x + circlesDistance, y: height))
            i += 1
        }
        
        semiCirclesPath.addLine(to: CGPoint(x:width,y: 0))
        
        i = 0
        while x > 0 {
            x = width - (semiCircleWidth) * CGFloat(i) - (circlesDistance * CGFloat(i))
            let pivotPoint = CGPoint(x: x - semiCircleWidth/2, y: 0)
            if i % 2 != 0 {
                semiCirclesPath.addArc(withCenter: pivotPoint, radius: ciclesRadius, startAngle: 0 * .pi / 180.0, endAngle: -180 * .pi / 180.0, clockwise: true)
            } else {
                semiCirclesPath.addArc(withCenter: pivotPoint, radius: ciclesRadius, startAngle: 0 * .pi / 180.0, endAngle: 0 * .pi / 180.0, clockwise: true)
            }
            semiCirclesPath.addLine(to: CGPoint(x: semiCirclesPath.currentPoint.x - circlesDistance, y: 0))
            i += 1
        }
        
        semiCirclesPath.close()
        return semiCirclesPath
    }
}
