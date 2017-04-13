//
//  SFSafariViewController+Extensions.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 3/11/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

@available(iOS 9.0, *)
extension SFSafariViewController {

    open static func open(url: URL, delegate: SFSafariViewControllerDelegate) -> SFSafariViewController {
        let svc = SFSafariViewController(url: url)
        svc.delegate = delegate
        svc.preferredBarTintColor = UIColor.molinaTeal
        return svc
    }
}
