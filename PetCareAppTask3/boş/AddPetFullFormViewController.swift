import UIKit
import SwiftData

final class AddPetFullFormViewController: UIViewController { // final: Bu sınıfın miras alınamayacağını belirtir.
    
    var modelContext: ModelContext? // SwiftData context buradan alınır.Bu context, verileri SwiftData ile kaydedebilmek için gerekli.Splash ekranından bu ViewController'a manuel aktarılıyor.
    
    private let nameInput = PetNameInputView()
    private let typePicker = PetTypePickerView()
    private let breedPicker = PetBreedPickerView()
    private let birthDatePicker = PetBirthDatePickerView() //componentlerimi çağırdım c:
    private let sizeInput = PetSizeInputView()
    private let colorPicker = PetColorPickerView()
    private let featuresInput = PetFeaturesView()
    
    private let saveButton: UIButton = { //kaydet butonu şekil
        let button = UIButton(type: .system)
        button.setTitle("Kaydet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 60/255, blue: 130/255, alpha: 1)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
        
    }()
    //scroll özelliiğim
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MVVM yapısına göre, veri işleme ve saklama bu ViewModel’de yapılır.Controller sadece görünümden sorumludur.
    
    private let viewModel = AddPetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Evcil Hayvan Bilgileri"
        applyGradientBackground() // Arka plan geçiş efekti uygula
        setupLayout() //UI yerleşimlerini ayarla
        setupCallbacks() //Component -> ViewModel bağlantıları kur
        
        // SwiftData context ViewModel'e aktarılır
        viewModel.modelContext = modelContext
        
        // "Kaydet" butonuna tıklanınca handleSave fonksiyonu çağrılır
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
    
    // Arka planı iki mavi tonlu bir gradient olarak ayarlar.
    private func applyGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor,
            UIColor(red: 0/255, green: 200/255, blue: 255/255, alpha: 1).cgColor
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    // Formun tüm bileşenlerini dikey  ekran yerleşimine ekler
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Tüm componentleri dikey olarak sırala
        let stack = UIStackView(arrangedSubviews: [
            wrapInCard(nameInput),
            wrapInCard(typePicker),
            wrapInCard(breedPicker),
            wrapInCard(birthDatePicker),
            wrapInCard(sizeInput),
            wrapInCard(colorPicker),
            wrapInCard(featuresInput),
            saveButton
        ])
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    // Bileşenleri kart görünümüyle saran yardımcı fonksiyon
    private func wrapInCard(_ view: UIView) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.05
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 4
        
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        //subview içine yerleştirme olarak ekran içine yerleştirme gibi
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
        
        return container
    }
    
    
    // Kullanıcı girişlerini viewModel.pet içine aktarır
    //Kullanıcı bir input girdiğinde, bu bilgi ViewModel içindeki pet objesine aktarılır.
    //Her component içinde tanımlı olan closure (onNameEntered, onTypeSelected, vs.) kullanılmış.
    

    private func setupCallbacks() {
        nameInput.onNameEntered = { [weak self] name in
            self?.viewModel.pet.name = name
        }
        typePicker.onTypeSelected = { [weak self] type in
            self?.viewModel.pet.type = type
            self?.breedPicker.updateBreedList(for: type)
        }
        breedPicker.onBreedSelected = { [weak self] breed in
            self?.viewModel.pet.breed = breed
        }
        birthDatePicker.onDateSelected = { [weak self] date in
            self?.viewModel.pet.birthDate = date
        }
        sizeInput.onSizeEntered = { [weak self] weight, height in
            self?.viewModel.pet.weight = weight
            self?.viewModel.pet.height = height
        }
        colorPicker.onColorSelected = { [weak self] color in
            self?.viewModel.pet.color = color
        }
    }
    
    @objc private func handleSave() {
        let pet = viewModel.pet  // ViewModel içindeki geçici pet nesnesini al
        
        // Tüm alanların dolu olup olmadığını kontrol et (form doğrulama)
        guard
            !pet.name.isEmpty,                             // İsim boş değilse
            !pet.type.isEmpty,                             // Tür boş değilse
            !pet.breed.isEmpty,                            // Cins boş değilse
            !pet.color.isEmpty,                            // Renk boş değilse
            pet.birthDate != Date.distantPast,             // Doğum tarihi girildiyse
            !pet.weight.isEmpty,                           // Ağırlık boş değilse
            !pet.height.isEmpty,                           // Boy boş değilse
            let features = featuresInput.selectedFeatures  // Özellikler varsa (TextView'dan alınır)
        else {
            // Eğer yukarıdaki kontrollerden biri bile sağlanmazsa uyarı ver
            showAlert(title: "Eksik Bilgi", message: "Lütfen tüm alanları doldurun.")
            return  // Kayıt işlemi durdurulur
        }
        
        // Test amaçlı: Kayıtlı evcil hayvanları terminale yazdır
        do {
            let descriptor = FetchDescriptor<Pet>()              // Tüm Pet verilerini çekmek için descriptor oluştur
            let pets = try modelContext?.fetch(descriptor)       // SwiftData'dan verileri çek
            print("📦 Kayıtlı Pet'ler:")
            pets?.forEach { pet in
                print("🐾 \(pet.name) | Tür: \(pet.type) | Doğum: \(pet.birthDate)")
            }
        } catch {
            print("❌ Fetch hatası: \(error)") // Veri çekme sırasında hata olursa
        }
        
        // ViewModel içindeki detay alanını da doldur
        viewModel.pet.details = features
        
        // ViewModel aracılığıyla veriyi kaydet (SwiftData içine yaz)
        viewModel.savePet(
            name: pet.name,
            type: pet.type,
            breed: pet.breed,
            birthDate: pet.birthDate,
            weight: pet.weight,
            height: pet.height,
            color: pet.color,
            details: pet.details
        )
        
        // Başarılı kayıt sonrası kullanıcıya bilgi ver, ardından yeni ekrana geç
            showAlert(title: "Başarılı", message: "Evcil hayvan başarıyla kaydedildi!") {
                let tabBarController = MainTabBarController()
                tabBarController.modelContext = self.modelContext // 💡 context'i aktar
                tabBarController.selectedType = pet.type 
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = tabBarController
                    window.makeKeyAndVisible()
                }

            }
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert) // Uyarı kutusu oluştur
        alert.addAction(UIAlertAction(title: "Tamam", style: .default) { _ in
            completion?()  // Eğer tamamlandıysa (kapanınca yapılacak işlem varsa) onu çalıştır
        })
        present(alert, animated: true) // Uyarıyı göster
    }

 }
}

    
