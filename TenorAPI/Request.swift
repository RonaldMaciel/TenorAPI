//
//  Request.swift
//  TenorAPI
//
//  Created by Ronald Maciel on 27/08/19.
//  Copyright © 2019 Ronald Maciel. All rights reserved.
//


import Foundation

struct Gif: Codable {
    let url: String
    
    init(json: [String : Any]) {
        self.url = json["url"] as? String ?? ""
    }
}

struct Results: Codable{
    let results: [Media]
    
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
}

struct Media: Codable {
    let media: [MediaResult]
    
    private enum CodingKeys: String, CodingKey {
        case media
    }
}

struct MediaResult: Codable {
    let tinyGif: URLGif
    
    private enum CodingKeys: String, CodingKey {
        case tinyGif = "tinygif"
    }
}

struct URLGif: Codable{
    let url: String
}



class Request {
    let url = URL(string: "https://api.tenor.com/v1/search?q=excited&key=NXETZHW6WDI9&limit=50")
    
    let trending_url = URL(string: "https://api.tenor.com/v1/trending?key=NXETZHW6WDI9&limit=8")
    
    func getGifURL(completion: @escaping ([URLGif]) -> () ) {
        
        if let url = self.trending_url {
            let task = URLSession.shared.dataTask(with: url) {(nsData, urlResponse, error) in
                var urlGifs: [URLGif] = []
                
                if error == nil {
                    if let backData = nsData {
                        do {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(Results.self, from: backData)
                            
                            
                            
                            if let renan = response?.results {
                                for media in renan{
                                    for tinyGif in media.media {
                                        urlGifs.append(tinyGif.tinyGif)
                                    }
                                }
                            }
                            
                           
                        } catch {
                            print(error.localizedDescription)
                        }
                        completion(urlGifs)
                    }
                }
                print(urlGifs)
            }
            
            task.resume()
        }
        
    }
    
    
    
    
    
}
