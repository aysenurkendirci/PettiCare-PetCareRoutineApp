import UIKit

final class RoutineCalendarView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var selectedDate = Date()
    var onDateSelected: ((Date) -> Void)?

    private var calendarDays: [Date] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        register(CalendarDayCell.self, forCellWithReuseIdentifier: "dayCell")
        generateDays()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func generateDays() {
        let calendar = Calendar.current
        let start = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!
        calendarDays = (0..<30).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
        reloadData()
    }

    // MARK: - UICollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarDays.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let date = calendarDays[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CalendarDayCell
        let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
        cell.configure(with: <#Date#>, date: date, selected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = calendarDays[indexPath.item]
        onDateSelected?(selectedDate)
        reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 6 * 8) / 7
        return CGSize(width: width, height: width)
    }
}
