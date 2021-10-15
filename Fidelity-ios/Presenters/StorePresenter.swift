//
//  StorePresenter.swift
//  Fidelity-ios
//
//  Created by Pedro Gomes Rubbo Pacheco on 13/10/21.
//

import Foundation
import UIKit

protocol StorePresenterDelegate: AnyObject {
    func fetched(stores: [StoreViewModel])
    
}

extension StorePresenterDelegate {
    func fetched(stores: [StoreViewModel]) {}
}

class StorePresenter {
    
    weak var view: (StorePresenterDelegate & UIViewController)?
    
    init() {}
    
    func fetchStores() {
        view?.presentLoadingScreen()
        WebService.get(path: "/stores", type: [Store].self) {[weak self] result in
            guard let self = self else {
                self?.view?.dismiss(animated: true, completion: nil)
                return
            }
            switch result {
            case .success(let stores):
                let viewModels = stores.sorted { $0.id < $1.id } .map { StoreViewModel(with: $0) }
                self.view?.fetched(stores: viewModels)
                DispatchQueue.main.sync {
                    self.view?.dismiss(animated: true, completion: nil)
                }
                print(viewModels)
            case .failure(let error):
                self.view?.dismiss(animated: true, completion: nil)
                print(error)
            }
        }
    }
    
}
