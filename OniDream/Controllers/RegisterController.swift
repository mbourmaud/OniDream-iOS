//
//  RegisterViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-12.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController, UITextFieldDelegate {
	var loginInput: Input?
	var passwordInput: Input?
	var confirmPasswordInput: Input?
	var registerButton: UIButton?
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        self.view = View(frame: self.view.frame)
		self.showRegisterForm()
        self.addSubmitEventHandler()
	}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    private func addSubmitEventHandler() {
        self.loginInput?.textField.delegate = self
        self.passwordInput?.textField.delegate = self
        self.confirmPasswordInput?.textField.delegate = self
        self.registerButton?.addTarget(self, action:#selector(handleSignUp), for: .touchUpInside)
    }
    
    func handleSignUp(_ sender: UIButton) {
        let email = self.loginInput?.textField.text
        let password = self.passwordInput?.textField.text
        let confirmPassword = self.confirmPasswordInput?.textField.text
        
        if ((email?.isEmpty)! || (password?.isEmpty)! || (confirmPassword?.isEmpty)!) {
            ModalController.shared.showModal(title: "Error", message: "Please fill each field", type: .error)
            return
        }
        if (password != confirmPassword) {
            ModalController.shared.showModal(title: "Error", message: "Passwords are different", type: .error)
            return
        }
        UserService.shared.signup(email: email!, password: password!, auth: Auth.auth(), completion: { (user, error) in
            if error == nil {
                ModalController.shared.showModal(title: "Success", message: "You are now signed up", type: .success)
            } else {
                let errorMessage = error?.localizedDescription
                ModalController.shared.showModal(title: "Error", message: errorMessage!, type: .error)
            }
        })
    }
	
	private func showRegisterForm() {
		self.loginInput = Input(label: "Login", placeholder: "Please enter a login")
		self.passwordInput = Input(label: "Password", placeholder: "Please type in a password", isSecure: true)
		self.confirmPasswordInput = Input(label: "Confirm Password", placeholder: "Please confirm your password", isSecure: true)
		self.registerButton = Button(label: "Sign up")
		
        let form: Form = Form(inputs: [
            self.loginInput!,
            self.passwordInput!,
            self.confirmPasswordInput!,
        ], submitButton: self.registerButton!)
        
        self.view.addSubview(form)
        
        form.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(
                Style.buttonHeight +
                Style.inputHeight * CGFloat(form.inputs.count) +
                Style.margin * CGFloat(form.inputs.count)
            )
            make.top.equalTo(self.view).offset(Style.topOffset)
        }
	}
}
