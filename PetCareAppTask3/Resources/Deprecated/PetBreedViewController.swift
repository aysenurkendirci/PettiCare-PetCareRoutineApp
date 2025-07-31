/*import UIKit

final class PetBreedViewController: UIViewController {

    let selectedType: String
    private let breedPickerView = PetBreedPickerView()

    var onNext: ((String) -> Void)?

    init(selectedType: String) {
        self.selectedType = selectedType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        breedPickerView.updateBreedList(for: selectedType)
        breedPickerView.onBreedSelected = { [weak self] selectedBreed in
            self?.onNext?(selectedBreed)
        }
    }

    private func setupLayout() {
        breedPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(breedPickerView)

        NSLayoutConstraint.activate([
            breedPickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            breedPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            breedPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
 }*/
