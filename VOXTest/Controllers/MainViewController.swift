//
//  MainViewController.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  let fetcher = NetworkDataFetcher()
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      view.backgroundColor = .orange
      
      fetcher.fetchAlbums(artistName: "post_malone", albumName: "stoney") { (result) in
        print(result)
      }
      
    }
  
}
