//
//  AppDelegate.swift
//  Mazaady Task
//
//  Created by Diaa saeed on 10/04/2025.
//

import UIKit
import MOLH
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var lang = ""
    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MOLH.shared.activate(true)
        loadSelectedLanguage()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
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

    func loadSelectedLanguage() {
        let userDefaults = UserDefaults.standard
        let languageKey = "selectedLanguage"
        if let savedData = userDefaults.data(forKey: languageKey) {
            let decoder = JSONDecoder()
            if let loadedLanguage = try? decoder.decode(Language.self, from: savedData) {
                print("SSS",loadedLanguage.code)
                AppDelegate.lang = loadedLanguage.code
                MOLH.setLanguageTo(loadedLanguage.code)
            }
        }
    }
}

