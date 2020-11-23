//
//  SortViewModel.swift
//  Timer
//
//  Created by Ingrid on 20/11/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SortViewModel {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favorites = [Category]()

    init() {
        loadFavorites()
    }
    
    func loadFavorites() {
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
    }
    
    func saveRace() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
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
        loadFavorites()
    }

}
