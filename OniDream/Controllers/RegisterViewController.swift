//
//  RegisterViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-12.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
	var loginInput: Input?
	var passwordInput: Input?
	var confirmPasswordInput: Input?
	var registerButton: UIButton?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        self.view = View(frame: self.view.frame)
		self.showRegisterForm()
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
