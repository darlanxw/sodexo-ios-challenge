//
//  PopularMoviesTableViewController.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PopularMoviesTableViewController: UITableViewController, ViewModelDelegate {

    let cellId = "movieCell"
    
    var viewModel: PopularMoviesViewModel!
    private var movieList: [TraktTMDBMovie] = []
    private var selectedMovie: TraktTMDBMovie?
    private var overlay : UIView?
    private var viewLoading : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        
        viewModel = PopularMoviesViewModel(apiClient: TraktAPIClient())
        viewModel.delegate = self
        viewModel.fetchPopularMovies()
    }

    func reloadTable(movieList: TraktTMDBMovie) {
        self.movieList.append(movieList)
        self.tableView.reloadData()
    }
    
    func showError(error: String) {
        let alert = createAlert("Warning", message: error)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTableViewCell
        
        cell.configure(movieList[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedMovie = movieList[indexPath.row]
        performSegue(withIdentifier: "toMovieDetail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMovieDetail") {
            if let dest = segue.destination as? MovieDetailViewController {
                dest.movie = selectedMovie
            }
        }
    }
    
    fileprivate func createAlert(_ title : String, message : String) -> UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    }
}

extension PopularMoviesTableViewController {

    func showLoading() {

        if  let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window {
            overlay = UIView(frame: window.frame)
            
            let viewLoadingYesCgRect = CGRect(x: 0, y: 0, width: window.frame.size.width * 0.150, height: window.frame.size.width * 0.150)
            viewLoading = NVActivityIndicatorView(frame: viewLoadingYesCgRect, type: .circleStrokeSpin, color: UIColor.red, padding: 0.5)
            
            overlay!.center = CGPoint(x: window.frame.width*0.5, y: window.frame.height*0.5)
            overlay!.backgroundColor = UIColor.white
            overlay!.alpha = 0.8
            
            if (self.navigationController?.isNavigationBarHidden == false) {
                viewLoading.center = CGPoint(x: window.frame.width*0.5, y: window.frame.height*0.5-64)
            } else {
                viewLoading.center = CGPoint(x: window.frame.width*0.5, y: window.frame.height*0.5-20)
            }
            
            overlay!.addSubview(viewLoading)
            viewLoading.startAnimating()
        }
        
        if (!(overlay?.isDescendant(of: view))!){
            view.addSubview(overlay!)
        }
        
    }
    
    func hideLoading() {
        if (overlay != nil){
            self.viewLoading.stopAnimating()
            overlay!.removeFromSuperview()
        }
    }
    
}
