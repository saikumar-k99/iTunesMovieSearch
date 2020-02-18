//
//  FavoritesManager.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/16/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

struct FavoriteUtility {
    static func saveToFavourites(movie: Movie, callBack: ((_ isSuccess: Bool) -> Void)) {
        var savedFavorites: Set<Movie> = []
        
        if let data = UserDefaultsHelper.retrieveFromUserDefaults(UserDefaultsHelper.key) as? Data {
            let moviesList = try? PropertyListDecoder().decode(Set<Movie>.self, from: data)
            savedFavorites = moviesList ?? Set<Movie>()
        }
        
        savedFavorites.insert(movie)
    
          do {
            let data = try PropertyListEncoder().encode(savedFavorites)
            UserDefaultsHelper.saveToUserDefaults(UserDefaultsHelper.key, value: data)
            callBack(true)
          } catch {
            print("Save Failed")
            callBack(false)
          }
    }
    
    static func retrieveSavedFavorites() -> Set<Movie> {
         var savedFavorites: Set<Movie> = []
         
         if let data = UserDefaultsHelper.retrieveFromUserDefaults(UserDefaultsHelper.key) as? Data {
             let moviesList = try? PropertyListDecoder().decode(Set<Movie>.self, from: data)
             savedFavorites = moviesList ?? Set<Movie>()
         }
         
         return savedFavorites
     }
}
