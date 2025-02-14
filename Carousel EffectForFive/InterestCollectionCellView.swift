//
//  ViewController.swift
//  Carousel EffectForFive
//
//  Created by ppx on 2025/2/13.
//
import UIKit


class InterestCollectionCellView: UICollectionViewCell {
    static let reuseIdentifier = "InterestCell"

    let featuredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let interestTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var interest: Interest! {
        didSet {
            updateUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(featuredImageView)
        contentView.addSubview(interestTitleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            featuredImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            featuredImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            featuredImageView.heightAnchor.constraint(equalToConstant: 300),

            interestTitleLabel.topAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: 10),
            interestTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            interestTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    private func updateUI() {
        interestTitleLabel.text = interest.title
        featuredImageView.image = interest.featuredImage
    }
}

