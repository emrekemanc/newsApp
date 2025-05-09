//
//  NewsDetailViewController.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 9.05.2025.
//
import UIKit
import Combine
class NewsDetailViewController: UIViewController{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTou: UIImageView!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTou: UILabel!
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: NewsDetailViewModel = NewsDetailViewModel()
    var loadIndex: Int?
    var selectedNews: Datum?
    override func viewDidLoad() {
        scrollView.delegate = self
        observeViewModel()
        if let selectedNews = selectedNews {
                self.viewConfigure(new: selectedNews)
            } else if let index = loadIndex {
                viewModel.loadNew(newIndex: index)
            }
        
    }
    
    func observeViewModel(){
        viewModel.$new.receive(on: DispatchQueue.main).sink { new in
            if let new = new{
                self.viewConfigure(new: new)
            }
        }.store(in: &cancellables)
        viewModel.$errorMessage.compactMap{$0}.sink { error in
            self.showError(error)
        }.store(in: &cancellables)
    }
    
    func viewConfigure(new: Datum){
        if let minImage = new.sourceLogoURL,
            let url = URL(string: minImage){
            imageOne.loadImage(from: url,placeholder: UIImage(named: "placeHolderImage"),fallback:  UIImage(named: "placeHolderImage"))
        }else{
            imageOne.image = UIImage(named: "placeHolderImage")
        }
        if let bigImage = new.photoURL, !bigImage.contains("news.google.com/api/attachments"), let url = URL(string: bigImage){
            imageTou.loadImage(from: url,placeholder: UIImage(named: "placeHolderImage"),fallback:  UIImage(named: "placeHolderImage"))
        }else{
            imageTou.image = UIImage(named: "placeHolderImage")
        }
        labelOne.text = new.sourceName
        labelTou.text = new.snippet
        
    }
    
    private func showError(_ error: String){
        let alert = UIAlertController(title: "Hata", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            self.present(alert, animated: true)
    }
    
}
extension NewsDetailViewController: UIScrollViewDelegate{
    
}
