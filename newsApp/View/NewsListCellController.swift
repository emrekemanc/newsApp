//
//  NewsListCellController.swift
//  newsApp
//
//  Created by Muhammet Emre Kemancı on 8.05.2025.
//

import UIKit

class NewsListCellController: UITableViewCell{
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsPublishedLabel: UILabel!
    @IBOutlet weak var newsPublishedDateLabel: UILabel!
    
    func cellConfigure(with news: Datum){
        newsTitleLabel.text = news.title
        newsDescriptionLabel.text = news.snippet
        newsPublishedLabel.text = news.sourceName
        if let thumbnail = news.thumbnailURL,
           !thumbnail.contains("news.google.com/api/attachments"),
           let url = URL(string: thumbnail) {
            
            newsImageView.loadImage(
                from: url,
                placeholder: UIImage(named: "placeholderImage"),
                fallback: UIImage(named: "fallbackImage")
            )

        } else if let photo = news.photoURL, let url = URL(string: photo) {
            newsImageView.loadImage(
                from: url,
                placeholder: UIImage(named: "placeholderImage"),
                fallback: UIImage(named: "fallbackImage")
            )
        } else {
            newsImageView.image = UIImage(named: "fallbackImage")
        }
        newsPublishedDateLabel.text = DateFormatterHelper.formatted(dateString: news.publishedDatetimeUTC)
    }
}
