//
//  MovieController.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import Foundation
import UIKit


/*### MovieProvider

Provides methods for fetching the Movie list from the server
*/
public struct MovieController {
    
    static let movieUrl = "/trending/movie/week?api_key=" + Constants.Config.apiKey
    /**
     Get all movies
     - parameter completion:         Completion closure expression
     */
    @discardableResult static  func movies(pageIndex : Int,withCompletion completion: @escaping (MovieHttpResponse<MoviesResponse>) -> Void) -> URLSessionDataTask? {
                
        let url = Constants.Config.baseAPIURL + movieUrl + "&page=" + String(pageIndex)
            return APIClient.request(from: url, with: [:], methodType: Constants.APIMethodType.get, withCompletion: { (result: MovieHttpResponse<Data>) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let list = try? decoder.decode(MoviesResponse.self, from: data)
                if let movieObject = list{
                      completion(.success(movieObject))
                }
            case .failure(_):
                completion(.failure(MovieError.noData))
            }
        })
    }
    
    /**
        Get all movies with index titles
        - parameter movies:         Array of all the movies get from above method
        */
       static func getAllMoviesWithIndex(movies : [Movie]) -> [MovieListSection]
       {
           let sortedMovies = movies.sorted(by: { $0.title < $1.title })
           let sectionTitles = UILocalizedIndexedCollation.current().sectionTitles
           var calicutaingSections: [MovieListSection] = []
           for title in sectionTitles {
            let movies = sortedMovies.filter({ $0.title.capitalized.hasPrefix(title)})
            let section = MovieListSection.init(sectionTitle: title, movies: movies)
               calicutaingSections.append(section)
           }
           return calicutaingSections
       }

}