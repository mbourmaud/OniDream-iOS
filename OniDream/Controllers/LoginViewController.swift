//
//  ProfileViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-12.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class LoginViewController: UITabBarController {

	let loginTextField: UITextField = UITextField()
	let passwordTextField: UITextField = UITextField()
	var loginCard: Input?
	var passwordCard: Input?
	var loginButton: UIButton?
	var registerButton: UIButton?
	var orLabel: UILabel?
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.setViewBackgroundGradient(sender: self, Color.purple, Color.blue)
		self.showLoginForm()
	}
	
	private func showLoginForm() {
		self.loginCard = Input(label: "Login", placeholder: "Please enter your login")
		self.passwordCard = Input(label: "Password", placeholder: "Please type in your password", isSecure: true)
		self.loginButton = Button(label: "Sign in")
		self.registerButton = Button(label: "Sign up", borderColor: Color.white, textColor: Color.purple, backColor: Color.white)
		self.orLabel = UILabel()
		self.orLabel?.text = "OR"
		
		self.view.addSubview(self.loginCard!)
		self.view.addSubview(self.passwordCard!)
		self.view.addSubview(self.loginButton!)
		self.view.addSubview(self.orLabel!)
		self.view.addSubview(self.registerButton!)
		
		self.orLabel?.textColor = Color.white
		self.orLabel?.font = Style.titleFont
		self.orLabel?.textAlignment = NSTextAlignment.center
		
		self.loginCard?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo(self.view).offset(Style.margin)
			make.height.equalTo(80)
		}
		
		self.passwordCard?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo((loginCard?.snp.bottom)!).offset(Style.margin)
			make.height.equalTo(100)
		}
		
		self.loginButton?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo((passwordCard?.snp.bottom)!).offset(Style.margin)
			make.height.equalTo(50)
		}
		
		self.orLabel?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo((loginButton?.snp.bottom)!).offset(Style.margin)
			make.height.equalTo(50)
		}
		
		self.registerButton?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo((orLabel?.snp.bottom)!).offset(Style.margin)
			make.height.equalTo(50)
		}
	}
	
	private func showDivider() {
		
	}
	
	private func showRegistrationForm() {
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
