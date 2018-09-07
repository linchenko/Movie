//
//  MovieTableViewCell.swift
//  MovieAPI
//
//  Created by Levi Linchenko on 07/09/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var releasedOutlet: UILabel!
    @IBOutlet weak var overviewOutlet: UILabel!
    
    
    
    var movie: Movie?{
        didSet {
            updateView()
        }
    }
    
    
    func updateView(){
        guard let movie = movie else {return}
        titleOutlet.text = movie.title
        releasedOutlet.text = movie.releaseDate
        overviewOutlet.text = movie.overview
        MovieController.shared.fetchImage(movie: movie) { (image) in
            DispatchQueue.main.async {
                self.imageOutlet.image = image
            }
        }
    }

}
