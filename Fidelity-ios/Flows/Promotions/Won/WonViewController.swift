//
//  WonViewController.swift
//  Fidelity-ios
//
//  Created by Santiago del Castillo Gonzaga on 21/10/21.
//

import Foundation
import UIKit

protocol WonViewControllerDelegate: AnyObject {
    func dismissed()
}

class WonViewControler: UIViewController {
    
    weak var delegate: WonViewControllerDelegate?
    
    var userPromotionTicket: Promotion?
    
    private lazy var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureSubViews()
        self.configureConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.dismissed()
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "Background")
        title = "Resgatar promoção"
        navigationController?.navigationBar.prefersLargeTitles = false
        let button = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(WonViewControler.tappedBackButton))
        self.navigationItem.rightBarButtonItem = button
        guard let promotion = userPromotionTicket else { return }
        let qrCode = "\(SessionService.shared.email) \(promotion.code)"
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
