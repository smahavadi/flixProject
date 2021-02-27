//
//  MovieGridDetailsViewController.swift
//  flixProject
//
//  Created by Suma Valli on 2/26/21.
//

import UIKit

class MovieGridDetailsViewController: UIViewController {

    var movie: [String: Any]!
    
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting the title label and sizing it appropriately
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        // setting the synopsis label and sizing it appropriately
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        // getting base URL
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        // getting poster url from  from movie object
        let posterPath = movie["poster_path"] as! String
        // adding base url and poster url
        let posterUrl = URL(string: baseUrl + posterPath)!
        // sending poster image to image view in storyboard
        posterView.af.setImage(withURL: posterUrl)
        
        // getting backdrop url from  from movie object
        let backdropPath = movie["backdrop_path"] as! String
        // adding base url and backdrop url
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        // sending backdrop image to image view in storyboard
        backdropView.af.setImage(withURL: backdropUrl)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Pass movie to details view controller
        let detailsViewController = segue.destination as! TrailerViewController
        detailsViewController.movieId = movie["id"] as? String
        print(detailsViewController.movieId)
        
    }
    

    @IBAction func goToTrailer(_ sender: UITapGestureRecognizer) {
        
        //add code here
        //let location = sender.location(in: view)
        // The didTap: method will be defined in Step 3 below.
        let tapGestureRecognizer = UITapGestureRecognizer()

         // Optionally set the number of required taps, e.g., 2 for a double click
         tapGestureRecognizer.numberOfTapsRequired = 1

         // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
         posterView.isUserInteractionEnabled = true
         posterView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
}
