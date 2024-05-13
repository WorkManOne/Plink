//
//  ViewModel.swift
//  plink
//
//  Created by Кирилл Архипов on 10.05.2024.
//

import Foundation

struct Player {
    var name : String
    var steps : Int
    var time : TimeInterval
}

struct Level {
    var number : Int
    var blocks : Int
    var timeRecord : TimeInterval
    var steps : Int
    var isOpened : Bool
}

class ViewModel : ObservableObject {
    @Published var topPlayers : [Player]
    @Published var vibrationSetting : Bool 
    @Published var levels : [Level]
    @Published var currLevel : Int {
        didSet {
            //UserDefaults.standard.object(forKey: "currLevel")
        }
    }
    init() {
        self.topPlayers = [Player(name: "aaa", steps: 20, time: 60),Player(name: "aa", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60),Player(name: "", steps: 20, time: 60)]
        self.vibrationSetting = false
        self.levels = [Level(number: 0, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: true),Level(number: 1, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 2, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 3, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 4, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 5, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 6, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 7, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false),Level(number: 8, blocks: 15, timeRecord: TimeInterval(Int.max), steps: Int.max, isOpened: false)]
        self.currLevel = 0
        
    }
    
    init(topPlayers: [Player], vibrationSetting: Bool, levels: [Level], currLevel : Int) {
        self.topPlayers = topPlayers
        self.vibrationSetting = false
        self.levels = levels
        self.currLevel = currLevel
    }
    
    func unlockNext(prev: Int) {
        if prev + 1 < levels.count {
            levels[prev + 1].isOpened = true
            currLevel = prev + 1
        }
        
    }
}
