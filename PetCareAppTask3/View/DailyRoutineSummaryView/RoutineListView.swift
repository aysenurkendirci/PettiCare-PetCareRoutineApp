import UIKit

final class RoutineListView: UIStackView {

    var onFrequencyTappedAtIndex: ((Int, String) -> Void)?

    private var currentRoutines: [(title: String, subtitle: String)] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStackView() {
        axis = .vertical
        spacing = 12
        distribution = .fill
        alignment = .fill
        translatesAutoresizingMaskIntoConstraints = false
    }

    func update(with routines: [(title: String, subtitle: String)]) {
        currentRoutines = routines
        arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, item) in routines.enumerated() {
            let icon = UIImage(systemName: "pawprint") ?? UIImage()
            let view = RoutineItemView(title: item.title, subtitle: item.subtitle, icon: icon)

            // 🎯 Kullanıcı sıklığa tıkladığında:
            view.onFrequencyTap = { [weak self] in
                self?.onFrequencyTappedAtIndex?(index, item.title)
            }

            addArrangedSubview(view)
        }
    }

    func updateFrequency(at index: Int, to newFrequency: String) {
        guard index < arrangedSubviews.count else { return }
        currentRoutines[index].subtitle = newFrequency
        if let itemView = arrangedSubviews[index] as? RoutineItemView {
            itemView.updateSubtitle(newFrequency)
        }
    }
}
