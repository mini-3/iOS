//
//  UserPromotionsCollectionViewCell.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 14/10/21.
//

import UIKit

class UserPromotionsCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: self)
    
    private var view: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = view.bounds.height/2
        view.backgroundColor = UIColor.white
        view.alpha = 0.5
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.image = nil
        view.alpha = 0.5
    }

    func configure(hasWon: Bool) {
        if hasWon {
            view.alpha = 0.9
            view.image = UIImage(systemName: "checkmark.circle")
            view.tintColor = .systemGreen
        }
        contentView.addSubview(view)
        
        let viewConstraints = [
            view.heightAnchor.constraint(equalToConstant: 32),
            view.widthAnchor.constraint(equalToConstant: 32),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(viewConstraints)
    }
}
