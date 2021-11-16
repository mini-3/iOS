//
//  TextField.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 15/10/21.
//

import UIKit

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.init(rgb: 0x4F4F4F)
        self.layer.cornerRadius = 8
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

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
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor.systemBlue.cgColor
            self.backgroundColor = UIColor.init(rgb: 0x303030)
            return true
        }
        return false
    }
    
    override func resignFirstResponder() -> Bool {
        if super.resignFirstResponder() {
            self.layer.borderWidth = 0
            self.backgroundColor = UIColor.init(rgb: 0x4F4F4F)
            return true
        }
        return false
    }
}
