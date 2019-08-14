//
//  MovieDetailViewController.swift
//  TraktApp
//
//  Created by objective on 13/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie?
    private var presenter: MovieDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let traktMovie = movie else { return }
        presenter = MovieDetailPresenter(apiClient: TraktAPIClient())
        presenter.delegate = self
        presenter.fetchTMDB(movie: traktMovie)
    }
    
    deinit {
        print("Movie detail is being deinitialized.")
    }
}

extension MovieDetailViewController: DetailPresenterDelegate {
    
    func showDetail(detail: TMDBMovie) {
        self.imageView.imageFromUrl(url: detail.posterPath ?? "")
        self.movieTitleLabel.text = detail.title
        self.genreLabel.text = detail.genres.map{String($0.name)}.joined(separator: ", ")
        self.overviewLabel.text = detail.overview ?? ""
    }
}
