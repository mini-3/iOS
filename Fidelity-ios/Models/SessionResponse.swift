//
//  SessionResponse.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

struct SessionData: Codable {
    let token: String
}

struct SessionResponse: Codable {
    let data: SessionData
}
