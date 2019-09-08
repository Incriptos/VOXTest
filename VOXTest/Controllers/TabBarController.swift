//
//  TabBarController.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit


final class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let mainViewController: MainViewController = MainViewController.loadFromStoryboard()
    let historyViewController: HistoryViewController = HistoryViewController.loadFromStoryboard()
    
    viewControllers = [generateNavigationController(rootViewController: mainViewController,
                                                    title: "Main", image: #imageLiteral(resourceName: "image")),
    generateNavigationController(rootViewController: historyViewController, title: "History", image: #imageLiteral(resourceName: "history"))]
  }
  
  private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
    let navigationVC = UINavigationController(rootViewController: rootViewController)
    navigationVC.tabBarItem.title = title
    navigationVC.tabBarItem.image = image
    return navigationVC
  }
  
}
