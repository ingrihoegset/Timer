//
//  StatisticsViewModel.swift
//  Timer
//
//  Created by Ingrid on 25/09/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StatisticsViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var races = [Race]()
    let dateFormatter = DateFormatter()
    var runLapTimes = [Double]()

    init() {
    
    }
    
    func loadRace() {
        let fetchRequest: NSFetchRequest<Race> = Race.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            races = try context.fetch(fetchRequest)
            for i in 0...races.count - 1 {
                setTotalTime(thisRace: races[i])
                setAverageSpeed(thisRace: races[i])
            }
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func setTotalTime(thisRace: Race) {
        let breaktimes = getBreakTimes(thisRace: thisRace)
        thisRace.totalTime = (Double(breaktimes.last!) - Double(breaktimes.first!)) / Double(1000)
    }
    
    func setAverageSpeed(thisRace: Race) {
        let km = (Double(thisRace.lapLength) * Double(thisRace.laps)) /  1000
        let hours = thisRace.totalTime / Double(3600)
        thisRace.averageSpeed = km / hours
    }
    
    func setLapTimes(thisRace: Race) -> [Double] {
        let breaktimes = getBreakTimes(thisRace: thisRace)
        
        var times = [Double]()
        // Get lap times
        var previousLapTime = breaktimes[0]
        print(breaktimes.count)
        for i in 1...breaktimes.count - 1 {
            print(breaktimes.count - 1)
            let lapTime = (Double(breaktimes[i]) - Double(previousLapTime)) / Double(1000)
            times.append(lapTime)
            previousLapTime = breaktimes[i]
        }
        return times
    }
    
    func getBreakTimes(thisRace: Race) -> [Double] {
        // Retreive Breaktimes via relationships
        let timeCollector = thisRace.owns
        var allTimes = (timeCollector?.collects!.allObjects) as! [BreakTime]
        
        // Sort ascending to get starttime first and endtime last
        allTimes.sort{$0.time < $1.time}
        
        // Convert array of timestamps to array of Doubles to make manipulation easier
        var breaktimes = [Double]()
        allTimes.forEach { (breaktime) in
            let time = Double(breaktime.time)
            breaktimes.append(time)
        }
        return breaktimes
    }
    
    func reloadData(userFilter: [String]) {
        let fetchRequest = NSFetchRequest<Race>(entityName: "Race")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        let filterPredicate = NSPredicate(format: "type IN %@", userFilter)
        
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = filterPredicate
        do {
            races = try context.fetch(fetchRequest)
            print("printing filtered count", races.count)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func sortBySelected(selected: String, bool: Bool) {
        let fetchRequest = NSFetchRequest<Race>(entityName: "Race")
        let sortDescriptor = NSSortDescriptor(key: selected, ascending: bool)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            races = try context.fetch(fetchRequest)
            print("printing filtered count", races.count)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
}
