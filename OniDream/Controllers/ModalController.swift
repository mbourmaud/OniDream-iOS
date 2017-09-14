//
//  ModalController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-14.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import SwiftMessages

final class ModalController {
    
    enum ModalType {
        case error
        case success
        case info
        case warning
        case loader
    }
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = ModalController()
    
    public func showModal(title: String, message: String, type: ModalType = ModalType.success) {
        let modal = MessageView.viewFromNib(layout: .CardView)
        
        modal.button?.isHidden = true
        
        switch type {
        case .error:
            modal.configureTheme(.error)
        case .success:
            modal.configureTheme(.success)
        case .info:
            modal.configureTheme(.info)
        case .warning:
            modal.configureTheme(.warning)
        default:
            modal.configureTheme(.success)
        }
        
        modal.configureContent(title: title, body: message)
    
        SwiftMessages.show(view: modal)
    }
	    
}
