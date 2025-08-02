import UIKit
import SwiftData

final class MainTabBarController: UITabBarController {
    var selectedType: String? // AddPet ekranından atanır
    var modelContext: ModelContext? // Dışarıdan atanmalı

    // 📌 ÖZEL INIT — tür ve context dışarıdan alınır
    init(selectedType: String?, modelContext: ModelContext?) {
        self.selectedType = selectedType
        self.modelContext = modelContext
        super.init(nibName: nil, bundle: nil)
    }

    // Gerekli init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("📦 MainTabBarController Yüklendi")
        print("🧩 Tabbar kuruluyor — selectedType:", selectedType ?? "nil")
        
        setupTabs()
    }

    private func setupTabs() {
        // Tab bar tasarımı
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "AccentColor") ?? .systemPurple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "AccentColor") ?? .systemPurple]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        // 📌 Rutinler sekmesi
        let routineVC = PetRoutineViewController()
        routineVC.preselectedPetType = selectedType // 💡 Artık doğru geliyor
        routineVC.modelContext = modelContext
        routineVC.tabBarItem = UITabBarItem(title: "Rutinler", image: UIImage(systemName: "pawprint.fill"), tag: 0)

        let vetVC = UIViewController()
        vetVC.view.backgroundColor = .systemGroupedBackground
        vetVC.tabBarItem = UITabBarItem(title: "Veteriner", image: UIImage(systemName: "cross.case.fill"), tag: 1)

        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .systemGroupedBackground
        profileVC.tabBarItem = UITabBarItem(title: "Profil", image: UIImage(systemName: "person.crop.circle"), tag: 2)

        viewControllers = [
            UINavigationController(rootViewController: routineVC),
            UINavigationController(rootViewController: vetVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }
}
