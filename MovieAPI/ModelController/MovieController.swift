//
//  MovieController.swift
//  MovieAPI
//
//  Created by Levi Linchenko on 07/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class MovieController {
    
    static let shared = MovieController()
    
    private init () {}
    
    var movies: [Movie] = []
    
    let baseURL = "https://api.themoviedb.org/3"
    
    func fetchMovie(movie: String, completion: @escaping (_ success: Bool) -> Void){
        
        guard let url = URL(string: baseURL) else { fatalError("Bad URL") }
        let newURL = url.appendingPathComponent("search").appendingPathComponent("movie")
        
        var components = URLComponents(url: newURL, resolvingAgainstBaseURL: true)
        
        let  queryItem = URLQueryItem(name: "api_key", value: "ebbdfa6557b575564ac2d754db0b0406")
        let queryItem2 = URLQueryItem(name: "query", value: movie)
        
        components?.queryItems = [queryItem, queryItem2]
        guard let builtURL = components?.url else {completion(false); return}
        print(builtURL)
        
        URLSession.shared.dataTask(with: builtURL) { (data, _, error) in
            
            if let error = error {completion(false); print(error, #function); return}
            
            guard let data = data else {print("No data!!!"); completion(false); return}
            
            do{
                let movies = try JSONDecoder().decode(JSONDictionary.self, from: data)
                self.movies = movies.movies
                completion(true)
            }  catch {
                print("There was an error in \(#function) \(error) \(error.localizedDescription)")
//                completion(false); return
            }
        }.resume()
        
    }
    
    let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500/")
    
    func fetchImage(movie: Movie, completion: @escaping (UIImage?) -> Void){
        
        guard let imageURL = movie.imageURLComponent else {return}
        guard let url = baseImageURL?.appendingPathComponent(imageURL) else {print("Bad Image URL"); return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {completion(nil); print(error, #function); return}
            guard let data = data else {print("No data!!!"); completion(nil); return}
            
            let image = UIImage(data: data)
            completion(image)

        }.resume()
    }
    
}
