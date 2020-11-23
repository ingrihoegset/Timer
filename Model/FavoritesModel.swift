//
//  FavoritesModel.swift
//  Timer
//
//  Created by Ingrid on 27/10/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoritesModel {
    
    var favorites = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
    
    }
    
    func loadFavorites() -> [Category] {
        
        favorites = []
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            let requestedFavorites = try context.fetch(request)
            for item in requestedFavorites {
                favorites.append(item)
            }
        }
        catch {
            print("Error fetching data from context \(error)")
        }
        return favorites
    }
    
    func delete() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
            }
        }
    }

    
    func saveRace() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
    }
    
    func addFavorite(length: Int, type: String, name: String, delay: Int, laps: Int, reactionTime: Int) {
        
        let race = Category(context: context)
        
        race.name = name
        race.type = type
        race.isFavorite = true
        race.lapLength = Int32(length)
        race.laps = Int16(laps)
        race.delayBeforeStart = Int32(delay)
        race.reactionTime = Int32(reactionTime)
        
        self.saveRace()
    }
    
    func deleteFavorite(category: Category) {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        if let result = try? context.fetch(request) {
            for object in result {
                print(object == category)
                if object == category {
                    print(object)
                    context.delete(object)
                }
            }
        }
        saveRace()
    }
}
