//
//  GridCollectionViewCell.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    @IBOutlet var posterImageView: FetchImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var directorName: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var introduction: UILabel!
    
    func setupUI(data: Movie) {
        posterImageView.loadFromURL(urlString: data.artworkUrl100 ?? "")
        movieName.text = data.trackName
        directorName.text = data.directorName
        introduction.text = data.shortDescription
        year.text = data.getDateString(input: data.releaseDate ?? "")
    }
}
