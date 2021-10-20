//
//  SyncService.swift
//  Fidelity-ios
//
//  Created by Santiago del Castillo Gonzaga on 19/10/21.
//

import Foundation

class SyncService {
    static let shared: SyncService = SyncService()
    @Published var ticketSync = false
    
    private init() {
        
    }
    
    public func syncTickets() {
        self.ticketSync.toggle()
    }
}
