//
//  extension UIApplication
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-13.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
