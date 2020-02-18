//
//  SearchResultsViewModel.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

class SearchResultsViewModel {
    lazy var worker = { return MoviesWorker() }()
    var dataSourceArray: [Movie]? {
        didSet {
            let cachedMovies = FavoriteUtility.retrieveSavedFavorites()
            updateCachedFavorites(in: Array(cachedMovies))
        }
    }
    
    func updateCachedFavorites(in newResults: [Movie]) {
        var hashMap: [Int: Bool] = [:]
        
        for item in newResults {
            hashMap[item.trackId] = true
        }
        
        if let newSearchArray = dataSourceArray, newSearchArray.count > 0 {
            for movie in newSearchArray {
                if hashMap[movie.trackId] != nil {
                    movie.isFavorite = true
                }
            }
        }
    }
    
    func searchForMovie(queryString: String, response: @escaping ((_ isSuccess: Bool) -> Void)) {
        worker.getMovieSearchResults(queryString: queryString) { (model, error) in
            if error == nil {
                self.dataSourceArray = model?.results
                response(true)
            } else {
                response(false)
            }
        }
    }
    
    func favoriteButtonTapped(movie: Movie) {
        FavoriteUtility.saveToFavourites(movie: movie) { (isSuccess) in }
    }
}


