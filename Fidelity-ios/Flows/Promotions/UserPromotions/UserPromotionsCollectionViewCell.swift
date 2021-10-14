//
//  UserPromotionsCollectionViewCell.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

class UserPromotionsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: self)
    
    private var view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.layer.cornerRadius = view.bounds.height/2
        view.backgroundColor = UIColor.white
        view.alpha = 0.5
        return view
    }()

    func configure(hasWon: Bool) {
        if hasWon {
            view.alpha = 0.8
            view.backgroundColor = .label
        }
        contentView.addSubview(view)
        
        let viewConstraints = [
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(viewConstraints)
    }
}
