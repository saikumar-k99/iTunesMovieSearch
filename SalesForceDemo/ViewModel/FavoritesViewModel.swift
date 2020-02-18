//
//  FavoritesViewModel.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

class FavoritesViewModel {
    lazy var favoriteModel: FavoriteMovies? = { return FavoriteMovies() }()
    
    func getFavoriteMoviesFromUserDefaults(completionHandler: @escaping ((_ isSuccess: Bool) -> Void)) {
        if FavoriteUtility.retrieveSavedFavorites().count > 0 {
            let favoriteSet = FavoriteUtility.retrieveSavedFavorites()
            favoriteModel?.favorites = Array(favoriteSet)
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
}
