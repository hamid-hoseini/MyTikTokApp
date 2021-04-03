//
//  SignUpViewController.swift
//  MyTikTokApp
//
//  Created by Hamid Hoseini on 1/16/21.
//

import SafariServices
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate  {

    public var completion: (() -> Void)?
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let usernameField = AuthField(type: .username)
    private let emailField = AuthField(type: .email)
    private let passwordField = AuthField(type: .password)

    private let signUpButton = AuthButton(type: .signUp, title: nil)
    private let termsButton = AuthButton(type: .plain, title: "Terms Of Service")
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Create Account"
        addSubview()
        configreFields()
        configureButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameField.becomeFirstResponder()
    }
    
    private func addSubview() {
        view.addSubview(logoImageView)
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(termsButton)
    }
    
    private func configreFields() {
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Bar", style: .done, target: self, action: #selector(didTabKeyboardDone))
        ]
        
        toolBar.sizeToFit()
        emailField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
        usernameField.inputAccessoryView = toolBar
    }
    
    private func configureButtons() {
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let imageSize: CGFloat = 100
        logoImageView.frame = CGRect(x: (view.width - imageSize)/2,
                                     y: view.safeAreaInsets.top + 5,
                                     width: imageSize,
                                     height: imageSize)
        usernameField.frame = CGRect(x: 20, y: logoImageView.bottom + 20, width: view.width - 40, height: 55)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 20, width: view.width - 40, height: 55)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 15, width: view.width - 40, height: 55)
        
        signUpButton.frame = CGRect(x: 20, y: passwordField.bottom + 20, width: view.width - 40, height: 55)
        termsButton.frame = CGRect(x: 20, y: signUpButton.bottom + 40, width: view.width - 40, height: 55)
        
    }

    
    // Actions
    
    @objc func didTapSignUp() {
        didTabKeyboardDone()

        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
              !username.contains(" "),
              !username.contains(".") else {
            
            let alert = UIAlertController(title: "Wooops", message: "Please make sure to enter avalid username, email, and password. Your password must be atleast 6 characters long", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            
            return
        }
        
        AuthManager.shared.signUp(with: username, email: email, password: password) {
            loggedin in
            if loggedin {
                // dismiss sign in
            }
            else {
                // show error
            }
        }
    }
    
    
    @objc func didTapTerms() {
        didTabKeyboardDone()
        guard let url = URL(string: "https://www.tiktok.com/terms") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
            
    }
    
    @objc func didTabKeyboardDone() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }

}
