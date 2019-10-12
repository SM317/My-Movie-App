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
        movieImage.layer.borderColor = Constants.Color.primaryColor.cgColor
        movieImage.layer.borderWidth = 5.0
        
        titleLabel.text = movie.title
        castLabel.text =  Constants.Strings.overviewText + movie.overview
        
        if let date = movie.releaseDate
        {
            directorLabel.text = Constants.Strings.releaseDateText + date
        }
        ratingLabel.text = movie.ratingText
        
    }
    
}
