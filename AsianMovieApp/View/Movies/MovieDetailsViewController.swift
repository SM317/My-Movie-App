//
//  MovieDetailsViewController.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController {
    
    @IBOutlet weak var layoutConstraintsOverviewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingPerLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    var movieId: Int = 0
    var movieObject : Movie?
    var movieVideos : [MovieVideo] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Constants.Strings.titleMovieDetail
        overviewLabel.textColor = Constants.Color.Theame_TextColor_Gray
        yearLabel.textColor = Constants.Color.Theame_TextColor_Gray
        ratingPerLabel.textColor = Constants.Color.Theame_TextColor_Gray
        durationLabel.textColor = Constants.Color.Theame_TextColor_Gray
        genreLabel.textColor = Constants.Color.Theame_TextColor_Gray
        crewLabel.textColor = Constants.Color.Theame_TextColor_Gray
        castLabel.textColor = Constants.Color.Theame_TextColor_Gray
        self.fetchMovieDetail()
        // Do any additional setup after loading the view.
    }
    
    /**
        This method is used to get  Movie Details from the server
        */
       private func fetchMovieDetail()
       {
           self.showCustomLoader()
           DispatchQueue.main.async(execute: {
            MovieController.movieDetail(movieId: self.movieId, withCompletion: { result in
                   switch result {
                   case .success(let movieDetails):
                       self.hideCustomLoader()
                       self.movieObject = movieDetails
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
        
        if  let movie = self.movieObject{
            titleLabel.text = movie.title
            ratingLabel.text = movie.ratingText
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: movie.backdropURL)
            taglineLabel.text = movie.tagline
            overviewLabel.text = Constants.Strings.overviewText + movie.overview
            
            let height = movie.overview.height(constraintedWidth: self.view.frame.size.width - 32, font: overviewLabel.font)
            layoutConstraintsOverviewHeight.constant = height + 20
            yearLabel.text =  Constants.Strings.releaseDateText + (movie.releaseDate ?? "")
            if movie.voteCount == 0 {
                ratingPerLabel.isHidden = true
            } else {
                ratingPerLabel.isHidden = false
                ratingPerLabel.text = movie.voteAveragePercentText
            }
                    
            durationLabel.text = "\(movie.runtime ?? 0) mins"
            if let genres = movie.genres, genres.count > 0 {
                genreLabel.isHidden = false
                genreLabel.text = genres.map { $0.name }.joined(separator: ", ")
            } else {
                genreLabel.isHidden = true
            }
            
            if let casts = movie.credits?.cast, casts.count > 0 {
                castLabel.isHidden = false
                castLabel.text = Constants.Strings.castText + "\(casts.prefix(upTo: 3).map { $0.name }.joined(separator: ", "))"
            } else {
                castLabel.isHidden = true
            }
            
            if let director = movie.credits?.crew.first(where: {$0.job == "Director"}) {
                crewLabel.isHidden = false
                crewLabel.text = Constants.Strings.directorText + "\(director.name)"
            } else {
                crewLabel.isHidden = true
            }
        }
        
    }
}
