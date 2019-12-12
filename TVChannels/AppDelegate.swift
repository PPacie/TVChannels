//
//  AppDelegate.swift
//  TVChannels
//
//  Created by Pablo Paciello on 18/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import UIKit
import PresentationLayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
        //Initialize MainScreen
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = UIStoryboard(name: Constants.Storyboards.main.rawValue.capitalized, bundle: nil).instantiateInitialViewController { coder in
            return MainViewController(coder: coder, viewModel: MainScreenViewModel(), transitionAnimator: MainTransitionAnimator())
        }
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return true
    }
}

