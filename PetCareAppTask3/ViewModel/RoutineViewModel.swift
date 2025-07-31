import Foundation

final class RoutineViewModel {

    // MARK: - Properties
    private(set) var selectedPetType: PetType = .cat
    private(set) var selectedDate: Date = Date()
    private var allRoutines: [DailyRoutine] = []

    // MARK: - Selection Actions
    func selectPetType(_ type: PetType) {
        selectedPetType = type
    }

    func selectDate(_ date: Date) {
        selectedDate = date
    }

    func addRoutine(_ routine: Routine) {
        if let index = allRoutines.firstIndex(where: { $0.date == selectedDate && $0.petType == selectedPetType }) {
            allRoutines[index].routines.append(routine)
        } else {
            let newRoutine = DailyRoutine(date: selectedDate, petType: selectedPetType, routines: [routine])
            allRoutines.append(newRoutine)
        }
    }
    func getPredefinedRoutines() -> [Routine] {
        switch selectedPetType {
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
                Routine(title: "Genel kontrol", iconName: "staroflife.fill", frequency: "Ayda 1 kez")
            ]
        }
    }
    
    
    func updateFrequency(at index: Int, to newFrequency: String) {
        var routines = getPredefinedRoutines()
        guard index < routines.count else { return }
        routines[index].frequency = newFrequency
        // Bunu localde tutmadığın için, bu fonksiyon sadece örnek olarak yeniden render edilmesini sağlıyor.
    }


    // MARK: - Daily Summary
    func getRoutinesForSelectedDate() -> [Routine] {
        if let match = allRoutines.first(where: { $0.date == selectedDate && $0.petType == selectedPetType }) {
            return match.routines
        }
        return []
    }
}
