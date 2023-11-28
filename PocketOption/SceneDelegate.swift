//
//  SceneDelegate.swift
//  PocketOption
//
//  Created by Ravil on 27.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var navigation: UINavigationController!
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = ProgressBurgerViewController()
        window?.makeKeyAndVisible()
    
        HamburgerSetup.shared.request { [weak self] url in
            if let url = url {
                self?.window?.rootViewController = BigMacViewController(url: url)
            } else {
                if !AppStoreKelLok.isOnboardingShowed {
                    self?.navigation = UINavigationController(
                        rootViewController: FAQViewController()
                    )
                }
                self?.window?.rootViewController = self?.navigation
            }
        }
    }
}
