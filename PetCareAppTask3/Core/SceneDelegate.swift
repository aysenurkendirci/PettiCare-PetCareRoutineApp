import UIKit
import SwiftData


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // 🔧 Navigation controller ile başlatıyoruz
        let splashVC = SplashViewController()
        let navController = UINavigationController(rootViewController: splashVC)
        
        let container = try! ModelContainer(for: Pet.self)
        let context = container.mainContext
        splashVC.modelContext = context //

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController // ✅ navigation destekler hale geldi
        self.window = window
        window.makeKeyAndVisible()
    }
}
