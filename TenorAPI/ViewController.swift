//
//  ViewController.swift
//  TenorAPI
//
//  Created by Ronald Maciel on 27/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let request = Request()
    var gifs : [URLGif] = []
    
    
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        
        DispatchQueue.global(qos: .unspecified).async {
            
            self.dispatchGroup.enter()
            
            print("First request started")
            self.loadGif {
                print("terminou")
                self.dispatchGroup.leave()
            }
            
            self.dispatchGroup.notify(queue: .main) {
                //quando completar
                
                print("acabou tudo")
                self.tableView.reloadData()
            }
        }
    }
    
    
    func loadGif(callback: @escaping () -> Void) {
        request.getGifURL { (gifs) in
            self.gifs = gifs
            callback()
        }
    }
    
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell {
            
            let gif_url = gifs[indexPath.row].url
            cell.gif.load(url: URL(string: gif_url)!)
            
            
            return cell
        }
        
        return UITableViewCell()
        
        
    }
    
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    
    func loadGif(url: String){
        DispatchQueue.global().async { [weak self] in
            
        }
    }
}



