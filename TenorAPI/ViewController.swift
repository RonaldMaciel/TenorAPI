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
    var gifs : [Any] = []
    
    
    let dispatchGroup = DispatchGroup()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DispatchQueue.global().async {
            
            self.dispatchGroup.enter()
            
            print("First request started")
            self.loadGif {
                self.dispatchGroup.leave()
                print("terminou")
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



