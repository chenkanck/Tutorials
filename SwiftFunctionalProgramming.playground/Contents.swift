//: Playground - noun: a place where people can play

import UIKit
typealias BandTransform = [String: String] -> [String: String]

let canada: (String) -> String = { _ in return "Canada"}
let capitalize: (String) -> String = { $0.capitalizedString }
let strip: (String) -> String = { $0.stringByReplacingOccurrencesOfString(".", withString: " ") }

func call(function: (String) -> String, key: String) -> (([String: String]) -> [String: String] ){
    return { band in
        var newBand = band
        newBand[key] = function(band[key]!)
        return newBand
    }
}

func assoc(dict: [String: String], key: String, value: String) -> [String: String] {
    var localDict = dict
    localDict[key] = value
    return localDict
}

func setCanadaAsCountry(band: [String: String]) -> [String: String] {
    return assoc(band, key: "country", value: "Canada")
}

func stripPunctuationFormName(band: [String: String]) -> [String: String] {
    guard let name = band["name"] else { return band }
    return assoc(band, key: "name", value: name.stringByReplacingOccurrencesOfString(".", withString: " "))
}

func capitalizeName(band: [String: String]) -> [String: String] {
    guard let name = band["name"] else { return band }
    return assoc(band, key: "name", value: name.capitalizedString)
}


let bands = [["name": "sunset rubdown", "country": "UK", "active": "false"],
             ["name": "women", "country": "Germany", "active": "false"],
             ["name": "a silver mt. zion", "country": "Spain", "active": "false"]]
func pipelineEach(bands: [[String: String]], fns: [BandTransform] ) -> [[String: String]] {
    return fns.reduce(bands) { data, fn in data.map(fn) }
}

let result = pipelineEach(bands, fns: [setCanadaAsCountry, stripPunctuationFormName, capitalizeName])
print(result)
let result2 = pipelineEach(bands, fns: [call(canada, key: "country"), call(capitalize, key: "name"), call(strip, key: "name")])
print(result2)
typealias Time = Int
typealias Positions = [Int]
typealias State = (time: Time, positions: Positions)

func outputCar(carPostion: Int) -> String {
    let output = (0..<carPostion).map { _ in "-" }
    return output.joinWithSeparator("")
}

func draw(state: State) {
    let outputs = state.positions.map { outputCar($0)}
    print(outputs.joinWithSeparator("\n"))
}


func moveCars(positions: [Int]) -> [Int] {
    return positions.map { drand48() > 0.3 ? $0 + 1: $0 }
}

func runStepOfRace(state: State) -> State {
    let newTime = state.time - 1
    let newPosition = moveCars(state.positions)
    return (newTime, newPosition)
}

func race(state: State) {
    draw(state)
    if state.time > 1 {
        print("\n\n")
        race(runStepOfRace(state))
    }
}
let state: State = (time: 5, positions: [1,1,1])

