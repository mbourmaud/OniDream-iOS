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
		
		self.view.addSubview(self.loginInput!)
		self.view.addSubview(self.passwordInput!)
		self.view.addSubview(self.confirmPasswordInput!)
		self.view.addSubview(self.registerButton!)
		
		self.loginInput?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo(self.view).offset(Style.margin*10)
			make.height.equalTo(90)
		}
		
		self.passwordInput?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo((loginInput?.snp.bottom)!).offset(Style.margin)
			make.height.equalTo(90)
		}
		
		self.confirmPasswordInput?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo((passwordInput?.snp.bottom)!).offset(Style.margin)
			make.height.equalTo(90)
		}
		
		self.registerButton?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo((confirmPasswordInput?.snp.bottom)!).offset(Style.margin * 2)
			make.height.equalTo(50)
		}
	}

	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
