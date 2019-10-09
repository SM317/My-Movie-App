//
//  MovieListCustomCell.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListCustomCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    func configure(_ movie: Movie) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: movie.posterURL)
        
        titleLabel.text = movie.title
        
        if movie.ratingText.isEmpty {
            ratingLabel.text = dateFormatter.string(from: movie.releaseDate)
        } else {
            ratingLabel.text = movie.ratingText

        }
    }
}
