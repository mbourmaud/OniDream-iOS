//
//  DreamViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class DreamController: UIViewController, UITextViewDelegate {
	var dream: Dream!
	var form: DreamForm!
	var contentTextView: TextView = TextView(label: "Content", placeholder: "Start typing what you remember from your dream... 🌔")
	var titleInput: Input = Input(label: "Login", placeholder: "Give a name to your dream 🌙")
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = View(frame: self.view.frame)
		self.contentTextView.textView.delegate = self

        // Do any additional setup after loading the view.
		self.drawNavigationBar()
		
		titleInput.textField.addTarget(self, action: #selector(self.titleChanged(sender:)), for: .editingChanged)

		self.showDreamForm()
		
		/* If the content or the title is empty, the save button should be disabled */
		self.checkDreamValidity()
    }
	
	private func showDreamForm() {
		let form: DreamForm = DreamForm(input: self.titleInput, textView: contentTextView)
		
		self.view.addSubview(form)
		
		form.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view)
			make.right.equalTo(self.view)
			make.height.equalTo(self.view)
			make.top.equalTo(self.view).offset(Style.topOffset)
		}
	}

	private func drawNavigationBar() {
		if (!self.dream.title.isEmpty) {
			self.title = self.dream.title
		}
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
	}
	
	/* We detect changes in the UITextView that contains the content of the dream */
	func textViewDidChange(_ textView: UITextView) {
		self.checkDreamValidity()
	}
	
	/* We detect changes in the UITextField that contains the title of the dream */
	func titleChanged(sender: UITextField) {
		self.title = sender.text
		self.checkDreamValidity()
	}
	
	
	func cancelTapped(_ sender: UIBarButtonItem) {
		self.navigationController?.popViewController(animated: true)
	}
	
	func saveTapped(_ sender: UIBarButtonItem) {
		self.dream = Dream(title: self.titleInput.textField.text!, content: self.contentTextView.textView.text!, date: Date())
		performSegue(withIdentifier: Identifier.unwindToDreams, sender: self)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func textViewDidBeginEditing (_ textView: UITextView) {
		self.checkDreamValidity()
		self.contentTextView.becomeFirstResponder()
	}
	
	
	func textViewDidEndEditing(_ textView: UITextView) {
		self.checkDreamValidity()
		self.contentTextView.resignFirstResponder()
	}
	
	/* Just checking the validity of the title and the content to enable/disable the Save button in consequence */
	func checkDreamValidity() {
		let content = self.contentTextView.textView.text ?? ""
		let title = self.titleInput.textField.text ?? ""
		
		if content.isEmpty || title.isEmpty {
			self.navigationItem.rightBarButtonItem?.isEnabled = false
			return
		}
		self.navigationItem.rightBarButtonItem?.isEnabled = true
		return
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == Identifier.unwindToDreams {
			let title = self.titleInput.textField.text
			let content = self.contentTextView.textView.text
			
			dream = Dream(title: title!, content: content!, date: Date());
		}
    }

}
