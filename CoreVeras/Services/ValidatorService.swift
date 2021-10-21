//
//  ValidatorService.swift
//  Fidelity-ios
//
//  Created by Artur Luis on 19/10/21.
//

import Foundation

public enum ValidatorDataTypes {
    case CPF
    case email
    case ISOString
    case password
    case CNPJ
}

public struct ValidatorService {
    static public func validate(value: String, type: ValidatorDataTypes) -> Bool {
        [
            ValidatorDataTypes.CPF: validateCpf(value),
            ValidatorDataTypes.email: validateEmail(value),
            ValidatorDataTypes.ISOString: validateISOString(value),
            ValidatorDataTypes.password: validatePassword(value),
            ValidatorDataTypes.CNPJ: validateCNPJ(value)
        ][type] ?? false
    }
    
    static private func validateCpf(_ cpf: String) -> Bool {
        return cpf.isCPF
    }
    
    static private func validateEmail(_ email: String)-> Bool {
        return email.isValidEmail()
    }
    
    static private func validatePassword(_ password: String) -> Bool{
        return true
    }
    
    static private func validateCNPJ(_ cnpj: String) -> Bool {
        return true
    }
    
    static private func validateISOString(_ isoString: String) -> Bool {
        return true
    }
}
