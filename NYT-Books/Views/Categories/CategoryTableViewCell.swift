//
//  CategoryTableViewCell.swift
//  NYT-Books
//
//  Created by Dmytro Akulinin on 10.07.2023.
//

import UIKit

protocol CategoryTableViewCellDelegate: UIViewController {
    func categoryTapped() 
}

class CategoryTableViewCell: UITableViewCell {
    weak var delegate: CategoryTableViewCellDelegate?
    
    public static let id = "CategoryCell"
    
    private let titleLabel: UILabel = {
      let titleLabel = UILabel()
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
      titleLabel.textColor = .label
      titleLabel.adjustsFontSizeToFitWidth = true
      titleLabel.minimumScaleFactor = 0.9
      titleLabel.numberOfLines = 0
      titleLabel.lineBreakMode = .byWordWrapping
      return titleLabel
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    private func setupSubviews() {
      contentView.addSubview(titleLabel)
      setUpConstraints()
    }
    
    private func setUpConstraints() {
      NSLayoutConstraint.activate([
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      ])
    }
    
    func configure(categoryName: String) {
        titleLabel.text = categoryName
    }
    
    @objc private func categoryTapped() {
        self.delegate?.categoryTapped()
    }
}
