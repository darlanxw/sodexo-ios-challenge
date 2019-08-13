//
//  MovieTableViewCell.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var cellInnerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var votesNumberLabel: UILabel!
    @IBOutlet weak var votesIcon: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellInnerView.setRoundedCorner()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }        
    
    func configure(_ ttMovie: TraktTMDBMovie?) {
        if let movie = ttMovie {
            changeVisibility(alpha: 1)
            activityIndicator.stopAnimating()
            
            movieNameLabel.text = movie.popMovie?.title ?? "No title"
            votesNumberLabel.text = "\(movie.tmdb.voteCount ?? 0)"
            backgroundImageView.imageFromUrl(url: movie.tmdb.backdropPath ?? "")
        } else {
            changeVisibility()
            activityIndicator.startAnimating()
        }
    }
    
    private func changeVisibility(alpha: CGFloat = 0) {
        movieNameLabel.alpha = alpha
        votesNumberLabel.alpha = alpha
        votesIcon.alpha = alpha
        backgroundImageView.alpha = alpha
    }
}
