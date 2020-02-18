//
//  ListTableViewCell.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: FetchImageView!
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var directorNameLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var introductionLabel: UILabel!
    
    func setupUI(data: Movie) {
        posterImageView.loadFromURL(urlString: data.artworkUrl100 ?? "")
        movieNameLabel.text = data.trackName
        directorNameLabel.text = data.directorName
        yearLabel.text = data.getDateString(input: data.releaseDate ?? "")
        introductionLabel.text = data.shortDescription
    }
}
