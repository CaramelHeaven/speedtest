//
//  SpeedProgressView.swift
//  speedtest
//
//  Created by Sergey Fominov on 5/21/23.
//

import UIKit

final class SpeedProgressView: UIView {
    // MARK: - Properties
    
    private let completeDuration: Double = 0.3

    private let lineWidth: CGFloat = 50
    private let spaceDegree: CGFloat = 90

    private let progressShape = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    private let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func layoutSubviews() {
        super.layoutSubviews()

        progressShape.frame = bounds
        gradientLayer.frame = bounds

        let rect = rectForShape()
        progressShape.path = pathForShape(rect: rect).cgPath

        updateShapes()
    }

    // MARK: - Private methods

    private func configureView() {
        layer.mask = nil
        progressShape.fillColor = nil
        progressShape.strokeStart = 0
        progressShape.strokeColor = UIColor.black.cgColor
        progressShape.strokeEnd = 0.1
        layer.mask = progressShape

        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        gradientLayer.colors = [
            UIColor.hex("#FF00FF").cgColor,
            UIColor.hex("#FF04FB").cgColor,
            UIColor.hex("#FF10EE").cgColor,
            UIColor.hex("#FF25DA").cgColor,
            UIColor.hex("#FF41BC").cgColor,
            UIColor.hex("#FF6697").cgColor,
            UIColor.hex("#FF9469").cgColor,
            UIColor.hex("#FFC834").cgColor,
            UIColor.hex("#FFFB00").cgColor
        ]

        layer.addSublayer(gradientLayer)
    }

    private func updateShapes() {
        progressShape.lineWidth = lineWidth
        progressShape.lineCap = .butt

        progressShape.transform = CATransform3DMakeRotation(CGFloat.pi * 2, 0, 0, 1)
    }

    private func rectForShape() -> CGRect {
        bounds.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
    }

    private func pathForShape(rect: CGRect) -> UIBezierPath {
        let startAngle = CGFloat(spaceDegree * .pi / 180) + (0.5 * .pi)
        let endAngle = CGFloat((360.0 - spaceDegree) * (.pi / 180)) + (0.5 * .pi)

        let path = UIBezierPath(
            arcCenter: CGPoint(x: rect.midX, y: rect.maxY + lineWidth / 2),
            radius: rect.size.width / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        return path
    }
}

// MARK: - Animation
extension SpeedProgressView {
    func setProgress(progress: CGFloat, animated: Bool = true) {
        if progress > 1.0 {
            return
        }

        var start = progressShape.strokeEnd
        if let presentationLayer = progressShape.presentation() {
            if let count = progressShape.animationKeys()?.count, count > 0 {
                start = presentationLayer.strokeEnd
            }
        }

        let duration = abs(Double(progress - start)) * completeDuration
        progressShape.strokeEnd = progress

        if animated {
            progressAnimation.fromValue = start
            progressAnimation.toValue = progress
            progressAnimation.duration = duration
            progressShape.add(progressAnimation, forKey: progressAnimation.keyPath)
        }
    }
}
