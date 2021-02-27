//
//  MovieGridViewController.swift
//  flixProject
//
//  Created by Suma Valli on 2/26/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var movies = [ [String:Any] ]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // layout configurations
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        //collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3/2)
       // let cellsPerLine: CGFloat = 2
       // let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
                
                

        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            self.movies = dataDictionary["results"] as! [ [String:Any] ]
            self.collectionView.reloadData()
            
           }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        // getting the specific movie from the dictionary
        let movie = movies[indexPath.item]
        
        // getting base URL
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        // getting poster url from  from movie object
        let posterPath = movie["poster_path"] as! String
        // adding base url and poster url
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        // sending poster image to image view in storyboard
        cell.posterView.af.setImage(withURL: posterUrl)
        
        // returning custom cell
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Find selected movie
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        // Pass movie to details view controller
        let detailsViewController = segue.destination as! MovieGridDetailsViewController
        detailsViewController.movie = movie
        
    }

}
