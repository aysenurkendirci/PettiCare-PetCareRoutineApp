/*import UIKit

// Günün toplam rutin sayısını gösteren kutucuk (View)
final class DailyRoutineSummaryView: UIView {

    // Label: "Today's routines: 0" şeklinde metin gösterir
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Today's routines: 0"  // Varsayılan metin
        label.font = .systemFont(ofSize: 16, weight: .medium)  // Yazı tipi
        label.textAlignment = .center       // Ortalanmış metin
        return label
    }()

    // View programatik olarak başlatıldığında çalışır
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()  // Görünümü ayarla
    }

    // Storyboard kullanılmadığında bu fonksiyon iptal edilir
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Görsel yapılandırmaları ve layout'u burada yapıyoruz
    private func setupView() {
        backgroundColor = .white  // Arka plan rengi
        layer.cornerRadius = 12   // Kenarları yuvarlat
        layer.borderColor = UIColor.systemGray5.cgColor // Kenarlık rengi
        layer.borderWidth = 1     // Kenarlık kalınlığı

        addSubview(label)         // Label'ı View'e ekle
        label.translatesAutoresizingMaskIntoConstraints = false

        // AutoLayout kuralları
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }

    // View dışarıdan güncellenmek istendiğinde çağrılır
    func update(count: Int) {
        label.text = "Today's routines: \(count)"
    }
} */
