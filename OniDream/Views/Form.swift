//
//  Form.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-14.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import SnapKit
import UIKit

class Form: UIView {
    var container: UIView = UIView()
    var inputs: [Input] = []
    var submitButton: UIButton
    
    init(inputs: [Input], submitButton: UIButton) {
        self.inputs = inputs
        self.submitButton = submitButton
        super.init(frame: CGRect.zero)
        self.addSubviews()
    }
    
    override func updateConstraints() {
        var lastInput: Input?
        
        self.container.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(Style.margin)
            make.right.equalTo(self).offset(-Style.margin)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        for input in self.inputs {
            input.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(self.container)
                make.right.equalTo(self.container)
                make.height.equalTo(Style.inputHeight)
                if (lastInput === nil) {
                    make.top.equalTo(self.container).offset(Style.margin)
                } else {
                    make.top.equalTo((lastInput?.snp.bottom)!).offset(Style.margin)
                }
                
                lastInput = input
            }
        }
        
        self.submitButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.container)
            make.right.equalTo(self.container)
            make.height.equalTo(Style.buttonHeight)
            make.top.equalTo(self.inputs[self.inputs.endIndex - 1].snp.bottom).offset(Style.margin * 2)
        }
        
        super.updateConstraints()
    }
    
    
    private func addSubviews() {
        self.addSubview(container)
        
        for input in self.inputs {
            self.container.addSubview(input)
        }
        
        self.container.addSubview(self.submitButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
