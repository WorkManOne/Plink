//
//  ViewModel.swift
//  plink
//
//  Created by Кирилл Архипов on 10.05.2024.
//

import Foundation

struct Record : Codable {
    //var name : String
    //var lvl : String
    var steps : Int = Int.max
    var time : TimeInterval = TimeInterval(Int.max)
}

struct Level : Codable {
    var number : Int
    var blocks : Int
    var timeRecord : TimeInterval
    var steps : Int
    var isOpened : Bool
}

class ViewModel : ObservableObject {
    @Published var topRecords : [Record]{
        didSet {
            if let encoded = try? JSONEncoder().encode(topRecords) {
                UserDefaults.standard.set(encoded, forKey: "topRecords")
            }
        }
    }
    @Published var vibrationSetting : Bool {
        didSet {
            if let encoded = try? JSONEncoder().encode(vibrationSetting) {
                UserDefaults.standard.set(encoded, forKey: "vibrationSetting")
            }
        }
    }
    @Published var levels : [Level] {
        didSet {
            if let encoded = try? JSONEncoder().encode(levels) {
                UserDefaults.standard.set(encoded, forKey: "levels")
            }
        }
    }
    @Published var currLevel : Int {
        didSet {
            if let encoded = try? JSONEncoder().encode(currLevel) {
                UserDefaults.standard.set(encoded, forKey: "currLevel")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "topRecords"),
           let decoded = try? JSONDecoder().decode([Record].self, from: data) {
            self.topRecords = decoded
        } else {
            self.topRecords = [Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record(),Record()]
        }
        if let data = UserDefaults.standard.data(forKey: "levels"),
           let decoded = try? JSONDecoder().decode([Level].self, from: data) {
            self.levels = decoded
        } else {
            self.levels = [Level(number: 0, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: true),Level(number: 1, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 2, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 3, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 4, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 5, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 6, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 7, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 8, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false)]
        }
        
        if let data = UserDefaults.standard.data(forKey: "currLevel"),
           let decoded = try? JSONDecoder().decode(Int.self, from: data) {
            self.currLevel = decoded
        } else {
            self.currLevel = 0
        }
        
        if let data = UserDefaults.standard.data(forKey: "vibrationSetting"),
           let decoded = try? JSONDecoder().decode(Bool.self, from: data) {
            self.vibrationSetting = decoded
        } else {
            self.vibrationSetting = false
        }
        
    }
    
    init(topRecords: [Record], vibrationSetting: Bool, levels: [Level], currLevel : Int) {
        self.topRecords = topRecords
        self.vibrationSetting = false
        self.levels = levels
        self.currLevel = currLevel
    }
    
    func unlockNext(prev: Int) {
        if prev + 1 < levels.count {
            levels[prev + 1].isOpened = true
            if (currLevel < prev + 1) {
                currLevel = prev + 1
            }
        }
    }
    func resetProgress() {
        for index in 0..<levels.count {
            levels[index].isOpened = false
        }
        if let _ = levels.first {
            levels[0].isOpened = true
        }
        topRecords.removeAll()
        currLevel = 0
    }
    func addNewRec(rec: Record) {
        topRecords.append(rec)
        topRecords.sort { r1, r2 in
            if r1.time < r2.time {
                return true
            }
            else if r1.time == r2.time && r1.steps < r2.steps {
                return true
            }
            else { return false }
        }
        
        print(topRecords)
        while topRecords.count > 10 {
            topRecords.removeLast()
        }
        print(topRecords)
        
    }
}
