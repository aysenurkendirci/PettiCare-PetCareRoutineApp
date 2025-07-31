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
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupInitialState()
        setupInitialState()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor.primaryBackground

        let stack = UIStackView(arrangedSubviews: [
            petTypeTitleLabel,
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

    // MARK: - ViewModel Bindings
    private func setupBindings() {
        calendarView.onDateSelected = { [weak self] date in
            self?.viewModel.selectDate(date)
            self?.updateUI()
        }

        routineListView.onFrequencyTappedAtIndex = { [weak self] index, title in
            self?.presentFrequencyOptions(for: index, title: title)
        }
    }

    // MARK: - Initial State
    // MARK: - Initial State
    private func setupInitialState() {
        if let typeString = preselectedPetType ?? fetchLatestPetType(),
           let petType = PetType(rawValue: typeString) {
            petTypeSelector.setInitialType(from: petType)

            petTypeSelector.isUserInteractionEnabled = false
            viewModel.selectPetType(petType)
        } else {
            petTypeSelector.setInitialType(from: .cat)


            viewModel.selectPetType(PetType.cat)
        }
    }

    // MARK: - Fetch from SwiftData
    private func fetchLatestPetType() -> String? {
        do {
            let descriptor = FetchDescriptor<Pet>(
                sortBy: [SortDescriptor(\Pet.birthDate, order: .reverse)]
            )
            let pets: [Pet] = try modelContext?.fetch(descriptor) ?? []
            return pets.first?.type
        } catch {
            print("Fetch error: \(error)")
            return nil
        }
    }

    // MARK: - Update Routine List
    private func updateUI() {
        let routines = viewModel.getPredefinedRoutines().map { ($0.title, $0.frequency) }
        routineListView.update(with: routines)
    }

    // MARK: - Frequency Change Handler
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
