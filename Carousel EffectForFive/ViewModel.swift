//
//  ViewModel.swift
//  Carousel EffectForFive
//
//  Created by ppx on 2025/2/13.
//

import Foundation
import UIKit

class HomeViewModel {
    private(set) var interests: [Interest] = []

    init() {
        interests = Interest.createInterests()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        return interests.count
    }

    func interest(at indexPath: IndexPath) -> Interest {
        return interests[indexPath.item]
    }

    func cellSize() -> CGSize {
        let cellPadding: CGFloat = 20.0
        return CGSize(width: UIScreen.main.bounds.width - 2 * cellPadding, height: 450)
    }

    func minimumLineSpacing() -> CGFloat {
        let cellPadding: CGFloat = 20.0
        return 2 * cellPadding
    }

    func sectionInset() -> UIEdgeInsets {
        let cellPadding: CGFloat = 20.0
        return UIEdgeInsets(top: 0, left: cellPadding, bottom: 0, right: cellPadding)
    }

    func targetContentOffset(for currentOffset: CGPoint) -> CGPoint {
        var index = Int(currentOffset.x / UIScreen.main.bounds.width)
        let offset = Int(currentOffset.x) % Int(UIScreen.main.bounds.width)
        index += (offset > Int(UIScreen.main.bounds.width / 2) ? 1 : 0)
        return CGPoint(x: index * Int(UIScreen.main.bounds.width), y: 0)
    }
}
