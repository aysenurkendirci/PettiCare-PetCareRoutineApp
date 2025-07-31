/*import UIKit

final class PetInfoViewController: UIViewController {

    private let inputViewComponent = PetInfoInputView()
    private let nextButton = UIButton(type: .system)

    var onNext: ((String, String, String, String) -> Void)? // date, weight, height, details

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Bilgileri Tamamla"
        setupLayout()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        inputViewComponent.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputViewComponent)

        nextButton.setTitle("Kaydet", for: .normal)
        nextButton.backgroundColor = UIColor.systemPink
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            inputViewComponent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            inputViewComponent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputViewComponent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nextButton.topAnchor.constraint(equalTo: inputViewComponent.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
   
  @objc private func nextTapped() {
        guard
            let date = inputViewComponent.selectedDate,
            let weight = inputViewComponent.weight, !weight.isEmpty,
            let height = inputViewComponent.height, !height.isEmpty
        else {
            showAlert("Lütfen doğum tarihi, boy ve kilo bilgilerini girin.")
            return
        }
     
        let details = inputViewComponent.details ?? ""
        onNext?(date, weight, height, details)
    }

    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Eksik Bilgi", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
 }*/
