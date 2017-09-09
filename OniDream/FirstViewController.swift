//
//  FirstViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.view.backgroundColor = Color.red
		
		let label = UILabel()
		label.text = "Lorem Ipsum blablzldadzdiuzahdhduazidazhdihazdidazd"
		
		let card = Card(title: "Test", content: label)
		let card2 = Card(title: "Test2", rightInfo: "Yes Baby", content: label)

		self.view.addSubview(card)
		self.view.addSubview(card2)
		card.pin.left().right().top().height(100).margin(Style.margin)
		card2.pin.below(of: card).right().bottom().left().margin(Style.margin)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

