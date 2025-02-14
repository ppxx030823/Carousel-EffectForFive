//
//  ViewController.swift
//  Carousel EffectForFive
//
//  Created by ppx on 2025/2/13.
//
import UIKit
import SnapKit


class InterestCollectionCellView: UICollectionViewCell {
    static let reuseIdentifier = "InterestCell"

    let featuredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        featuredImageView.snp.makeConstraints { make in
            make.top.equalTo(interestTitleLabel.snp.bottom).inset(10)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }

        interestTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(40)
            make.centerX.equalTo(featuredImageView.snp.centerX)
        }
    }

    private func updateUI() {
        interestTitleLabel.text = interest.title
        featuredImageView.image = interest.featuredImage
    }
}

