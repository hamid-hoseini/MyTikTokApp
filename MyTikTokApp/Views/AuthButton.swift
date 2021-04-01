//
//  AuthButton.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 3/29/21.
//

import UIKit

class AuthButton: UIButton {

    enum buttonType {
        case signIn
        case signUp
        case plain
        
        var title: String {
            switch self {
            case .signIn: return "Sign In"
            case .signUp: return "Sign Up"
            case .plain: return "-"
            }
        }
    }
    
    let type: buttonType
    
    init(type: buttonType, title: String?) {
        self.type = type
        super.init(frame: .zero)
        if let title = title {
            setTitle(title, for: .normal)
        }
        configreUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configreUI() {
        if type != .plain {
            setTitle(type.title, for: .normal)
        }
        setTitleColor(.white, for: .normal)
        switch type {
        case .signIn:
            backgroundColor = .systemBlue
        case .signUp:
            backgroundColor = .systemGreen
        case .plain:
            backgroundColor = .clear
            setTitleColor(.link, for: .normal)
        }
        titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}
