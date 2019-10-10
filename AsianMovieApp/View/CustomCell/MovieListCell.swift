//
//  MovieListCell.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 10/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListCell: UITableViewCell {

      @IBOutlet var movieImage: UIImageView!
      @IBOutlet var titleLabel: UILabel!
      @IBOutlet var ratingLabel: UILabel!
      @IBOutlet var directorLabel: UILabel!
      @IBOutlet var castLabel: UILabel!
      
      private let dateFormatter: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateStyle = .long
          formatter.timeStyle = .none
          
          return formatter
      }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = Constants.Color.contactLabelColor
        ratingLabel.textColor = Constants.Color.contactLabelColor
        directorLabel.textColor = Constants.Color.contactLabelColor
        castLabel.textColor = Constants.Color.contactLabelColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ movie: Movie) {
        movieImage.kf.indicatorType = .activity
        movieImage.kf.setImage(with: movie.posterURL)
        
        titleLabel.text = movie.title
        castLabel.text =  "Overview : " + movie.overview
        
        if let lang = movie.originalLanguage
        {
             directorLabel.text = "Language : " + lang
        }
       
        if movie.ratingText.isEmpty {
            ratingLabel.text = dateFormatter.string(from: movie.releaseDate)
        } else {
            ratingLabel.text = movie.ratingText

        }
    }
    
}
