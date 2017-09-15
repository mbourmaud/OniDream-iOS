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
	var contentTextField: UITextView = UITextView()
	var titleTextField: UITextField = UITextField()
	let contentPlaceHolder: String = "Start typing what you remember from your dream... 🌔"
	let titlePlaceHolder: String  = "Give a name to your dream 🌙"
	
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = View(frame: self.view.frame)
        
        // Do any additional setup after loading the view.
		self.drawNavigationBar()
		self.buildLayout()
        self.styleContentTextField()
		self.styleTitleTextField()
		
		titleTextField.addTarget(self, action: #selector(self.titleChanged(sender:)), for: .editingChanged)

		/* If the content or the title is empty, the save button should be disabled */
		self.checkDreamValidity()
    }
	
	private func buildLayout() {
		let dreamTitleCard: Card = Card(title: "Title", content: self.titleTextField)
		let dreamContentCard: Card = Card(title: "Content", content: self.contentTextField)
		
		self.view.addSubview(dreamTitleCard)
		self.view.addSubview(dreamContentCard)
		
		dreamTitleCard.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo(self.view).offset(Style.margin*10)
			make.height.equalTo(100)
		}
		
		dreamContentCard.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.top.equalTo(dreamTitleCard.snp.bottom).offset(Style.margin)
			make.bottom.equalTo(self.view).offset(-Style.margin)
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
		self.dream = Dream(title: self.titleTextField.text!, content: self.contentTextField.text!, date: Date())
		performSegue(withIdentifier: Identifier.unwindToDreams, sender: self)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func textViewDidBeginEditing (_ textView: UITextView) {
		if (self.contentTextField.text == self.contentPlaceHolder) {
			
			self.contentTextField.text = ""
			self.contentTextField.textColor = Color.textColor
			self.contentTextField.font = Style.textFont
		}
		
		self.checkDreamValidity()
		self.contentTextField.becomeFirstResponder()
	}
	
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if (self.contentTextField.text == "") {
			self.contentTextField.text = self.contentPlaceHolder
			self.contentTextField.textColor = Color.placeholderColor
			self.contentTextField.font = Style.placeholderFont
		}
		
		self.checkDreamValidity()
		self.contentTextField.resignFirstResponder()
	}
	
	/* Just checking the validity of the title and the content to enable/disable the Save button in consequence */
	func checkDreamValidity() {
		let content = self.contentTextField.text ?? ""
		let title = self.titleTextField.text ?? ""
		
		if content.isEmpty || title.isEmpty || content == self.contentPlaceHolder {
			self.navigationItem.rightBarButtonItem?.isEnabled = false
			return
		}
		self.navigationItem.rightBarButtonItem?.isEnabled = true
		return
	}
	
	private func styleContentTextField() {
		self.contentTextField.font = Style.textFont
		self.contentTextField.textColor = Color.textColor
		self.contentTextField.textContainerInset = UIEdgeInsets.zero
		self.contentTextField.text = self.dream.content
		self.contentTextField.textContainer.lineFragmentPadding = 0; // to remove left padding
		
		self.contentTextField.delegate = self
		
		if (self.contentTextField.text == "") {
			self.contentTextField.text = self.contentPlaceHolder
			self.contentTextField.textColor = Color.placeholderColor
			self.contentTextField.font = Style.placeholderFont
		}
	}
	
	private func styleTitleTextField() {
		self.titleTextField.text = self.dream.title
		self.titleTextField.font = Style.textFont
		self.titleTextField.textColor = Color.textColor
		self.titleTextField.becomeFirstResponder()
		self.titleTextField.attributedPlaceholder = NSAttributedString(string: self.titlePlaceHolder,
		                                                               attributes: [NSForegroundColorAttributeName: Color.placeholderColor,
		                                                                            NSFontAttributeName: Style.placeholderFont])
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		if self.navigationItem.rightBarButtonItem === sender as AnyObject? {
			print("SAVE BUTTON PRESSED")
			let title = self.titleTextField.text
			let content = self.contentTextField.text
			
			dream = Dream(title: title!, content: content!, date: Date());
			
			print("Dream: \(dream.title), \(dream.content)")
		}
    }

}
