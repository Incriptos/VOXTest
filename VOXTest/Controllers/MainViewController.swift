//
//  MainViewController.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
  
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var albumimageview: UIImageView!
  
  private let fetcher = NetworkDataFetcher()
  private let persistenceManager = PersistenceManager.shared
  
  private var artistName = ""
  private var albumName = ""
  
  //MARK: - Life cycle
  
  override func viewWillLayoutSubviews() {
    
    searchButton.layer.cornerRadius = 10
    searchButton.layer.shadowColor =  UIColor.black.cgColor
    searchButton.layer.shadowOpacity = 0.3
    searchButton.layer.shadowOffset = CGSize.zero
    searchButton.layer.shadowRadius = 8
  }
  
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
  
  //MARK: - Private funcs
  
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
      
      guard let resultData = result else {
        let alertContoller = UIAlertController(title: "Error!", message: "Search error", preferredStyle: .alert)
        self?.present(alertContoller, animated: true)
        let when = DispatchTime.now() + 1.5
        DispatchQueue.main.asyncAfter(deadline: when) {
          
          alertContoller.dismiss(animated: true, completion: nil)
        }
        return }
      
      guard let imgSrt = resultData.album.first?.strAlbumThumb else { return }
      self?.albumimageview.downloaded(from: imgSrt)
      
    }
  }
  
 private func separateSearch() {
      let userSearch = searchTextField.text!
      let separators = CharacterSet(charactersIn: "-:|~//\\")
      var searchParts = userSearch.components(separatedBy: separators)
      artistName = searchParts[0].trim()
      albumName = searchParts[1].trim()
    }
  
 private func saveObjectInCoreData() {
    let coreResult = CoreHistory(context: self.persistenceManager.context)
    coreResult.albumName = albumName
    coreResult.artistName = artistName
    self.persistenceManager.save()
  }
  
  //MARK: - Actions
  
  @IBAction func searchButtonTapped(_ sender: Any) {

    separateSearch()
    fetchData()
    saveObjectInCoreData()
    
  }
  
}

//MARK: - UITextField Delegate

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
