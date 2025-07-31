import Foundation
import SwiftData

@Model
class Pet {
    var name: String
    var type: String
    var breed: String
    var birthDate: Date
    var weight: String
    var height: String
    var color: String
    var details: String

    init(name: String, type: String, breed: String, birthDate: Date,
         weight: String, height: String, color: String, details: String) {
        self.name = name
        self.type = type
        self.breed = breed
        self.birthDate = birthDate
        self.weight = weight
        self.height = height
        self.color = color
        self.details = details
    }
}
