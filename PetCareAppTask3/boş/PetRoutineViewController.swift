import UIKit
import SwiftData

final class PetRoutineViewController: UIViewController {
    var preselectedPetType: String?
    var modelContext: ModelContext?

    private let petTypeSelector = PetTypeSelectorView()
    private let calendarView = PetCalendarView()
    private let routineListView = RoutineListView()
    private let viewModel = RoutineViewModel()

    private let petTypeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("🧩 gelen preselectedPetType:", preselectedPetType ?? "nil")
        setupUI()
        setupBindings()
        setupInitialState()
        updateUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.primaryBackground

        let stack = UIStackView(arrangedSubviews: [
            petTypeTitleLabel,
            petTypeSelector,
            calendarView,
            routineListView
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func setupBindings() {
        calendarView.onDateSelected = { [weak self] date in
            self?.updateUI()
        }

        routineListView.onFrequencyTappedAtIndex = { [weak self] index, title in
            self?.presentFrequencyOptions(for: index, title: title)
        }
    }

    private func setupInitialState() {
        if let typeString = preselectedPetType,
           let petType = PetType(displayName: typeString) {

            print("✅ eşleşti:", petType.rawValue)
            viewModel.selectPetType(petType)
            petTypeSelector.setInitialType(from: petType)
            petTypeSelector.isUserInteractionEnabled = false
            petTypeTitleLabel.text = "\(petType.displayName) Rutinleri"
        } else if let fallbackType = fetchLatestPetTypeAsEnum() {
            print("ℹ️ fallback:", fallbackType.rawValue)
            viewModel.selectPetType(fallbackType)
            petTypeSelector.setInitialType(from: fallbackType)
            petTypeTitleLabel.text = "\(fallbackType.displayName) Rutinleri"
        } else {
            print("❌ varsayılan: cat")
            viewModel.selectPetType(.cat)
            petTypeSelector.setInitialType(from: .cat)
            petTypeTitleLabel.text = "Kedi Rutinleri"
        }
    }

    private func fetchLatestPetTypeAsEnum() -> PetType? {
        do {
            let descriptor = FetchDescriptor<Pet>(
                sortBy: [SortDescriptor(\Pet.birthDate, order: .reverse)]
            )
            let pets: [Pet] = try modelContext?.fetch(descriptor) ?? []
            return pets.first.flatMap { PetType(rawValue: $0.type) }
        } catch {
            print("❌ Fetch error: \(error)")
            return nil
        }
    }

    private func updateUI() {
        let routines = viewModel.getPredefinedRoutines(for: viewModel.selectedPetType).map { ($0.title, $0.frequency) }

        routineListView.update(with: routines)
    }

    private func presentFrequencyOptions(for index: Int, title: String) {
        let alert = UIAlertController(title: "\(title) sıklığını değiştir", message: nil, preferredStyle: .actionSheet)

        let options = ["Günde 1 kez", "Günde 2 kez", "Haftada 1 kez", "Ayda 1 kez"]

        for option in options {
            alert.addAction(UIAlertAction(title: option, style: .default, handler: { [weak self] _ in
                self?.viewModel.updateFrequency(at: index, to: option)
                self?.routineListView.updateFrequency(at: index, to: option)
            }))
        }

        alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}
