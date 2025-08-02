import UIKit
import SwiftData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let splashVC = SplashViewController()
        let nav = UINavigationController(rootViewController: splashVC)

        do {
            let container = try ModelContainer(for: Pet.self)
            splashVC.modelContext = container.mainContext
        } catch {
            print("❌ SwiftData Container kurulamadı: \(error)")
        }

        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light

        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
    }
}
