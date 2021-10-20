//
//  ValidatorService.swift
//  Fidelity-ios
//
//  Created by Artur Luis on 19/10/21.
//

import Foundation

enum ValidatorDataTypes {
    case CPF
    case email
    case ISOString
    case password
    case CNPJ
}

struct ValidatorService {
    static func validate(value: String, type: ValidatorDataTypes) -> Bool {
        [
            ValidatorDataTypes.CPF: validateCpf(value),
            ValidatorDataTypes.email: validateEmail(value),
            ValidatorDataTypes.ISOString: validateISOString(value),
            ValidatorDataTypes.password: validatePassword(value),
            ValidatorDataTypes.CNPJ: validateCNPJ(value)
        ][type] ?? false
    }
    
    static private func validateCpf(_ cpf: String) -> Bool {
        return true
    }
    
    static private func validateEmail(_ email: String)-> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
