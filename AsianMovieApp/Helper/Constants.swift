//
//  Constants.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import Foundation
import UIKit

 struct Constants {
    
    enum Config {
        static let apiKey                 = "8eac22f4c24d01c480e4d99fef2edfc3"
        static let baseAPIURL             = "https://api.themoviedb.org/3"
        static let posterURL              = "https://image.tmdb.org/t/p/w500"
        static let backDropURL            = "https://image.tmdb.org/t/p/original"
        static let youtubeURL             = "https://www.youtube.com/embed/"
    }
    
    enum Color
    {
        static let primaryColor           = UIColor.init(hexString: "#50E3C2")
        static let primaryLighterColor    = UIColor.init(hexString: "#DEF5EF")
        static let secondaryColor         = UIColor.lightGray
        static let contactLabelColor      =  UIColor.init(hexString: "#4A4A4A")
        static let Theame_TextColor_Gray  = UIColor.init(hexString: "#445356")
    }
    
    enum TableIdentifier
    {
        static let movieCell              = "movieCell"
    }
    
    enum TableConstants
    {
        static let CELLHEIGHT : CGFloat   = 200.0
    }
    
    enum TableCustomCell
    {
        static let movie                  = "MovieListCell"
    }
    
    enum APIMethodType{
        static let get                    = "GET"
    }
    
    enum Images
    {
        static let customLoader           = "customLoader"
    }
    
    enum Strings{
        static let applicationJson        = "application/json"
        static let contentType            = "Content-Type"
        static let DATA                   = "data"
        static let titleMovie             = "Movies List"
        static let titleMovieDetail       = "Movie Details"
        static let overviewText           = "Overview : "
        static let languageText           = "Language : "
        static let releaseDateText        = "Release date: "
        static let pullRefreshText        = "Pull to refresh"
        static let directorText           = "Director: "
        static let castText               = "Cast: "
    }
    
    enum StoryBoardIdentifier{
        static let movieDetail            = "viewDetailController"
    }
    
    public static func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    public static func parseObjectDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
