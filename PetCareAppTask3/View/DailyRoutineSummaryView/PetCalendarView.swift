import UIKit

final class CalendarDayCell: UICollectionViewCell {

    private let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override var isSelected: Bool {
        didSet {
            updateSelectionStyle()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with date: Date, selected: Bool) {
        let day = Calendar.current.component(.day, from: date)
        label.text = "\(day)"
        isSelected = selected
    }

    private func setupUI() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        contentView.layer.cornerRadius = contentView.bounds.width / 2
        contentView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.width / 2
    }

    private func updateSelectionStyle() {
        contentView.backgroundColor = isSelected ? .systemPurple : .clear
        label.textColor = isSelected ? .white : .black
    }
}
