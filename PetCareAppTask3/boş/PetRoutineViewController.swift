import UIKit
import Foundation


final class PetRoutineViewController: UIViewController {

    private let viewModel = RoutineViewModel()

    private let petTypeSelector = PetTypeSelectorView()
    private let routineListView = RoutineListView()
    private let calendarView = PetCalendarView()
    private let summaryView = DailyRoutineSummaryView()

    private let scrollView = UIScrollView()
    private let contentView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Routines"
        view.backgroundColor = UIColor.systemGroupedBackground

        setupLayout()
        setupCallbacks()
        updateRoutines()
        updateSummary()
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.axis = .vertical
        contentView.spacing = 24
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])

        // Add views to the stack
        contentView.addArrangedSubview(petTypeSelector)
        contentView.addArrangedSubview(routineListView)
        contentView.addArrangedSubview(calendarView)
        contentView.addArrangedSubview(summaryView)
    }

    private func setupCallbacks() {
        petTypeSelector.onSelectionChanged = { [weak self] selected in
            self?.viewModel.selectPetType(PetType(rawValue: selected) ?? <#default value#>)
            self?.updateRoutines()
            self?.updateSummary()
        }

        routineListView.onRoutineTapped = { [weak self] routine in
            self?.viewModel.addRoutine(routine)
            self?.updateSummary()
        }

        calendarView.onDateSelected = { [weak self] date in
            self?.viewModel.selectDate(date)
            self?.updateSummary()
        }
    }

    private func updateRoutines() {
        let routines = viewModel.getPredefinedRoutines()
        routineListView.update(with: routines)
    }

    private func updateSummary() {
        let routines = viewModel.getRoutinesForSelectedDate()
        summaryView.update(with: routines)
    }
}
