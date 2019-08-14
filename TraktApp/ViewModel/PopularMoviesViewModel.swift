//
//  PopularMoviesViewModel.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func reloadTable(movieList: TraktTMDBMovie)
    func showLoading()
    func hideLoading()
}

class PopularMoviesViewModel {
    
    var apiClient: TraktAPIClientProtocol    
    
    weak var delegate: ViewModelDelegate?
    
    init(apiClient: TraktAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchPopularMovies() {
        self.delegate?.showLoading()
        let request = PopularMovieRequest()
        apiClient.requestList(request) { [weak self] (resultList) in
            guard let strongSelf = self else { return }
            switch (resultList) {
            case .success(let responseList) :
                let popMovieList = responseList as! [Movie]
                strongSelf.fetchTMDB(movieList: popMovieList)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func fetchTMDB(movieList: [Movie]) {
        for each in movieList {
            let request = TMDBMovieRequest(id: each.ids.tmdb)
            apiClient.requestObject(request) { [weak self] (result) in
                guard let strongSelf = self else { return }
                switch (result) {
                case .success(let response):
                    let movie = response as! TMDBMovie
                    
                    let ttMovie = TraktTMDBMovie(popMovie: each, tmdb: movie)                    
                    strongSelf.delegate?.reloadTable(movieList: ttMovie)
                    strongSelf.delegate?.hideLoading()
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
        
    }
}
