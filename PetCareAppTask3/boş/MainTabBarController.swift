import UIKit
import SwiftData

final class MainTabBarController: UITabBarController {
    var selectedType: String? // 💡 AddPet ekranından atanacak
    var modelContext: ModelContext? // 💡 dışarıdan atanmalı

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs() //aşağıdaik fonks kuruyoruz
    }

    private func setupTabs() {
        // Tab görünümü ayarları
   

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // Seçili item görünümü
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "AccentColor") ?? .systemPurple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "AccentColor") ?? .systemPurple]

        // Seçili olmayan item görünümü
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]

        // Uygula
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        let routineVC = PetRoutineViewController()
        routineVC.preselectedPetType = selectedType
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
