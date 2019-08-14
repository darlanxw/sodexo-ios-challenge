//
//  PopularMoviesTableViewController.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PopularMoviesTableViewController: BaseViewController, PresenterDelegate {

    let cellId = "movieCell"
    
    var presenter: PopularMoviesPresenter!
    private var movieList: [Movie] = []
    private var selectedMovie: Movie?    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.tableFooterView = UIView()
        
        presenter = PopularMoviesPresenter(apiClient: TraktAPIClient())
        presenter.delegate = self
        presenter.fetchPopularMovies()
    }

    func reloadTable(movieList: [Movie]) {
        self.movieList.append(contentsOf: movieList)
        self.tableView.reloadData()
    }
           
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMovieDetail") {
            if let dest = segue.destination as? MovieDetailViewController {
                dest.movie = selectedMovie
            }
        }
    }
}

extension PopularMoviesTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieCell
        
        cell.configure(movieList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedMovie = movieList[indexPath.row]
        performSegue(withIdentifier: "toMovieDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}
