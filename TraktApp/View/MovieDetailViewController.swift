//
//  MovieDetailViewController.swift
//  TraktApp
//
//  Created by objective on 13/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: TraktTMDBMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.imageFromUrl(url: movie?.tmdb.backdropPath ?? "")
        self.movieTitleLabel.text = movie?.popMovie?.title ?? "No title"
        self.overviewLabel.text = movie?.tmdb.overview ?? "No overview for this movie."
    }
    
    deinit {
        print("Movie detail is being deinitialized.")
    }
}
