//
//  TextSpeedView.swift
//  speedtest
//
//  Created by Sergey Fominov on 5/21/23.
//

import UIKit

final class TextSpeedView: UIView {
    // MARK: - Types

    enum SpeedType: String, CaseIterable {
        case ping = "Ping", upload = "Upload", download = "Download"

        var value: Int {
            switch self {
            case .ping: return 60
            case .upload: return 120
            case .download: return 180
            }
        }
    }

    // MARK: - Properties

    private let textLabel = UILabel()
    private let valueLabel = UILabel()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configureView()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties

    private func configureView() {
        textLabel.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel.textColor = .gray
        textLabel.textAlignment = .center

        valueLabel.font = UIFont.boldSystemFont(ofSize: 30)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center

        addSubview(textLabel)
        addSubview(valueLabel)
    }

    private func configureConstraints() {
        textLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).inset(4)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension TextSpeedView: Configurable {
    struct Model {
        let type: SpeedType
    }

    func configure(with model: Model) {
        textLabel.text = model.type.rawValue
        valueLabel.text = "\(model.type.value)"
    }
}
