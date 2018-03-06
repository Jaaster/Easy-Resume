//
//  AppDelegate.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        
        let mainVC = InformationVC()
//        let tabBarController = UITabBarController()

        let navigationController = CustomNavigationController(rootViewController: mainVC)
        
//        tabBarController.viewControllers = [navigationController]
//        navigationController.tabBarController!.tabBar.items = [UITabBarItem(title: "User Settings", image: nil, tag: 0),   UITabBarItem(title: "Resumes", image: nil, tag: 1), UITabBarItem(title: "Jobs", image: nil, tag: 2)]

        let generator = ModelExamDefaultsGenerator()
        navigationController.modelManager = generator.generateModelManagerWithModels()
            
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}
