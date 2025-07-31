import UIKit
import SwiftData


// Splash (açılış) ekranını temsil eden ViewController
class SplashViewController: UIViewController {
    
    var modelContext: ModelContext?//bir sonraki ekrana Bu ekranda kullanılmıyor ama bir sonraki ViewController’a gönderiliyor

    // Arka plan görseli: ekranı tamamen kaplayan bir UIImageView
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sembol") // Assets klasöründeki "sembol" görseli kullanılacak
        imageView.contentMode = .scaleAspectFill // Görsel ekranı dolduracak şekilde ölçeklenir
        imageView.translatesAutoresizingMaskIntoConstraints = false //otomatik eski layout aistemini kullanmaz
        return imageView
    }()
    
    // "Get Started" butonu: kullanıcıya ana ekrana geçme
    private let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal) // Buton metni
        button.setTitleColor(.white, for: .normal) // Yazı rengi
        button.backgroundColor = UIColor.systemIndigo // Arka plan rengi
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18) // Yazı fontu
        button.layer.cornerRadius = 10 // Köşe yuvarlama
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        // Butona tıklanınca `goToMainScreen` fonksiyonu çalışır
        getStartedButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
    }
    
    // Ekran düzenini ve bileşenleri yerleştirme işlemleri addSubview, bir UIView nesnesini başka bir UIView'in içine (altına) eklemek için kullanılır.
    private func setupLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(getStartedButton)
        
        // Arka plan görselini tüm ekrana yay
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // "Get Started" butonunu ekranın alt ortasına yerleştir
        NSLayoutConstraint.activate([
            getStartedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalToConstant: 200),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func goToMainScreen() {
        let mainFormVC = AddPetFullFormViewController() //Yeni bir ekran oluşturuluyor. Bu ekran: evcil hayvan bilgisi giriş formu ekranı.
        //SceneDelegate → SplashViewController → AddPetFullFormViewController → MainTabBarController

        mainFormVC.modelContext = modelContext // sonraki sayfaya context aktarımı
        self.navigationController?.pushViewController(mainFormVC, animated: true) //Navigation yapısında bu ekranı göster. Yani kullanıcı splash ekranından çıkıp AddPetFullFormViewController ekranına geçiyor. animated: true geçişin animasyonlu olduğunu belirtir.
    }

}

//Kullanıcı "Get Started" butonuna basar ⟶
//goToMainScreen() çalışır ⟶
//Yeni AddPet ekranı oluşturulur ⟶
//SwiftData context o ekrana aktarılır ⟶
//Ekran kullanıcıya gösterilir

