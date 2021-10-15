//
//  SceneDelegate.swift
//  Fidelity-ios
//
//  Created by Matheus Homrich on 08/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        SessionService.shared.logIn(username: "04223086090", password: "pedroadmin", handler: { _ in })
        guard let date = UserDefaultsService.shared.retrieveDate(key: "token_date") else {
            window.rootViewController = LoginViewController()
            window.makeKeyAndVisible()
            self.window = window
            return
        }
        if date.hourAfter(n: 23) < Date() || SessionService.shared.token.isEmpty {
           window.rootViewController = LoginViewController()
        }
        window.rootViewController = UserStoresViewController()
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
        guard let date = UserDefaultsService.shared.retrieveDate(key: "token_date") else {
            window?.rootViewController = LoginViewController()
            return
        }
        if date.hourAfter(n: 23) < Date() || SessionService.shared.token.isEmpty {
           window?.rootViewController = LoginViewController()
        }
        window?.rootViewController = MainTabBarViewController()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

