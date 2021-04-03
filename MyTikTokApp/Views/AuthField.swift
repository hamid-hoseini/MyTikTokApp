//
//  AuthField.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 3/29/21.
//

import UIKit

class AuthField: UITextField {

    enum FieldType {
        case username
        case email
        case password
    
        var title: String {
            switch self {
            case .username: return "Username"
            case .email: return "Email Address"
            case .password: return "Password"
            }
        }
    }
    
    private let type: FieldType

    init(type: FieldType) {
        self.type = type
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        autocapitalizationType = .none
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
        
        layer.masksToBounds = true
        placeholder = type.title
        

        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: height))
        leftViewMode = .always
        returnKeyType = .done
        autocorrectionType = .no
        if type == .password {
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        }
        else if type == .email {
            keyboardType = .emailAddress
            textContentType = .emailAddress
        }
        
        
    }
}
