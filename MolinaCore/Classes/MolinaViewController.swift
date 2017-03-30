//
//  MolinaViewController.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 12/21/16.
//  Copyright © 2016 Molina Healthcare Inc. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Molina-themed ViewControllers

public enum ViewControllerState: String {
    case loading, normal, error
}

protocol MolinaThemedController {
    func applyTheme()
}

public protocol ViewControllerStateProtocol {
    var currentViewControllerState: ViewControllerState { get set }
    func viewControllerState(willChangeFrom currentState: ViewControllerState, to newState: ViewControllerState)
    func viewControllerState(didChangeTo currentState: ViewControllerState)
}

extension UIViewController: MolinaThemedController {
    open func applyTheme() {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.setBackgroundImage(UIImage(color: UIColor.molinaTeal), for: .default)
            navigationController.navigationBar.tintColor = UIColor.white
            navigationController.navigationBar.shadowImage = #imageLiteral(resourceName: "transparent_pixel")
            navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
            navigationController.navigationBar.isTranslucent = false
        }
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}

open class MolinaViewController: UIViewController, ViewControllerStateProtocol {
    
    open var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = statusBarStyle
        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarStyle = UIStatusBarStyle.default
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }

    open override var preferredStatusBarStyle : UIStatusBarStyle {
        return statusBarStyle
    }
    
    
    // MARK: - ViewControllerStateProtocol
    open var currentViewControllerState: ViewControllerState = ViewControllerState.normal
    
    open func set(state newState: ViewControllerState) {
        let currentState = self.currentViewControllerState
        viewControllerState(willChangeFrom: currentState, to: newState)
        self.currentViewControllerState = newState
        viewControllerState(didChangeTo: self.currentViewControllerState)
    }
    
    open func viewControllerState(didChangeTo state: ViewControllerState) {}
    
    open func viewControllerState(willChangeFrom currentState: ViewControllerState, to newState: ViewControllerState) {}
}

open class MolinaTabBarController: UITabBarController {
    open var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        extendedLayoutIncludesOpaqueBars = true
        applyTheme()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = UIStatusBarStyle.lightContent
        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarStyle = UIStatusBarStyle.default
    }

    open override var preferredStatusBarStyle : UIStatusBarStyle {
        return statusBarStyle
    }
}

open class MolinaTableViewController: UITableViewController, ViewControllerStateProtocol {
    
    open var allowsRefreshing: Bool { return false }
    open var allowsTitleLoadingText: Bool = true
    fileprivate let defaultNoInfoText: String = NSLocalizedString("common.error.noinformationavailable", comment: "Label")
    fileprivate var cachedTitle: String?
    open var noInfoLabel: UILabel!
    
    open var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure refresh control
        if allowsRefreshing && refreshControl == nil {
            refreshControl = UIRefreshControl()
//            refreshControl?.backgroundColor = UIColor.molinaTeal
//            refreshControl?.tintColor = UIColor.whiteClouds
            refreshControl?.addTarget(self, action: #selector(self.didStartRefreshing), for: UIControlEvents.valueChanged)
        }
        
        // Configure no info label
        let size: CGFloat = 22.0
        noInfoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.width, height: size + 4))
        noInfoLabel.font = UIFont.systemFont(ofSize: size)
        noInfoLabel.textColor = UIColor.lightGray
        noInfoLabel.textAlignment = NSTextAlignment.center
        noInfoLabel.text = defaultNoInfoText
        noInfoLabel.setCenterX(view.centerX)
        noInfoLabel.setCenterY(200)
        noInfoLabel.isHidden = true
        view.addSubview(noInfoLabel)
        
        applyTheme()
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        refreshControl?.removeTarget(self, action: #selector(self.didStartRefreshing), for: UIControlEvents.valueChanged)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusBarStyle = UIStatusBarStyle.lightContent
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        statusBarStyle = UIStatusBarStyle.default
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    
    // MARK: - ViewControllerStateProtocol
    open var currentViewControllerState: ViewControllerState = ViewControllerState.normal
    
    open func set(state newState: ViewControllerState) {
        let currentState = self.currentViewControllerState
        viewControllerState(willChangeFrom: currentState, to: newState)
        self.currentViewControllerState = newState
        viewControllerState(didChangeTo: newState)
    }
    
    open func viewControllerState(didChangeTo state: ViewControllerState) {
        if case ViewControllerState.error = state {
            
            noInfoLabel.text = NSLocalizedString("common.error.generic", comment: "Label")
            noInfoLabel.isHidden = false
            
        } else if case ViewControllerState.loading = state, allowsTitleLoadingText {
            
            cachedTitle = self.title
            title = NSLocalizedString("common.message.loading", comment: "Label")
            
        } else {
            
            noInfoLabel.text = defaultNoInfoText
            noInfoLabel.isHidden = tableView(tableView, numberOfRowsInSection: 0) > 0
        }
        
        if state != ViewControllerState.loading {
            refreshControl?.endRefreshing()
            if allowsTitleLoadingText {
                self.title = cachedTitle ?? self.title
            }
        }
    }
    
    open func viewControllerState(willChangeFrom currentState: ViewControllerState, to newState: ViewControllerState) {}
    
    // MARK: - RefreshControl
    
    open func didStartRefreshing() {
        refreshControl?.endRefreshing()
    }
}

//class MolinaConnectViewController: OCKConnectViewController {
//    var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.lightContent {
//        didSet {
//            setNeedsStatusBarAppearanceUpdate()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        applyTheme()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        statusBarStyle = UIStatusBarStyle.lightContent
//        navigationController?.navigationBar.barStyle = UIBarStyle.black
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        statusBarStyle = UIStatusBarStyle.default
//    }
//
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return statusBarStyle
//    }
//}

