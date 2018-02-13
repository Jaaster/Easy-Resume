//
//  AppDelegate.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRFirebaseService.shared.configure()
        
        let modelManager = ModelManager<ModelExam>()
        let models = getModels(modelManager: modelManager)
        modelManager.setValues(models: models, currentModel: models.first)
        let dataHandler = ResumeDataHandler()
        if let mainVC = window?.rootViewController as? MainVC {
            mainVC.dataHandler = dataHandler
            mainVC.modelManager = modelManager
        }
        
        return true
    }
    func getModels(modelManager: ModelManager<ModelExam>) -> [ModelExam] {
        
        var models = [ModelExam]()
        let color = UIColor.myBlue
        models.append(ModelExam(exam: Exam.menu, type: .main, title: "MAIN", color: color, parentModelExamManager: modelManager))
        models.append(ModelExam(exam: Exam.educationRecord, type: .threeBarButtons, title: "EDUCATION RECORD", color: UIColor.myBlue, buttonModels: [ModelButton(title: "EDUCATED", color: UIColor.myPink), ModelButton(title: "UN-EDUCATED", color: UIColor.myBlue), ModelButton(title: "SCHOOL", color: UIColor.myGrey)], parentModelExamManager: modelManager))
        models.append(ModelExam(exam: Exam.educationDescription, type: .description, title: "Education Description", color: UIColor.myBlue, parentModelExamManager: modelManager))
       
        let childModelManager = ModelManager<ModelExam>()
        childModelManager.setValues(models: [ModelExam(exam: Exam.name, type: .input, title: "MY NAME!", color: UIColor.myPink, parentModelExamManager: modelManager), ModelExam(exam: Exam.email, type: .input, title: "EMAIL!!!", color: UIColor.myGrey, parentModelExamManager: childModelManager)], currentModel: nil)
        
        models.append(ModelExam(exam: Exam.gender, type: .twoButtons, title: "GENDER", color: color, buttonModels: [ModelButton(title: "MALE", color: color), ModelButton(title: "FEMALE", color: UIColor.myPink)], parentModelExamManager: modelManager, childModelExamManager: childModelManager))
        
        
        
       
        
      
        return models
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        PersistantService.saveContext()
    }

  

}

