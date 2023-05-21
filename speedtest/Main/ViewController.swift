//
//  ViewController.swift
//  speedtest
//
//  Created by Sergey Fominov on 5/20/23.
//

import SnapKit
import UIKit

protocol Configurable {
    associatedtype Model

    func configure(with model: Model)
}

class ViewController: UIViewController {
    // MARK: - Properties

    private let backgroundImageView = UIImageView()
    private let titleImageView = UIImageView()
    private let locationView = LocationView()
    private let bottomSheetView = BottomSheetView()

    private let connectionStatusLabel = UILabel()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
    }

    // MARK: - Private methods

    private func configureView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "main_background")

        titleImageView.image = UIImage(named: "app_title")

        connectionStatusLabel.text = "Connection is active"
        connectionStatusLabel.textAlignment = .center
        connectionStatusLabel.textColor = .white

        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)

        view.addSubview(titleImageView)
        view.addSubview(connectionStatusLabel)
        view.addSubview(locationView)
        view.addSubview(bottomSheetView)
    }

    private func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        titleImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(82)
        }

        connectionStatusLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalTo(view.snp.centerY).offset(-60 - 122)
        }

        locationView.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY).offset(-60)
            make.left.right.equalToSuperview().inset(75)
        }

        bottomSheetView.snp.makeConstraints { make in
            // 110 for SE-3
            make.top.equalTo(locationView.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
