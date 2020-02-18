//
//  SearchResultModel.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import Foundation

public struct SearchResultModel: Codable {
    let resultCount: Int?
    let results: [Movie]?
}

public class Movie: Codable, Hashable {
    let trackId: Int
    let trackName: String?
    let directorName: String?
    let artworkUrl100: String?
    var releaseDate: String?
    let shortDescription: String?
    var isFavorite: Bool = false
    
    private enum CodingKeys:String, CodingKey {
        case trackId, trackName, artworkUrl100, releaseDate, shortDescription, isFavorite
        case directorName = "director"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(trackId, forKey: .trackId)
        try container.encode(trackName, forKey: .trackName)
        try container.encode(directorName, forKey: .directorName)
        try container.encode(artworkUrl100, forKey: .artworkUrl100)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(shortDescription, forKey: .shortDescription)
        try container.encode(isFavorite, forKey: .isFavorite)
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trackId = try values.decode(Int.self, forKey: .trackId)
        trackName = try values.decode(String.self, forKey: .trackName)
        directorName = try values.decodeIfPresent(String.self, forKey: .directorName)
        artworkUrl100 = try values.decode(String.self, forKey: .artworkUrl100)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        isFavorite = try (values.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false)
    }
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return (lhs.trackId == rhs.trackId && lhs.trackName == rhs.trackName && lhs.artworkUrl100 == rhs.artworkUrl100 && lhs.releaseDate == rhs.releaseDate && lhs.shortDescription == rhs.shortDescription && lhs.isFavorite == rhs.isFavorite)
       }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(trackId)
    }
}

extension Movie {
    func getDateString(input: String) -> String? {
        let formatter = DateFormatter()
             formatter.calendar = Calendar(identifier: .iso8601)
             formatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
             let newFormat = DateFormatter()
             newFormat.locale = Locale(identifier: "en_US_POSIX")
             newFormat.dateFormat = "yyyy"
        
        if let date = formatter.date(from: input) {
            return newFormat.string(from: date)
        } else {
            return nil
        }
    }
}

struct FavoriteMovies: Encodable {
    var favorites: [Movie]?
    
    private enum CodingKeys:String, CodingKey {
        case favorites = "favorites_key"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(favorites, forKey: .favorites)
    }
}

extension FavoriteMovies: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        favorites = try values.decode([Movie].self, forKey: .favorites)
    }
}


