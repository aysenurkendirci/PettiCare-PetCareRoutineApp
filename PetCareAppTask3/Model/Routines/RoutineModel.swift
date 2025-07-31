//
//  Routine.swift
//  PetCareAppTask3
//
//  Created by Ayşe Nur Kendirci on 29.07.2025.
//

import Foundation

// MARK: - Pet Türleri Tanımı

/// Uygulamada desteklenen evcil hayvan türlerini belirler.
/// Bu enum sayesinde sadece tanımlı türler üzerinden işlem yapılabilir.
/// UI'da seçim ekranları için `.allCases` ile tüm türler listelenebilir.
enum PetType: String, CaseIterable {
    case cat = "Cat"
    case dog = "Dog"
    case bird = "Bird"
    case fish = "Fish"
}

//PetType.allCases // [cat, dog, bird, others]

// MARK: - Rutin Modeli

/// Tek bir rutini (örneğin: "Mama Ver", "Gezdir") temsil eder.
/// `RoutineListView` bu veriyi alıp ekrana kart olarak gösterir.
struct Routine {
    let title: String         // Kartta gözükecek başlık
    let iconName: String 
    var frequency: String// İlgili SF Symbol veya asset ismi
}

// MARK: - Günlük Rutin Modeli

/// Belirli bir tarih ve pet türü için tanımlanmış günlük rutinleri içerir.
/// Örn: 29 Temmuz'da bir köpek için 3 rutin olabilir.
struct DailyRoutine {
    let date: Date                // Hangi güne ait?
    let petType: PetType          // Hangi hayvan türü için?
    var routines: [Routine]       // O güne ait görevler
}
