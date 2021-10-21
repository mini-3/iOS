//
//  WonViewController.swift
//  Fidelity-ios
//
//  Created by Santiago del Castillo Gonzaga on 21/10/21.
//

import Foundation
import UIKit

class WonViewControler: UIViewController {
    
    private lazy var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var userPromotionTicket: Promotion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureSubViews()
        self.configureConstraints()
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Resgatar promoção"
        navigationController?.navigationBar.prefersLargeTitles = false
        let button = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(WonViewControler.tappedBackButton))
        self.navigationItem.rightBarButtonItem = button
        guard let user = SessionService.shared.user, let promotion = userPromotionTicket else { return }
        let qrCode = "\(user.email) \(promotion.code)"
        print(qrCode)
        qrCodeImageView.image = QRcodeService.shared.generateQRCode(from: qrCode)
    }
    
    func configureSubViews() {
        view.addSubview(qrCodeImageView)
    }
    
    func configureConstraints() {
        let qrCodeImageViewConstraints = [
            qrCodeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            qrCodeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrCodeImageView.heightAnchor.constraint(equalToConstant: 200),
            qrCodeImageView.widthAnchor.constraint(equalToConstant: 200)
        ]
        
        NSLayoutConstraint.activate(qrCodeImageViewConstraints)
    }
    
    @objc func tappedBackButton(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
