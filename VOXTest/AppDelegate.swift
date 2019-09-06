//
//  AppDelegate.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = TabBarController()
    
    return true
  }
  
//  func applicationDidEnterBackground(_ application: UIApplication) {
//    ///Clear CoreData
//    let persistenceManager = PersistenceManager.shared
//    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: ""))
//    do {
//      try persistenceManager.context.execute(DelAllReqVar)
//    }
//    catch {
//      print(error)
//    }
//  }

  
}

