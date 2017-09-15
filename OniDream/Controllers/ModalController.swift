//
//  ModalController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-14.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import SwiftMessages
import SwiftIcons

final class ModalController {
    
    enum ModalType {
        case error
        case success
        case info
        case warning
        case loader
    }
	
	let SwiftMessagesType: [ModalType: Theme] = [
		ModalType.error: Theme.error,
		ModalType.success: Theme.success,
		ModalType.info: Theme.info,
		ModalType.warning: Theme.warning
	]
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = ModalController()
    
	public func showModal(title: String, message: String, type: ModalType = ModalType.success) {
		if (type == .success
			|| type == .warning
			|| type == .error
			|| type == .info) {
			self.showMessageModal(title: title, message: message, type: type)
		} else if (type == .loader) {
			self.showLoaderModal(title: title, message: message)
		}
	}
	
	private func showLoaderModal(title:String, message: String) {
		let modal = MessageView.viewFromNib(layout: .CardView)
		modal.configureDropShadow()

		modal.configureTheme(backgroundColor: Color.purple, foregroundColor: Color.white)
		modal.button?.setImage(Icon.ErrorSubtle.image, for: .normal)
		modal.button?.setTitle(nil, for: .normal)
		modal.button?.backgroundColor = UIColor.clear
		modal.button?.tintColor = UIColor.green.withAlphaComponent(0.7)
		
		modal.button?.isHidden = true
		
		// Config Setup
		var config = SwiftMessages.defaultConfig
		
		config.presentationStyle = .center
		config.duration = .seconds(seconds: 3)
		config.dimMode = .blur(style: .dark, alpha: 1.0, interactive: true)

		modal.configureDropShadow()
		modal.configureContent(title: title, body: message, iconImage: UIImage.init(icon: .fontAwesome(.spinner), size: CGSize(width: 50, height: 50), textColor: Color.white))
		
		SwiftMessages.show(config: config, view: modal)
	}
	
	private func showMessageModal(title: String, message: String, type: ModalType) {
		let modal = MessageView.viewFromNib(layout: .CardView)
		modal.configureDropShadow()
		modal.configureTheme(self.SwiftMessagesType[type]!)
		modal.button?.isHidden = true
		
		// Config Setup
		var config = SwiftMessages.defaultConfig
		
		config.presentationStyle = .bottom
		config.duration = .seconds(seconds: 3)
		
		modal.configureContent(title: title, body: message)

		SwiftMessages.show(config: config, view: modal)
	}
	
}
