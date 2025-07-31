import UIKit

/// Pet rengini seçmek için kullanılan özel bir UIView bileşeni
class PetColorPickerView: UIView {
    
    // Başlık etiketi (label) – "Evcil hayvanın rengi" yazısı
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Evcil hayvanın rengi"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    /// Dışarıdan erişilebilen, seçilen rengin adı
    public var selectedColor: String? {
        return selectedColorName
    }
    
    /// Renk adı ve UIColor değerlerinden oluşan dizi
    private let colors: [(name: String, color: UIColor)] = [
        ("Siyah", .black),
        ("Beyaz", .white),
        ("Kahverengi", UIColor.brown),
        ("Gri", UIColor.systemGray),
        ("Sarı", UIColor.systemYellow),
        ("Turuncu", UIColor.orange)
    ]
    
    private var selectedIndex: Int? // Seçilen butonun index'i
    private var selectedColorName: String? // Seçilen rengin ismi
    
    /// Seçim yapıldığında ViewController'a bilgi vermek için closure
    var onColorSelected: ((String) -> Void)?
    
    /// Renk butonlarının yer aldığı yatay grid
    private let grid = UIStackView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Ayarları
    private func setupView() {
        // Grid ayarları
        grid.axis = .horizontal
        grid.spacing = 12
        grid.distribution = .fillEqually
        
        // Her bir renk için buton oluştur
        for (index, colorInfo) in colors.enumerated() {
            let button = UIButton()
            button.backgroundColor = colorInfo.color
            button.layer.cornerRadius = 20
            button.layer.borderColor = UIColor.systemGray4.cgColor
            button.layer.borderWidth = 2
            button.tag = index // Hangi renk olduğunu anlamak için tag veriyoruz
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.addTarget(self, action: #selector(colorTapped(_:)), for: .touchUpInside)
            grid.addArrangedSubview(button)
        }
        
        // Label + Grid = Dikey Stack
        let verticalStack = UIStackView(arrangedSubviews: [label, grid])
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        
        // Ekrana yerleştir
        addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - Renk Seçildiğinde Çalışan Fonksiyon
    @objc private func colorTapped(_ sender: UIButton) {
        // Tüm butonların çerçevesini sıfırla
        for view in grid.arrangedSubviews {
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.systemGray4.cgColor
        }
        
        // Seçilen butonun çerçevesini vurgula
        sender.layer.borderWidth = 4
        sender.layer.borderColor = UIColor.systemIndigo.cgColor
        
        // Seçimi güncelle
        selectedIndex = sender.tag
        selectedColorName = colors[sender.tag].name
        
        // ViewController’a bildir
        onColorSelected?(selectedColorName!)
    }
}
