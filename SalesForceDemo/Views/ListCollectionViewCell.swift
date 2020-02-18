//
//  ListCollectionViewCell.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

protocol ListCollectionViewCellDelegate: class {
    func favoriteButtonTapped(sender: Movie)
}

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: FetchImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var directorName: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var introduction: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    weak var cellDelegate: ListCollectionViewCellDelegate?
    var movie: Movie?
    
    var toggleImage: ((_ data: Movie) -> Void)?
    
    func setupUI(data: Movie) {
        movie = data
        posterImageView.loadFromURL(urlString: data.artworkUrl100 ?? "")
        movieName.text = data.trackName
        directorName.text = data.directorName
        introduction.text = data.shortDescription
        
        year.text = data.getDateString(input: data.releaseDate ?? "")
        
        if data.isFavorite {
            favoriteButton.setImage(UIImage(named: "tab-star"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "star-white"), for: .normal)
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let delegate = cellDelegate, let movie = movie else {
            return
        }
        
        if !movie.isFavorite {
            favoriteButton.setImage(UIImage(named: "tab-star"), for: .normal)
            movie.isFavorite = true
        }
    
        delegate.favoriteButtonTapped(sender: movie)
    }
}
