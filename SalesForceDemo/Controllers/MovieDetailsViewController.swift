//
//  MovieDetailsViewController.swift
//  SalesForceDemo
//
//  Created by Saikumar Kankipati on 2/15/20.
//  Copyright © 2020 Saikumar Kankipati. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieDetail: Movie?
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var posterImageView: FetchImageView!
    @IBOutlet var directorNameLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var introLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        posterImageView.loadFromURL(urlString: movieDetail?.artworkUrl100 ?? "")
        movieNameLabel.text = movieDetail?.trackName
        yearLabel.text = movieDetail?.getDateString(input: movieDetail?.releaseDate ?? "")
        directorNameLabel.text = movieDetail?.directorName
        introLabel.text = movieDetail?.shortDescription
    }
}
