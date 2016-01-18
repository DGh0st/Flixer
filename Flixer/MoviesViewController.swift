//
//  MoviesViewController.swift
//  Flixer
//
//  Created by DGh0st on 1/16/16.
//  Copyright © 2016 DGh0st. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var moviesBar: UISearchBar!
    
    var movies: [NSDictionary]?
    var filteredMovies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        moviesBar.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.setContentOffset(CGPoint(x: 0, y: moviesBar.frame.height), animated: false)
        
        self.filteredMovies = self.movies
        
        loadDataFromNetwork()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = filteredMovies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = filteredMovies![indexPath.row]
        let baseURL = "http://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let imageURL = NSURL(string: baseURL + posterPath)
        let imageRequest = NSURLRequest(URL: imageURL!)
        let title = movie["title"] as! String
        cell.titleLabel?.text = title
        cell.overviewLabel.text = movie["overview"] as? String
        cell.posterView.setImageWithURLRequest(imageRequest, placeholderImage: nil, success: { (imageRequest, imageResponse, image) -> Void in
                if imageResponse != nil {
                    cell.posterView.alpha = 0.0
                    cell.posterView.image = image
                UIView.animateWithDuration(1.0, animations: {
                    cell.posterView.alpha = 1.0
                })
            } else {
                cell.posterView.image = image
            }
        }, failure: { (imageRequest, imageResponse, error) -> Void in
            cell.posterView.image = nil
        });
        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl){
        loadDataFromNetwork()
        refreshControl.endRefreshing()
    }
    
    func loadDataFromNetwork() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    self.networkErrorView.hidden = true
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                } else {
                    self.movies = nil
                    self.networkErrorView.hidden = false
                }
                self.filteredMovies = self.movies
        });
        task.resume()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredMovies?.removeAll()
        if searchText != "" && networkErrorView.hidden == true {
            for movie in self.movies! {
                if (movie["title"] as! String).lowercaseString.containsString(searchText.lowercaseString) {
                    self.filteredMovies?.insert(movie, atIndex: (filteredMovies?.endIndex)!)
                }
            }
        } else {
            self.filteredMovies = self.movies
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.setContentOffset(CGPoint(x: 0, y: moviesBar.frame.height), animated: true)
    }
    
    @IBAction func tappedView(sender: AnyObject) {
        self.moviesBar.resignFirstResponder()
        if networkErrorView.hidden == false || self.filteredMovies! == self.movies! {
            tableView.setContentOffset(CGPoint(x: 0, y: moviesBar.frame.height), animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
