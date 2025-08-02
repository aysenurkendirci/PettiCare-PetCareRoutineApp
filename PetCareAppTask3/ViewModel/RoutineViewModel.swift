final class RoutineViewModel {
    
    // Seçilen pet türü (tek seferlik geliyor)
    private(set) var selectedPetType: PetType = .cat

    // O türe ait hazır tanımlı rutinler
    private var routines: [Routine] = []

    // Dışarıdan pet türü ayarlama
    func selectPetType(_ type: PetType) {
        selectedPetType = type
        routines = getPredefinedRoutines(for: type)
    }

    // Rutinleri dışarıdan alma
    func getRoutines() -> [Routine] {
        return routines
    }

    // Frekans güncelleme (isteğe bağlı)
    func updateFrequency(at index: Int, to newFrequency: String) {
        guard index < routines.count else { return }
        routines[index].frequency = newFrequency
    }

    // Hazır tanımlı rutinler
    func getPredefinedRoutines(for type: PetType) -> [Routine] {
        switch type {
        case .cat:
            return [
                Routine(title: "Mama", iconName: "cat.fill", frequency: "Günde 2 kez"),
                Routine(title: "Tuvalet", iconName: "tray.fill", frequency: "Günde 1 kez"),
                Routine(title: "Oyun", iconName: "gamecontroller.fill", frequency: "Günde 1 kez")
            ]
        case .dog:
            return [
                Routine(title: "Yürüyüş", iconName: "figure.walk", frequency: "Günde 2 kez"),
                Routine(title: "Mama", iconName: "dog.fill", frequency: "Günde 2 kez"),
                Routine(title: "Tüy tarama", iconName: "scissors", frequency: "Haftada 1 kez")
            ]
        case .bird:
            return [
                Routine(title: "Tüy kontrol", iconName: "wind", frequency: "3 günde 1 kez"),
                Routine(title: "Kafes temizliği", iconName: "trash.fill", frequency: "Haftada 1 kez")
            ]
        case .fish:
            return [
                Routine(title: "Yem Verme", iconName: "drop.fill", frequency: "Günde 1 kez"),
                Routine(title: "Su Değişimi", iconName: "arrow.2.circlepath", frequency: "Haftada 1 kez")
            ]
        }
    }
}
