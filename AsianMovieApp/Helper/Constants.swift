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
        static let requestURL = ".json"
        static let apiKey = "8eac22f4c24d01c480e4d99fef2edfc3"
        static let baseAPIURL = "https://api.themoviedb.org/3"
    }
    
    enum Color
    {
        static let primaryColor  = UIColor.init(hexString: "#50E3C2")
        static let primaryLighterColor = UIColor.init(hexString: "#DEF5EF")
        static let secondaryColor = UIColor.lightGray
        static let contactLabelColor =  UIColor.init(hexString: "#4A4A4A")
    }
    
    enum Length
    {
        static let phoneNumber: Int = 13
    }
    
    
    enum TableIdentifier
    {
        static let movieCell = "movieCell"
    }
    
    enum TableConstants
    {
        static let CELLHEIGHT : CGFloat = 64.0
    }
    
    enum TableCustomCell
    {
        static let movie  = "MovieCell"
    }
    
    enum Images
    {
        static let customLoader  = "customLoader"
    }
    
}
