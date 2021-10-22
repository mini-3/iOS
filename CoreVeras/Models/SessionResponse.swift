//
//  SessionResponse.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

public struct SessionData: Codable {
    let token: String
    let user: CreateUserResponse?
}

public struct SessionResponse: Codable {
    let data: SessionData
}
