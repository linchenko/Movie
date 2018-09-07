//
//  MovieTableViewController.swift
//  MovieAPI
//
//  Created by Levi Linchenko on 07/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBarOutlet: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarOutlet.delegate = self
        tableView.prefetchDataSource = self
        
        
        MovieController.shared.fetchMovie(movie: "Wolf of wall street") { (success) in
            if success{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

 

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.shared.movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        let movie = MovieController.shared.movies[indexPath.row]
        cell?.movie = movie
        return cell ?? UITableViewCell()
    }
 

   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let movie = self.searchBarOutlet.text else {return}
        guard movie != "" else {return}
        MovieController.shared.fetchMovie(movie: movie) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}


extension MovieTableViewController: UITableViewDataSourcePrefetching{
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            let movie = MovieController.shared.movies[indexPath.row]
            let baseImageURL = MovieController.shared.baseImageURL
            guard let imageURL = movie.imageURLComponent else {return}
            guard let url = baseImageURL?.appendingPathComponent(imageURL) else {print("Bad Image URL"); return}
            URLSession.shared.dataTask(with: url).resume()
            
            
            
        }
    }
    
    
    
    
    
}
