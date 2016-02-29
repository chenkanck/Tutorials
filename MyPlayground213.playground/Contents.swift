//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
enum VaccineFieldInfoType {
    case TextField
    case Selection
    case Searchable
    case Date
    case None
}

struct VaccineFieldInfo {
    var title: String
    var fieldType: VaccineFieldInfoType
    init (title: String, fieldType: VaccineFieldInfoType) {
        self.title = title
        self.fieldType = fieldType
    }
}
var fields: [[VaccineFieldInfo]] = []
var fieldsInSection: [VaccineFieldInfo] = []
fieldsInSection.append(VaccineFieldInfo(title: "CVX", fieldType: .Searchable))
fieldsInSection.append(VaccineFieldInfo(title: "Name", fieldType: .TextField))
fieldsInSection.append(VaccineFieldInfo(title: "CPT Code", fieldType: .TextField))
fieldsInSection.append(VaccineFieldInfo(title: "Manufacturer", fieldType: .Searchable))
fields.append(fieldsInSection)
//section 2
fieldsInSection = []
fieldsInSection.append(VaccineFieldInfo(title: "Lot number", fieldType: .TextField))
fieldsInSection.append(VaccineFieldInfo(title: "Lot expiration date", fieldType: .Date))
fieldsInSection.append(VaccineFieldInfo(title: "Administered amount:", fieldType: .TextField))
fieldsInSection.append(VaccineFieldInfo(title: "Administered units", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Vaccine route", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Vaccine site", fieldType: .Selection))
fields.append(fieldsInSection)
//section 3
fieldsInSection = []
fieldsInSection.append(VaccineFieldInfo(title: "Vaccination Status", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Administered on", fieldType: .Date))
fieldsInSection.append(VaccineFieldInfo(title: "Ordering doctor", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Administered by", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Administered at", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "", fieldType: .None))
fields.append(fieldsInSection)
//section 4
fieldsInSection = []
fieldsInSection.append(VaccineFieldInfo(title: "Vaccine inventory lot", fieldType: .TextField))
fieldsInSection.append(VaccineFieldInfo(title: "Record Type", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Funding Eligibility", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Observed Immunity", fieldType: .Selection))
fieldsInSection.append(VaccineFieldInfo(title: "Comments", fieldType: .TextField))
fieldsInSection.append(VaccineFieldInfo(title: "", fieldType: .None))
fields.append(fieldsInSection)

print(fields[1][3].title)