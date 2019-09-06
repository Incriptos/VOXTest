//
//  NetworkManager.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation


class NetworkManager {
  
  // https://theaudiodb.com/api/v1/json/1/searchalbum.php?s=post_malone&a=stoney
  
  func request(artistName: String, albumName: String, completion: @escaping (Data?, Error?) -> Void) {
  
    let params = prepareParams(artistName: artistName, albumName: albumName)
    let url = createURL(params: params)
    var request = URLRequest(url: url)
    request.httpMethod = "get"
    let task = createDataTask(from: request, completion: completion)
    task.resume()
    print(url)
  }
  
  private func prepareParams(artistName: String?, albumName: String? ) -> [String: String] {
    var params = [String: String]()
    params["s"] = artistName
    params["a"] = albumName
    return params
  }
  
  private func createURL(params: [String: String]) -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "theaudiodb.com"
    components.path = "/api/v1/json/1/searchalbum.php"
    components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
    return components.url!
  }
  
  private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
    return URLSession.shared.dataTask(with: request, completionHandler: { (data, respons, error) in
      DispatchQueue.main.async {
        completion(data, error)
      }
    })
  }
  
}

