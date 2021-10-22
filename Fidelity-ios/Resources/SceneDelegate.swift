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
        guard let _ = UserDefaultsService.shared.retrieve(key: "first_login", type: String.self) else {
            let vc = OnboardViewController()
            vc.configure(
                title: "Onboarding",
                sections: [OnboardSection(image: "rectangle-white",
                                          title: "Conteúdo Informativo 1",
                                          description: "e introdutivo sobre o nosso app exposto de maneira rápida e clara"),
                           OnboardSection(image: "rectangle-white",
                                          title: "Conteúdo Informativo 2",
                                          description: "e introdutivo sobre o nosso app exposto de maneira rápida e clara")
                          ],
                handleContinue: {
                    print("continue")
                    UserDefaultsService.shared.save(data: "true", key: "first_login")
                    let window = UIApplication.shared.windows.first(where: \.isKeyWindow)
                    DispatchQueue.main.async {
                        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
                    }
                    
                })
            window.rootViewController = vc
            window.makeKeyAndVisible()
            self.window = window
            return
        }
        
        guard let date = UserDefaultsService.shared.retrieveDate(key: "token_date"),
              let cpf = KeyChainService.shared.retrieveToken(key: "cpf"),
              let password = KeyChainService.shared.retrieveToken(key: "password")
        else {
            window.rootViewController = LoginViewController()
            window.makeKeyAndVisible()
            self.window = window
            return
        }
        if date.hourAfter(n: 23) < Date() || SessionService.shared.token.isEmpty {
            SessionService.shared.logIn(cpf: cpf, password: password) { isRegistered in
                if !isRegistered {
                    DispatchQueue.main.async {
                        window.rootViewController = LoginViewController()
                    }
                    
                }
            }
        }
        window.rootViewController = MainTabBarViewController()
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
        guard let date = UserDefaultsService.shared.retrieveDate(key: "token_date"),
              let cpf = KeyChainService.shared.retrieveToken(key: "cpf"),
              let password = KeyChainService.shared.retrieveToken(key: "password")
        else {
            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            return
        }
        if date.hourAfter(n: 23) < Date() || SessionService.shared.token.isEmpty {
            SessionService.shared.logIn(cpf: cpf, password: password) { isRegistered in
                if !isRegistered {
                    window?.rootViewController = LoginViewController()
                }
            }
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

