//
//  BookLiostTableViewCell.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 13.07.2023.
//

import UIKit

protocol BookListTableViewCellDelegate: BookListViewController {
    func didTapBuyButton(url: URL)
}

class BookListTableViewCell: UITableViewCell {
    public static let id = "BookCell"
    private var buyUrl: URL?
    weak var delegate: BookListTableViewCellDelegate?

    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let publisherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buy", for: .normal)
        return button
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        authorLabel.text = nil
        descriptionLabel.text = nil
        publisherLabel.text = nil
        rankLabel.text = nil
        buyUrl = nil
//        self.bookImageView.showSpinner()
    }
    
    private func setupSubviews() {
        contentView.addSubview(bookImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(publisherLabel)
        contentView.addSubview(rankLabel)
        contentView.addSubview(buyButton)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bookImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            bookImageView.widthAnchor.constraint(equalToConstant: 100),
            bookImageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            publisherLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            publisherLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            publisherLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            rankLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 4),
            rankLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            buyButton.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 4),
            buyButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            buyButton.widthAnchor.constraint(equalToConstant: 60),
            buyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with viewModel: BookCellViewModel) async {
        titleLabel.text = viewModel.book.title
        authorLabel.text = "Author: \(viewModel.bookAuthor())"
        descriptionLabel.text = viewModel.bookDescription()
        publisherLabel.text = "Publisher: \(viewModel.bookPublisher())"
        rankLabel.text = "Current rank: \(viewModel.bookRank())"
        if let buyLink = viewModel.bookBuyLink() {
            self.buyUrl = buyLink
            buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        } else {
            buyButton.isHidden = true
        }
        
        
        
        DispatchQueue.main.async {
            self.bookImageView.showSpinner()
        }
        
        do {
            bookImageView.image = try await viewModel.bookImage()
            DispatchQueue.main.async {
                self.bookImageView.hideSpinner()
            }
        } catch {
            bookImageView.image = UIImage(systemName: "book.closed")
            DispatchQueue.main.async {
                self.bookImageView.hideSpinner()
            }
        }
    }
    
    @objc func buyButtonTapped() {
        if let url = buyUrl {
            delegate?.didTapBuyButton(url: url)
        }
    }
}
