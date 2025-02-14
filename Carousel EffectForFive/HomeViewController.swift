//
//  HomeViewController.swift
//  Carousel EffectForFive
//
//  Created by ppx on 2025/2/13.
//

import UIKit
import SnapKit


class HomeViewController: UIViewController {

    private let viewModel = HomeViewModel()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let blurEffecctView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupCollectionView()
        setupBackground()
    }

    // MARK: 横屏竖屏切换
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            // 更新集合视图的布局
            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = self.viewModel.cellSize()
                layout.minimumLineSpacing = self.viewModel.minimumLineSpacing()
                layout.sectionInset = self.viewModel.sectionInset()
            }

            // 更新背景图片和虚化效果的约束
            self.backgroundImageView.snp.remakeConstraints { make in
                make.edges.equalToSuperview().inset(0)
            }
            self.collectionView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview().inset(0)
                make.leading.trailing.equalToSuperview().inset(0)
            }

            // 重新布局集合视图
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }

    private func setupSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }

        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InterestCollectionCellView.self, forCellWithReuseIdentifier: InterestCollectionCellView.reuseIdentifier)
    }

    private func setupBackground() {
        let interests = Interest.createInterests()
        if let firstInterest = interests.first, let backgroundImage = firstInterest.backgroundImage {
            // 设置背景图片
            backgroundImageView.image = backgroundImage
        }
        collectionView.backgroundView = blurEffecctView // 添加虚化效果
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionCellView.reuseIdentifier, for: indexPath) as! InterestCollectionCellView
        let interest = viewModel.interest(at: indexPath)
        cell.interest = interest
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.sectionInset()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = targetContentOffset.pointee
        targetContentOffset.pointee = viewModel.targetContentOffset(for: currentOffset)
    }
}
