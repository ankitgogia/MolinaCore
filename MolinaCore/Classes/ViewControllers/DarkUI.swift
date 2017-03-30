//
//  DarkMode.swift
//  TM3 Configurator
//
//  Created by Jaren Hamblin on 7/7/16.
//  Copyright © 2016 JariousApps. All rights reserved.
//

import Foundation
import UIKit

struct DarkUI {
    static let darkModeBackgroundColor = UIColor(hexString: "#171717")
    static let darkModeTintColor = UIColor(hexString: "#1b1b1b")
}

extension UIColor {
    class func darkModeBackgroundColor() -> UIColor { return DarkUI.darkModeBackgroundColor }
    class func darkModeTintColor() -> UIColor { return DarkUI.darkModeTintColor }
}

class DarkUITableViewController: UITableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.backgroundColor = UIColor.darkModeBackgroundColor()
        tableView.backgroundView?.backgroundColor = UIColor.darkModeBackgroundColor()
        tableView.backgroundColor = UIColor.darkModeBackgroundColor()
        tableView.separatorColor = UIColor.darkText
        tableView.tableHeaderView?.backgroundColor = UIColor.whiteClouds
    }
}

class DarkUIViewController: UIViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.backgroundColor = UIColor.darkModeBackgroundColor()
    }
}

class DarkUITabBarController: UITabBarController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.darkModeTintColor()
    }
}

class DarkUITabBar: UITabBar {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isTranslucent = false
        barTintColor = UIColor.darkModeTintColor()
    }
}

class DarkUITabBarItem: UITabBarItem {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class DarkUITableView: UITableView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundView?.backgroundColor = UIColor.darkModeBackgroundColor()
        backgroundColor = UIColor.darkModeBackgroundColor()
        separatorColor = UIColor.darkText
        tableHeaderView?.backgroundColor = UIColor.whiteClouds
        configureHeaderViews()
    }

    override func reloadData() {
        super.reloadData()
        configureHeaderViews()
    }

    func postConfigureDarkMode() {
        configureHeaderViews()
        configureSeparator()
    }

    fileprivate func configureSeparator() {
        separatorColor = UIColor.darkGray
    }

    fileprivate func configureHeaderViews() {
        var i = 0
        var headerView = self.headerView(forSection: i)
        while headerView != nil {
            headerView?.textLabel?.textColor = UIColor.whiteClouds
            headerView?.detailTextLabel?.textColor = UIColor.whiteClouds
            i+=1
            headerView = self.headerView(forSection: i)
        }
    }
}

class DarkUINavigationController: UINavigationController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationBar.isTranslucent = true
        navigationBar.barStyle = UIBarStyle.black
        navigationBar.backgroundColor = UIColor.darkModeTintColor()
    }
}

class DarkUINavigationBar: UINavigationBar {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isTranslucent = true
        barStyle = UIBarStyle.black
        backgroundColor = UIColor.darkModeTintColor()
    }
}

class DarkUITableViewCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textLabel?.textColor = UIColor.white
        textLabel?.backgroundColor = UIColor.clear
        backgroundColor = UIColor.darkModeTintColor()
        contentView.backgroundColor = UIColor.darkModeTintColor()
    }
}
