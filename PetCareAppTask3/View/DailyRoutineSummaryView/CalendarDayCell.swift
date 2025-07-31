import UIKit

// Bu class, takvimdeki her bir günü temsil eden hücre (cell) bileşenidir.
final class CalendarDayCell: UICollectionViewCell {
    
    // Hücrenin tekrar kullanılabilmesi için tanımlanan sabit identifier
    static let reuseIdentifier = "CalendarDayCell"

    // Gün sayısını gösterecek label (örneğin "29")
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center         // Ortalanmış metin
        label.font = .systemFont(ofSize: 16, weight: .medium)  // Yazı tipi
        label.textColor = .label              // Tema rengine uyumlu metin rengi
        return label
    }()

    // Hücre oluşturulduğunda çağrılır
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // Storyboard kullanılmadığı için bu fonksiyon devre dışı bırakılıyor
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Dışarıdan tarih objesi geldiğinde gün sayısını alır ve diğer configure fonksiyonuna gönderir
    func configure(with date: Date, isSelected: Bool = false) {
        let day = Calendar.current.component(.day, from: date) // Tarihten gün sayısını al
        configure(with: day, isSelected: isSelected)
    }

    // Hücre görünümünü düzenleyen yardımcı fonksiyon
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8                        // Köşe yumuşatma
        contentView.layer.borderWidth = 1                        // Kenarlık kalınlığı
        contentView.layer.borderColor = UIColor.systemGray5.cgColor

        // Gün etiketini hücreye ekle
        contentView.addSubview(dayLabel)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    // Gün sayısını hücreye yazan ve seçili mi değil mi kontrol eden fonksiyon
    func configure(with day: Int, isSelected: Bool = false) {
        dayLabel.text = "\(day)"  // Örn: "29"

        // Seçili ise arka planı mavi yap, değilse beyaz
        contentView.backgroundColor = isSelected
            ? UIColor.systemBlue.withAlphaComponent(0.2)
            : .white
    }
}
