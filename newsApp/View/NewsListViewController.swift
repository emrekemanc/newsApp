//
//  ViewController.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//

import UIKit
import Combine

class NewsListViewController: UITableViewController {
    private let viewModel: NewsListViewModel = NewsListViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var newsList: [Datum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        viewModel.loadNews(query: "Türkiye")
    }

    @IBAction func fetchButton(_ sender: UIBarButtonItem) {
        viewModel.loadNews(query: "Türkiye")
    }
    func observeViewModel(){
        viewModel.$news.receive(on: DispatchQueue.main).sink { result in
            self.newsList = result
            print(self.newsList)
        }.store(in: &cancellables)
        
        viewModel.$errorMessage.compactMap { $0 }.sink { error in
            self.showError(error)
        }.store(in: &cancellables)
    }
    
    private func showError(_ error: String){
        let alert = UIAlertController(title: "Hata", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
}

