//
//  DetailsVC.swift
//  Searching Movie App
//
//  Created by MAC on 19.08.2022.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var imageViewMovie: UIImageView!
 
    
    var movieList: MovieM?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let m = movieList {
            labelYear.text = m.Year
            labelType.text = m.Type
            self.navigationItem.title = m.Title
            if let url = URL(string: m.Poster!) {
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    
                    DispatchQueue.main.async {
                        self.imageViewMovie.image = UIImage(data: data!)
                    }
                }
            }
        }
        
    }
    

    
}
