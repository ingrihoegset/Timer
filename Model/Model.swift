//
//  Model.swift
//  HeadLight2020
//
//  Created by Ingrid on 10/08/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Model: NSObject {
    
    let cameraCapture = CameraCapture()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var thisRace: Race?
    var thisCollector: TimeCollector?

    var races = [Race]()
    var breakTimes = [BreakTime]()
    var collector = [TimeCollector]()
    var favorites = [Category]()
    
    var lapsCounter = 1
    
    override init() {

        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addBreak), name: NSNotification.Name.init(rawValue: "broken"), object: nil)
    }
    
    
    func setRace(race: Race) {
      //  self.race = race
    }
    
    func startRace(laps: Int16, length: Int32) {
        
        lapsCounter = Int(laps)
        
        thisRace = Race(context: context)
        thisCollector = TimeCollector(context: context)
        let thisBreak = BreakTime(context: context)
        
        print(thisBreak)
    
        thisRace!.owns = thisCollector
        thisCollector!.addToCollects(thisBreak)

        thisRace!.date = Date()
        thisRace!.laps = laps
        thisRace!.lapLength = length
        
        let date = Date()
        thisBreak.time = date.currentTimeMillis()
        
        if (laps == 1) {
            thisRace!.type = "Speed"
        }
        else {
            thisRace!.type = "Laps"
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "startRecording"), object: nil)

        self.saveRace()
    }
    
    @objc func addBreak() {
        
        lapsCounter = lapsCounter - 1
        
        print("adding break")
        
        let thisBreak = BreakTime(context: context)
        let date = Date()
        thisBreak.time = date.currentTimeMillis()

        print(lapsCounter)
        if (lapsCounter == 0) {
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "stopRecording"), object: nil)
        }
        thisCollector!.addToCollects(thisBreak)
        print(thisBreak)
        saveRace()
    }
    
    func saveRace() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
    }
}
