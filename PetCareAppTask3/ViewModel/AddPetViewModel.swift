import Foundation
import SwiftData

class AddPetViewModel {
    var modelContext: ModelContext?

    
    var pet = Pet(
        name: "",
        type: "",
        breed: "",
        birthDate: Date(),
        weight: "",
        height: "",
        color: "",
        details: ""
    )

    func savePet(name: String, type: String, breed: String, birthDate: Date, weight: String, height: String, color: String, details: String) {
        guard let context = modelContext else { return }

        let newPet = Pet(
            name: name,
            type: type,
            breed: breed,
            birthDate: birthDate,
            weight: weight,
            height: height,
            color: color,
            details: details
        )

        context.insert(newPet)
        print("🐶 Kaydedilen Pet: \(newPet.name)")
    }
    var selectedType: String {
        return pet.type
    }

}

