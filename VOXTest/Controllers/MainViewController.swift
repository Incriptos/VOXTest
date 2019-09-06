//
//  MainViewController.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var albumimageview: UIImageView!
    
  private let fetcher = NetworkDataFetcher()
  
 private var artistName = ""
 private var albumName = ""
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigation()
    navigationController?.navigationBar.isHidden = true
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .lightGray
    searchTextField.delegate = self
    searchButton.isEnabled = false
    
  }
  
 private func setupNavigation() {
    let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
    topBar.backgroundColor = .white
    topBar.layer.shadowColor =  UIColor.black.cgColor
    topBar.layer.shadowOpacity = 0.3
    topBar.layer.shadowOffset = CGSize.zero
    topBar.layer.shadowRadius = 8
    self.view.addSubview(topBar)
  }
  
  private func fetchData() {
    fetcher.fetchAlbums(artistName: artistName, albumName: albumName) { [weak self] (result) in
      
      guard let imgSrt = result!.album.first?.strAlbumThumb else { return }
      self?.albumimageview.downloaded(from: imgSrt)
    }
  }
  
  func separateSearch() {
      let userSearch = searchTextField.text!
      let separators = CharacterSet(charactersIn: "-:|~//\\")
      var searchParts = userSearch.components(separatedBy: separators)
      artistName = searchParts[0].trim()
      albumName = searchParts[1].trim()
      print("artist is \(artistName), album is \(albumName)")
    }
  
  
  @IBAction func searchButtonTapped(_ sender: Any) {

    separateSearch()
    fetchData()
    
  }
  
}


extension MainViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = (searchTextField.text! as NSString).replacingCharacters(in: range, with: string)
    if text.isEmpty {
      searchButton.isEnabled = false
    } else {
      searchButton.isEnabled = true
    }
    return true
  }
  
}
