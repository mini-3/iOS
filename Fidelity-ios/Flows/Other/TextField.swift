//
//  TextField.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 15/10/21.
//

import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() {
            self.layer.borderColor = UIColor.systemBlue.cgColor
            return true
        }
        return false
    }
    
    override func resignFirstResponder() -> Bool {
        if super.resignFirstResponder() {
            self.layer.borderColor = UIColor.label.cgColor
            return true
        }
        return false
    }
}
