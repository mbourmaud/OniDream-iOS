//
//  ProfileViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-12.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import SwiftMessages
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
	var loginInput: Input?
	var passwordInput: Input?
	var loginButton: UIButton?
	var registerButton: UIButton?
	var orLabel: UILabel?
    var form: Form!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = View(frame: self.view.frame)
        
		self.showLoginForm()
        self.showRegisterButton()
        self.addSubmitEventHandler()
	}
	
    private func addSubmitEventHandler() {
        self.loginInput?.textField.delegate = self
        self.passwordInput?.textField.delegate = self
        self.loginButton?.addTarget(self, action:#selector(handleSignIn), for: .touchUpInside)
    }
    
    /* Pressing the return key will dismiss the Keyboard */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func handleSignIn(_ sender: UIButton) {
        let login = self.loginInput?.textField.text
        let password = self.passwordInput?.textField.text

        if ((login?.isEmpty)! || (password?.isEmpty)!) {
            ModalController.shared.showModal(title: "Error", message: "Please enter your login and your password", type: .error)
            /*ModalController.shared.showModal(title: "Error", message: "Please enter your login and your password")
            ModalController.shared.showModal(title: "Error", message: "Please enter your login and your password", type: .error)
            ModalController.shared.showModal(title: "Error", message: "Please enter your login and your password", type: .info)
            ModalController.shared.showModal(title: "Error", message: "Please enter your login and your password", type: .warning)*/

        }
        
        print("Login: \(login) | Password: \(password)")
    }
    
	func handleRegisterClick(_ sender: UIButton) {
		self.navigationController?.pushViewController(RegisterViewController(), animated: true)
	}
    
    /*private func showErrorMessage(title:String, message: String) {
        let error = MessageView.viewFromNib(layout: .CardView)
        error.configureTheme(.error)
        error.configureContent(title: title, body: message)

        SwiftMessages.show(view: error)
    }*/
    
    private func showRegisterButton() {
        self.registerButton = Button(label: "Sign up", borderColor: Color.purple, textColor: Color.white, backColor: Color.purple)
        self.orLabel = UILabel()
        self.orLabel?.text = "OR"

        self.registerButton?.addTarget(self, action:#selector(handleRegisterClick), for: .touchUpInside)

        self.orLabel?.textColor = Color.white
        self.orLabel?.font = Style.titleFont
        self.orLabel?.textAlignment = NSTextAlignment.center
        
        self.view.addSubview(self.orLabel!)
        self.view.addSubview(self.registerButton!)
        
        self.orLabel?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(Style.margin)
            make.right.equalTo(self.view).offset(-Style.margin)
            make.top.equalTo((self.form.snp.bottom)).offset(Style.margin)
            make.height.equalTo(50)
        }
        
        self.registerButton?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(Style.margin)
            make.right.equalTo(self.view).offset(-Style.margin)
            make.top.equalTo((orLabel?.snp.bottom)!).offset(Style.margin)
            make.height.equalTo(50)
        }
    }
	
	private func showLoginForm() {
		self.loginInput = Input(label: "Login", placeholder: "Please enter your login")
		self.passwordInput = Input(label: "Password", placeholder: "Please type in your password", isSecure: true)
		self.loginButton = Button(label: "Sign in")
        
        self.form = Form(inputs: [
        loginInput!,
        passwordInput!,
        ], submitButton: loginButton!)
        
        self.view.addSubview(form)
        
        form.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(
                Style.buttonHeight +
                    Style.inputHeight * CGFloat(form.inputs.count) +
                    Style.margin * (CGFloat(form.inputs.count) + 2)
            )
            make.top.equalTo(self.view).offset(Style.topOffset)
        }
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
