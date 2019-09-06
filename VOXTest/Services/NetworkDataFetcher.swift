//
//  NetworkDataFetcher.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
  
  var networkManager = NetworkManager()
  
  func fetchAlbums(artistName: String, albumName: String, completion: @escaping (Album?) -> ()) {
    
    networkManager.request(artistName: artistName, albumName: albumName) { (data, error) in
      
      if let error = error {
        print("Error received requesting data: \(error.localizedDescription)")
        completion(nil)
      }
      
      let decoded = self.decodeJSON(type: Album.self, from: data)
      
      completion(decoded)

    }
    
  }
  
  private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
    let decoder = JSONDecoder()
    guard let data = from else { return nil }
    
    do {
      let object = try decoder.decode(type.self, from: data)
      return object
    } catch let jsonError {
      print("Failed to decode JSON", jsonError)
      return nil
    }
  }
  
}

