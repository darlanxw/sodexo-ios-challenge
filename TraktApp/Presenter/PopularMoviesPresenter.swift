//
//  PopularMoviesPresenter.swift
//  TraktApp
//
//  Created by objective on 12/08/19.
//  Copyright © 2019 Thiago Lourin. All rights reserved.
//

import Foundation

protocol PresenterDelegate: class {
    func reloadTable(movieList: [Movie])
    func showLoading()
    func hideLoading()
}

class PopularMoviesPresenter {
    
    var apiClient: TraktAPIClientProtocol    
    
    weak var delegate: PresenterDelegate?
    
    init(apiClient: TraktAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchPopularMovies() {
        self.delegate?.showLoading()
        let request = PopularMovieRequest()
        apiClient.requestList(request) { [weak self] (resultList) in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.hideLoading()
            switch (resultList) {
            case .success(let responseList) :
                let popMovieList = responseList as! [Movie]
                strongSelf.delegate?.reloadTable(movieList: popMovieList)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
