//
//  BottomSheetView.swift
//  speedtest
//
//  Created by Sergey Fominov on 5/20/23.
//

import UIKit

protocol BottomSheetViewDelegate: AnyObject {
    func didTapStartButton()
}

final class BottomSheetView: UIView {
    // MARK: - Properties

    weak var delegate: BottomSheetViewDelegate?

    private let backgroundImageView = UIImageView()

    private let speedProgressView = SpeedProgressView()
    private let textsStackView = UIStackView()
    private let startButton = UIButton(type: .system)

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
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = UIImage(named: "bottom_sheet_background")

        textsStackView.alignment = .fill
        textsStackView.axis = .horizontal
        textsStackView.distribution = .fillEqually
        textsStackView.spacing = 50

        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 26, weight: .regular)

        startButton.backgroundColor = .clear
        startButton.layer.cornerRadius = 6
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.white.cgColor

        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)

        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)

        makeSpeedometerLabels()

        addSubview(speedProgressView)
        addSubview(textsStackView)
        addSubview(startButton)

        TextSpeedView.SpeedType.allCases.forEach { type in
            let view = TextSpeedView()
            textsStackView.addArrangedSubview(view)

            view.configure(with: TextSpeedView.Model(type: type))
        }
    }

    private func configureConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        speedProgressView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(284)
            make.height.equalTo(146)
        }

        textsStackView.snp.makeConstraints { make in
            make.top.equalTo(speedProgressView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(60)
        }

        startButton.snp.makeConstraints { make in
            make.top.equalTo(textsStackView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(142)
            make.height.equalTo(48)
        }
    }

    // MARK: - Actions

    @objc private func didTapStartButton() {
        let randomProgress = Double.random(in: 0...1)
        speedProgressView.setProgress(progress: randomProgress)
    }
}

// MARK: - Configurable
extension BottomSheetView: Configurable {
    struct Model {
    }

    func configure(with model: Model) {
    }
}

// MARK: - SpeedometerLabels
extension BottomSheetView {
    private func makeSpeedometerLabels() {
        let emptyView = UIView()
        addSubview(emptyView)
        emptyView.backgroundColor = .clear

        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60 + 136)
            make.centerX.equalTo(snp.centerX)
            make.height.width.equalTo(0)
        }

        let radius: CGFloat = 160 // center of the circles to be 160 points away from center of existing view
        let range = -CGFloat.pi * 2 / 2...0 // from -pi to 0

        let arr = Array(stride(from: 0, through: 200, by: 20))

        (0..<arr.count).forEach { index in
            let angle = range.lowerBound + CGFloat(index) / CGFloat(arr.count - 1) * (range.upperBound - range.lowerBound)

            let offset = CGPoint(x: radius * cos(angle), y: radius * sin(angle))
            let label = UILabel()
            label.text = "\(arr[index])"

            let textColor: UIColor
            let font: UIFont
            if [0, 100, 200].contains(arr[index]) {
                textColor = .white
                font = .systemFont(ofSize: 12, weight: .regular)
            } else {
                textColor = .gray
                font = .systemFont(ofSize: 10, weight: .regular)
            }
            label.textColor = textColor
            label.font = font

            addSubview(label)

            let offsetY = (80...120).contains(arr[index]) ? offset.y + 10 : offset.y

            label.snp.makeConstraints { make in
                make.centerX.equalTo(emptyView.snp.centerX).offset(offset.x)
                make.centerY.equalTo(emptyView.snp.centerY).offset(offsetY)
            }
        }
    }
}
