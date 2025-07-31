//
//  AddPetModel.swift
//  PetCareAppTask3
//
//  Created by Ayşe Nur Kendirci on 25.07.2025.
//

import Foundation

/// Evcil hayvan bilgilerini temsil eden veri modeli (Model katmanı)
struct Pet {
    var name: String         // Evcil hayvanın adı
    var type: String         // Türü (Kedi, Köpek, Balık, Kuş vb.)
    var breed: String        // Cinsi
    var birthDate: String    // Doğum tarihi
    var weight: String       // Ağırlığı (kg)
    var height: String       // Boyu (cm)
    var color: String        // Rengi
    var details: String      // Ekstra açıklamalar, notlar vs.
}
