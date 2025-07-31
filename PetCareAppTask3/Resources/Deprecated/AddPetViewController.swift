/*import UIKit

 

class AddPetViewController: UIViewController {
    private let datePicker = UIDatePicker()

    private let viewModel = AddPetViewModel()
    private let scrollView = UIScrollView() // Formu kaydırmak için scroll view
    private let contentView = UIView() // Scroll view içinde içerik alanı
    private let stackView = UIStackView() // Tüm form elemanları bu stackView içinde yer alacak
    private let kaydetButton = UIButton(type: .system) // Kaydet butonu

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // Ekran tasarımını başlat
        setupForm() // Form elemanlarını oluştur
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)) // Klavyeyi kapatma gesture'ı
        view.addGestureRecognizer(tap)
        
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true) // Klavyeyi kapat Aktif olan textfield'ı kapatır. Klavye kapanır.
    }

    private func setupView() { //arayüz kurulumu
        view.backgroundColor = UIColor(red: 0.98, green: 0.95, blue: 0.93, alpha: 1)
        title = "Evcil Hayvan Ekle"
        navigationController?.navigationBar.prefersLargeTitles = false //navigationController?: Eğer bu view controller bir UINavigationController içinde yer alıyorsa....navigationBar: Navigasyon bar'ına erişir.

           // .prefersLargeTitles == false;: Başlığın büyük (large title) olarak görünmesini kapatır.



        // ScrollView ve ContentView'ı ekrana yerleştir
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // ScrollView ve ContentView constraint'leri
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func createTextField(placeholder: String) -> UITextField {
        // Ortak text field şablonu
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.layer.shadowColor = UIColor.black.cgColor
        tf.layer.shadowOpacity = 0.05
        tf.layer.shadowOffset = CGSize(width: 0, height: 2)
        tf.layer.shadowRadius = 4
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return tf
    }

    private func setupForm() {
        // StackView ayarları
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        // Ad alanı
        let nameField = createTextField(placeholder: "Evcil hayvanınızın adı")
        nameField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        nameField.tag = 0
        stackView.addArrangedSubview(nameField)

        // Tür alanı - yeni component
        let typePicker = PetTypePickerView()
        typePicker.onTypeSelected = { [weak self] selected in
            self?.viewModel.pet.type = selected
        }
        stackView.addArrangedSubview(typePicker)

        let breedPicker = PetBreedPickerView()
        breedPicker.onBreedSelected = { [weak self] selectedBreed in
            self?.viewModel.pet.breed = selectedBreed
        }
        stackView.addArrangedSubview(breedPicker)

        // StackView constraint'leri
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        // Form alanları
        let fields = [
            ("Evcil hayvanınızın ağırlığı", \Pet.weight),
            ("Evcil hayvanınızın doğduğu tarih", \Pet.birthDate), 
            ("Evcil hayvanınızın boyu", \Pet.height),
            ("Evcil hayvanınızın rengi", \Pet.color),
            ("Evcil hayvanınızın özellikleri", \Pet.details)
        ]

        // Her bir text field oluşturulup stackView'e ekleniyor
        for (placeholder, _) in fields {
            let tf = createTextField(placeholder: placeholder)
            tf.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
            tf.tag = stackView.arrangedSubviews.count
           
            // Doğum tarihi alanı için UIDatePicker bağla
            if placeholder == "Evcil hayvanınızın doğduğu tarih" {
                createDatePicker(for: tf)
            }

            stackView.addArrangedSubview(tf)
        }

        
        // Kaydet butonu ayarları
        kaydetButton.setTitle("Kaydet", for: .normal)
        kaydetButton.backgroundColor = UIColor.systemPink
        kaydetButton.setTitleColor(.white, for: .normal)
        kaydetButton.layer.cornerRadius = 8
        kaydetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        kaydetButton.layer.shadowColor = UIColor.black.cgColor
        kaydetButton.layer.shadowOpacity = 0.1
        kaydetButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        kaydetButton.layer.shadowRadius = 4
        kaydetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        kaydetButton.addTarget(self, action: #selector(kaydetTapped), for: .touchUpInside)

        // Buton stackView'e ekleniyor
        stackView.addArrangedSubview(kaydetButton)
    }

    @objc private func textFieldChanged(_ textField: UITextField) {
        // Girilen veriyi ViewModel'e aktar
        let text = textField.text ?? ""
        switch textField.tag {
        case 0: viewModel.pet.name = text
        case 1: viewModel.pet.type = text
        case 2: viewModel.pet.breed = text
        case 3: viewModel.pet.birthDate = text
        case 4: viewModel.pet.weight = text
        case 5: viewModel.pet.height = text
        case 6: viewModel.pet.color = text
        case 7: viewModel.pet.details = text
        default: break
        }
    }
//*Boş alan  varsa uyarı
    @objc private func kaydetTapped() {
        // Formdaki tüm text field'leri al
        let textFields = stackView.arrangedSubviews.compactMap { $0 as? UITextField }

        // Boş olan alanları bul
        let emptyFields = textFields.filter {
            ($0.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }

        // Önce tüm kenarlıkları sıfırla
        textFields.forEach { tf in
            tf.layer.borderWidth = 0
            tf.layer.borderColor = UIColor.clear.cgColor
        }

        if !emptyFields.isEmpty {
            // Boş olan alanlara kırmızı kenarlık ekle
            emptyFields.forEach { tf in
                tf.layer.borderColor = UIColor.red.cgColor
                tf.layer.borderWidth = 1
            }

            // Uyarı göster
            let alert = UIAlertController(title: "Eksik Bilgi", message: "Lütfen tüm alanları doldurun.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
            return
        }

        // Veriler geçerliyse kaydet
        viewModel.savePet()
        let alert = UIAlertController(title: "Kaydedildi", message: "Evcil hayvan başarıyla kaydedildi.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }

    private func createDatePicker(for textField: UITextField) {
        // Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(donePressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "İptal", style: .plain, target: self, action: #selector(cancelPressed))
        toolbar.setItems([cancelButton, space, doneButton], animated: true)

        // DatePicker ayarları
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.locale = Locale(identifier: "tr_TR")

        // TextField'a ata
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    
    @objc private func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "tr_TR")
        
        let selectedDate = formatter.string(from: datePicker.date)

        // Doğum tarihi textField'ını bul ve güncelle
        if let birthDateField = stackView.arrangedSubviews.compactMap({ $0 as? UITextField }).first(where: { $0.placeholder == "Evcil hayvanınızın doğduğu tarih" }) {
            birthDateField.text = selectedDate
            viewModel.pet.birthDate = selectedDate
        }

        view.endEditing(true)
    }

    @objc private func cancelPressed() {
        view.endEditing(true)
    }

  }*/*/
