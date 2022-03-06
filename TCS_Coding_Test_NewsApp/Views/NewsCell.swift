//
//  NewsCell.swift
//  TCS_Coding_Test_NewsApp
//
//  Created by Charmy on 4/3/22.
//

import UIKit

class NewsCellViewModel{
    let title : String
    let subTitle : String
    let imageURL : URL?
    var imageData : Data? = nil
    
    init(
        title : String,
        subTitle : String,
        imageURL : URL?
    ){
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURL
    }
}

class NewsCell: UITableViewCell {

    static let identifier = "NewsCell"
    
    private let newsTitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let newsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.frame.size.width - 175,
                                      height: contentView.frame.size.height/2)
        
        subTitleLabel.frame = CGRect(x: 10,
                                     y: 60,
                                     width: contentView.frame.size.width - 200,
                                     height: contentView.frame.size.height/2)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 160,
                                     y: 5,
                                     width: 150,
                                     height: contentView.frame.size.height-10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsTitleLabel.text = nil
        subTitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel:NewsCellViewModel){
        newsTitleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data: data)
        }else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                
                viewModel.imageData = data
                
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
