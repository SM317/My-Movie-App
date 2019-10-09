//
//  MovieListViewController.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import UIKit

class MovieListViewController: BaseViewController {

      @IBOutlet weak var searchBar: UISearchBar!
      @IBOutlet var collectionView: UICollectionView!
      @IBOutlet var infoLabel: UILabel!

      fileprivate var movieList: [Movie] = []
      fileprivate var movieListSearch: [Movie] = []
      fileprivate  var movieListSections: [MovieListSection] = []
      fileprivate  var selectedContactURL: String?
      fileprivate var isSearchActive : Bool = false
      fileprivate var pageindex: Int = 1
      fileprivate var totalPages : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: Constants.TableCustomCell.movie, bundle: nil), forCellWithReuseIdentifier: Constants.TableIdentifier.movieCell)
        fetchMovies()
        // Do any additional setup after loading the view.
    }
    
    /**
     This method is used to get all the Movies from the server
     */
    private func fetchMovies()
    {
        self.showCustomLoader()
        DispatchQueue.main.async(execute: {
            MovieController.movies(pageIndex: self.pageindex, withCompletion: { result in
                switch result {
                case .success(let allMovie):
                    self.hideCustomLoader()
                    self.movieList.append(contentsOf: allMovie.results)
                    self.totalPages = allMovie.totalPages
                    self.movieListSections = MovieController.getAllMoviesWithIndex(movies: self.movieList)
                    self.refreshUI()
                case .failure(let error):
                    self.hideCustomLoader()
                    self.ShowError(error.localizedDescription)
                }
            })
        })
    }
    
    
    /**
     This method is used to refresh the UI after the api call
     */
    private func refreshUI() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {
                return
            }
            self?.hideCustomLoader()
            weakSelf.collectionView.reloadData()
        }
    }
    
    /**
     This method is used to hide the keyboard
     */
    private func hideKeyboard()
    {
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
    }

}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.TableIdentifier.movieCell, for: indexPath) as! MovieListCustomCell
        let movie = movieList[indexPath.item]
        cell.configure(movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetailVC = storyboard!.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailsViewController
        
        //movieDetailVC.movieId = movies[indexPath.item].id
        present(movieDetailVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            if indexPath.row == movieList.count / 2 - 1 {  //numberofitem count
                if pageindex < totalPages
                {
                    pageindex += 1
                    fetchMovies()
                }
        }
    }
    
}

//MARK:- UISearchBarDelegate & UISearchResultsUpdating
extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        {
            if(movieListSearch.count > 0)
            {
                movieListSearch.removeAll()
            }
            movieListSearch = movieList.filter({( movie : Movie) -> Bool in
                    return  movie.title.lowercased().contains(searchText.lowercased())
            })
            if (movieListSearch.count > 0)
            {
                self.movieListSections.removeAll()
                self.movieListSections = MovieController.getAllMoviesWithIndex(movies: self.movieList)
            }
            if searchText.count == 0
            {
               self.hideKeyboard()
                self.movieListSections.removeAll()
                self.movieListSections = MovieController.getAllMoviesWithIndex(movies: self.movieList)
            }
            collectionView.reloadData()
        }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
         self.searchBar.showsCancelButton = true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool
    {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
       self.hideKeyboard()
        self.movieListSearch.removeAll()
        self.movieListSections.removeAll()
        self.movieListSections = MovieController.getAllMoviesWithIndex(movies: self.movieList)
        self.refreshUI()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.hideKeyboard()
    }
}
