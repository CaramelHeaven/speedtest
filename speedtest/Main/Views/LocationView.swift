//
//  LocationView.swift
//  speedtest
//
//  Created by Sergey Fominov on 5/20/23.
//

import UIKit

final class LocationView: UIView {
    // MARK: - Properties

    private let stackView = UIStackView()

    private let nameLocationLabel = UILabel()
    private let ipAddressLabel = UILabel()
    private let flagImageView = UIImageView()
    private let autoImageView = UIImageView()

    private let horizontalStackView = UIStackView()
    private let textsInnerStackView = UIStackView()

    // MARK: - Init

    init() {
        super.init(frame: .zero)

        configureView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func configureView() {
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8

        textsInnerStackView.alignment = .fill
        textsInnerStackView.axis = .vertical
        textsInnerStackView.distribution = .fillEqually

        textsInnerStackView.layoutMargins = UIEdgeInsets(top: 17, left: 0, bottom: 0, right: 0)
        textsInnerStackView.isLayoutMarginsRelativeArrangement = true

        flagImageView.image = UIImage(named: "flag.png")
        flagImageView.contentMode = .scaleAspectFill

        nameLocationLabel.text = "Luxembourg".uppercased()
        nameLocationLabel.textColor = .white
        nameLocationLabel.textAlignment = .center
        nameLocationLabel.font = UIFont.boldSystemFont(ofSize: 14)

        ipAddressLabel.text = "5.149.112.247"
        ipAddressLabel.textColor = .white
        ipAddressLabel.textAlignment = .center
        ipAddressLabel.font = UIFont.boldSystemFont(ofSize: 14)

        autoImageView.image = UIImage(named: "auto_icon.png")
        autoImageView.contentMode = .scaleAspectFit

        addSubview(stackView)

        stackView.addArrangedSubview(flagImageView)
        stackView.addArrangedSubview(textsInnerStackView)
        stackView.addArrangedSubview(autoImageView)

        textsInnerStackView.addArrangedSubview(nameLocationLabel)
        textsInnerStackView.addArrangedSubview(ipAddressLabel)
    }

    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        flagImageView.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }

        autoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
    }
}

// MARK: - Configurable
extension LocationView: Configurable {
    struct Model {
    }

    func configure(with model: Model) {
    }
}
