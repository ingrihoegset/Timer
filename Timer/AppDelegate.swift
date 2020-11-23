//
//  AppDelegate.swift
//  Timer
//
//  Created by Ingrid on 16/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor(named: Constants.white)
        navigationBarAppearace.barTintColor = UIColor(named: Constants.main)
        navigationBarAppearace.isTranslucent = false
        navigationBarAppearace.shadowImage = UIImage()
        
        let tabBarApperance = UITabBar.appearance()
        tabBarApperance.barTintColor = UIColor(named: Constants.accentDark)
        tabBarApperance.isTranslucent = false
        preloadData()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Timer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func preloadData() {
        
        let preloadedDataKey = "didPreloadData"
        
        let userDefaults = UserDefaults.standard
        
        //Preload if never loaded before
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            
            let backgroundContext = persistentContainer.newBackgroundContext()
            
            backgroundContext.perform {
                
                do {
                    let reactionRace = Category(context: backgroundContext)
                    let lapsRace = Category(context: backgroundContext)
                    let speedRace = Category(context: backgroundContext)
                    
                    speedRace.name = Constants.speedRun
                    speedRace.type = "Speed"
                    speedRace.isFavorite = false
                    speedRace.laps = 1
                    speedRace.lapLength = 60
                    speedRace.delayBeforeStart = 10
                    speedRace.reactionTime = 10

                    lapsRace.name = Constants.Intervals
                    lapsRace.type = "Laps"
                    lapsRace.isFavorite = false
                    lapsRace.laps = 2
                    lapsRace.lapLength = 60
                    lapsRace.delayBeforeStart = 10
                    lapsRace.reactionTime = 10
                    
                    reactionRace.name = Constants.reactionRun
                    reactionRace.type = "Reaction"
                    reactionRace.isFavorite = false
                    reactionRace.laps = 1
                    reactionRace.lapLength = 30
                    reactionRace.delayBeforeStart = 10
                    reactionRace.reactionTime = 10
                    
                    try backgroundContext.save()
                        userDefaults.set(true, forKey: preloadedDataKey)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

