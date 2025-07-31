import UIKit

/* final class PetCalendarView: UIView {

    // 📅 30 günlük tarih listesi (bugünden başlayarak)
    private(set) var dates: [Date] = []

    // 🔁 Kullanıcı bir tarihe tıkladığında dışarıya bilgi veren closure
    var onDateSelected: ((Date) -> Void)?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 44, height: 44)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDates()
        setupCollectionView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 📌 Bugünden itibaren 30 günlük tarih listesi oluştur
    private func setupDates() {
        let calendar = Calendar.current
        let today = Date()
        dates = (0..<30).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
    }

    // 🔧 CollectionView ayarları
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CalendarDayCell.self, forCellWithReuseIdentifier: CalendarDayCell.reuseIdentifier)
    }

    // 📐 UI yerleşimi
    private func setupLayout() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// 📆 CollectionView veri ve etkileşim ayarları
extension PetCalendarView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDayCell.reuseIdentifier, for: indexPath) as? CalendarDayCell else {
            return UICollectionViewCell()
        }

        let date = dates[indexPath.item]
        cell.configure(with: date)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDate = dates[indexPath.item]
        onDateSelected?(selectedDate)  // 📤 Tarih dışarıya bildirilir
    }
}
