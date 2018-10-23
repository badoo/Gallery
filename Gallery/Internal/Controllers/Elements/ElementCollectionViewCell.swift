/*
 The MIT License (MIT)

 Copyright (c) 2018-present Badoo Trading Limited.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import UIKit

final class ElementCollectionViewCell: UICollectionViewCell {

    // MARK: - Private properties

    private let titleLabel: UILabel
    private let container: UIView

    // MARK: - Instantiation

    override init(frame: CGRect) {
        titleLabel = ElementCollectionViewCell.makeTitleLabel()
        container = UIView()
        super.init(frame: .zero)

        titleLabel.textAlignment = .center
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        for view in [titleLabel, container] {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            container.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UICollectionViewCell

    override func prepareForReuse() {
        super.prepareForReuse()
        container.subviews.forEach { $0.removeFromSuperview() }
    }

    // MARK: - API

    func setElement(_ element: Element, maxWidth: CGFloat) {
        container.backgroundColor = element.backgroundColor

        titleLabel.text = element.title

        let view = element.view
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)

        var constraints = [
            view.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            view.topAnchor.constraint(equalTo: container.topAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            view.widthAnchor.constraint(lessThanOrEqualTo: container.widthAnchor)
        ]
        constraints.forEach { $0.priority = .defaultHigh }

        switch element.width {
        case .custom(let width):
            constraints.append(view.widthAnchor.constraint(equalToConstant: width))
        case .selfSizing:
            constraints.append(view.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth))
        case .default:
            constraints.append(view.widthAnchor.constraint(equalToConstant: maxWidth))
        }

        if let height = element.height {
            constraints.append(view.heightAnchor.constraint(equalToConstant: height))
        }
     
        NSLayoutConstraint.activate(constraints)
        container.layoutIfNeeded()
    }

    // MARK: - Factories

    private static func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }
}
