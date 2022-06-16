//
//  ViewController.swift
//  RxTest-Example
//
//  Created by 최민한 on 2022/06/16.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import SnapKit

final class ViewController: UIViewController {
  
  // MARK: Properties
  
  let viewModel = ViewModel()
  
  let countLabel: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.font = .boldSystemFont(ofSize: 25)
    return label
  }()
  
  let subtractButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "minus.square"), for: .normal)
    button.tintColor = .systemBlue
    return button
  }()
  
  let addButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "plus.square"), for: .normal)
    button.tintColor = .systemBlue
    return button
  }()
  
  let resetButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("reset", for: .normal)
    return button
  }()
  
  let disposeBag = DisposeBag()
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    bindData()
    setupLayout()
  }
}

// MARK: ViewModel bindData

extension ViewController {
  private func bindData() {
    subtractButton.rx.tap
      .bind(to: viewModel.subtractButtonTapped)
      .disposed(by: disposeBag)
    
    addButton.rx.tap
      .bind(to: viewModel.addButtonTapped)
      .disposed(by: disposeBag)
    
    resetButton.rx.tap
      .bind(to: viewModel.resetButtonTapped)
      .disposed(by: disposeBag)
    
    viewModel.countLabelText
      .distinctUntilChanged()
      .bind(to: countLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

// MARK: Layout

extension ViewController {
  private func setupLayout() {
    view.backgroundColor = .white
    
    [
      countLabel,
      subtractButton,
      addButton,
      resetButton
    ].forEach{ view.addSubview($0) }
    
    countLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    subtractButton.snp.makeConstraints { make in
      make.trailing.equalTo(countLabel.snp.leading).offset(-20)
      make.centerY.equalToSuperview()
    }
    
    addButton.snp.makeConstraints { make in
      make.leading.equalTo(countLabel.snp.trailing).offset(20)
      make.centerY.equalToSuperview()
    }
    
    resetButton.snp.makeConstraints { make in
      make.top.equalTo(countLabel.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
    }
  }
}

