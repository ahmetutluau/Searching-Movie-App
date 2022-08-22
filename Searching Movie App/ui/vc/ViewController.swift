//
//  ViewController.swift
//  Searching Movie App
//
//  Created by MAC on 19.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movieList = [MovieM]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
   
    func setup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    }
    
    func searchMovie(searchedMovie : String) {
        self.showspinner()
        guard let url = URL(string: "http://www.omdbapi.com/?apikey=c1e8e66&s="+searchedMovie) else {
            self.showAlert(Title: "Alert", Message: "Movie not found")
            DispatchQueue.main.async {
                self.tableView.isHidden = true
            }
            self.removeSpinner()
            return
        }
         
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            
            if error != nil || data == nil {
                self.showAlert(Title: "Alert", Message: "Error")
                print("Error:(")
                return
            }
            do {
                let response = try  JSONDecoder().decode(MovieResponse.self , from : data!)
                
                if let recievedMovieList = response.Search {
                    
                    self.movieList = recievedMovieList
                    
                }
                
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
                
            }catch {
                print(error.localizedDescription)
                self.showAlert(Title: "Alert", Message: "Error")
            }
        }.resume()
  
    }
    
    @IBAction func onTappedSearchButton(_ sender: UIButton) {
        
        guard let text = searchBar.text, !text.isEmpty,  text != "" else {
            self.tableView.isHidden = true
            self.showAlert(Title: "Alert", Message: "Please enter movie name")
            return }
        if let searchTextModified = searchBar.text?.replacingOccurrences(of: " ", with: "+") {
            searchMovie(searchedMovie: searchTextModified)
            self.tableView.isHidden = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! TableViewCell
        cell.labelName.text = movie.Title
        cell.labelType.text = movie.Type
        cell.labelYear.text = movie.Year
        
        if let url = URL(string: movie.Poster!) {
            let data = try? Data(contentsOf: url)
            if let data = data {
                DispatchQueue.main.async {
                    cell.imageViewMovie.image = UIImage(data: data)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as! Int?
        let destinationVC = segue.destination as! DetailsVC
        destinationVC.movieList = movieList[index!]
    }
 
}


