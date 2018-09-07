//
//  Movie.swift
//  MovieAPI
//
//  Created by Levi Linchenko on 07/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import Foundation

struct JSONDictionary: Decodable {
    let movies:[Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
}

struct Movie: Decodable {
    let title: String
    let releaseDate: String
    let overview: String
    let imageURLComponent: String?
    
    private enum CodingKeys: String, CodingKey{
        case title
        case releaseDate = "release_date"
        case overview
        case imageURLComponent = "poster_path"
    }
    
}
