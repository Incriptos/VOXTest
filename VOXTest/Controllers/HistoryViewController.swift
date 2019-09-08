//
//  HistoryViewController.swift
//  VOXTest
//
//  Created by Andrew Vashulenko on 9/6/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit
import CoreData

final class HistoryViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  private let persistenceManager = PersistenceManager.shared
  private var history = [CoreHistory]()
  
  //MARK: - Life cycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchDataFromCoreData()
    tableView.reloadData()
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

    setupNavigation()
    setupTableView()
  
    }
  
  //MARK: - Private funcs
  
  private func setupNavigation() {
    navigationItem.title = "Search History"
  }
  
  private func setupTableView() {
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    
    tableView.rowHeight = UITableView.automaticDimension
    
  }
  
  private func fetchDataFromCoreData() {
    
    persistenceManager.fetchData(CoreHistory.self) { [weak self] (coreHistory) in
      self?.history = coreHistory
    }
  }
  
}

//MARK: - UI TableView Delegate and DataSource

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return history.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let object = history[indexPath.row]
    
    let mainViewController: MainViewController = MainViewController.loadFromStoryboard()
    

  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let object = history[indexPath.row]
    
    cell.textLabel?.text = "\(object.artistName!): \(object.albumName!)"
    
    return cell
  }
  
  
  
}

