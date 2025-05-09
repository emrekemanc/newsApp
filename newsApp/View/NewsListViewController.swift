//
//  ViewController.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//

import UIKit
import Combine

class NewsListViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    private let viewModel: NewsListViewModel = NewsListViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var newsList: [Datum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        observeViewModel()
        viewModel.loadNews(query: nil)
    }

    @IBAction func fetchButton(_ sender: UIBarButtonItem) {
        viewModel.loadNews(query: "Ankara")
    }
    func observeViewModel(){
        viewModel.$news.receive(on: DispatchQueue.main).sink { result in
            self.newsList = result
            self.tableView.reloadData()
            print(self.newsList)
        }.store(in: &cancellables)
        
        viewModel.$errorMessage.compactMap { $0 }.sink { error in
            print(error.lowercased())
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListCellController", for: indexPath) as? NewsListCellController else{
            return UITableViewCell()
        }
        let news = newsList[indexPath.row]
        cell.cellConfigure(with: news)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        let detailVC = UIStoryboard(name: "Main", bundle: nil)
               .instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
           detailVC.selectedNews = news
           // veya: detailVC.loadIndex = indexPath.row
           navigationController?.pushViewController(detailVC, animated: true)
        
    }
   
}

extension NewsListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        viewModel.loadNews(query: query?.isEmpty == false ? query : nil)
    }
}
