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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.loadGif {
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



