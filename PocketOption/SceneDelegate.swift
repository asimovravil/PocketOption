//
//  SceneDelegate.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        window.rootViewController =
        UINavigationController(rootViewController: ArticlesViewController())
        window.makeKeyAndVisible()
        self.window = window
    }


}

