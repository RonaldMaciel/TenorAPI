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
    var gifs: [URLGif] = []
    
    let dispatchSemaphore = DispatchSemaphore(value: 1)
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        DispatchQueue.global(qos: .background).async {
            
            self.dispatchSemaphore.wait()
            print("First Request Started")
            self.loadGif {
                print("Done!")
                self.dispatchSemaphore.signal()
            }
            
            
            self.dispatchSemaphore.wait()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Finished")
                self.dispatchSemaphore.signal()
            }
            
            
        }
        
    }
    
    
    func loadGif(callback: @escaping () -> Void) {
        self.request.getGifURL { (gifs) in
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
    
    
}



//extension UIImage {
//
//    public class func gif(data: Data) -> UIImage? {
//        // Create source from data
//        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
//            print("SwiftGif: Source for the image does not exist")
//            return nil
//        }
//
//        return UIImage.animatedImageWithSource(source)
//}


