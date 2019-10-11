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
      @IBOutlet weak var movieListTableView: UITableView!
      @IBOutlet var infoLabel: UILabel!

       var movieList: [Movie] = []
       var movieListTemp: [Movie] = []
       var movieListSearch: [Movie] = []
       var movieListSections: [MovieListSection] = []
       var isSearchActive : Bool = false
       var pageindex: Int = 1
       var totalPages : Int = 0
       var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Constants.Strings.titleMovie
        
         self.movieListTableView!.register(UINib.init(nibName: Constants.TableCustomCell.movie, bundle: nil), forCellReuseIdentifier: Constants.TableIdentifier.movieCell)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        movieListTableView.addSubview(refreshControl)
        fetchMovies()
        // Do any additional setup after loading the view.
    }
    
    @objc func refresh(sender:AnyObject) {
        self.pageindex = 1
        fetchMovies()
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
                    self.clearData()
                    self.movieListTemp.append(contentsOf: allMovie.results)
                    self.movieList.append(contentsOf: self.movieListTemp.unique{$0.id})
                    self.totalPages = allMovie.totalPages
                    self.movieListSections = MovieController.getAllMoviesWithIndex(movies: self.movieList)
                    self.refreshUI()
                case .failure(let error):
                    self.refreshControl.endRefreshing()
                    self.hideCustomLoader()
                    self.ShowError(error.localizedDescription)
                }
            })
        })
    }
    
    private func clearData()
    {
        if self.movieListSections.count > 0{
            self.movieListSections.removeAll()
        }
        if self.movieList.count > 0{
            self.movieList.removeAll()
        }
    }
    
    private func loadMoreData()
    {
        self.pageindex += 1
        fetchMovies()
    }
    
    /**
     This method is used to refresh the UI after the api call
     */
    private func refreshUI() {
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else {
                return
            }
            self?.refreshControl.endRefreshing()
            self?.hideCustomLoader()
            weakSelf.movieListTableView.reloadData()
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

extension MovieListViewController: UITableViewDataSource {
     // MARK: - UITableview Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieListSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if movieListSections[section].movies.count == 0 {
            return nil
        }
        return movieListSections[section].sectionTitle
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return movieListSections.compactMap({ $0.sectionTitle })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListSections[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell:MovieListCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableIdentifier.movieCell, for: indexPath) as! MovieListCell
        
        let movie = movieListSections[indexPath.section].movies[indexPath.row]
        cell.configure(movie)
        
        let imgseparator1 : UIImageView = UIImageView(frame: CGRect(x: 0, y: Constants.TableConstants.CELLHEIGHT - 1, width: self.view.frame.size.width, height: 1))
        imgseparator1.backgroundColor = Constants.Color.secondaryColor
        cell.addSubview(imgseparator1)
        
        if indexPath.section == movieListSections.count - 1
        {
            self.loadMoreData()
        }
        return cell
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    // MARK: - UITableview Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = movieListSections[indexPath.section].movies[indexPath.row]
       
        let storyBoard : UIStoryboard = AppDelegate.sharedInstance().get_StoryboardMain_Instance()
        let detailController = storyBoard.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifier.movieDetail) as! MovieDetailsViewController
        detailController.movieId = data.id
        self.navigationController?.pushViewController(detailController, animated: true)
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
                self.movieListSections = MovieController.getAllMoviesWithIndex(movies: self.movieListSearch)
            }
            if searchText.count == 0
            {
               self.hideKeyboard()
                self.movieListSections.removeAll()
                self.movieListSections = MovieController.getAllMoviesWithIndex(movies: self.movieList)
            }
            movieListTableView.reloadData()
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
