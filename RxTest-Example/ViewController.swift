//
//  ViewController.swift
//  RxTest-Example
//
//  Created by 최민한 on 2022/06/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  let countLabel: UILabel = {
    let label = UILabel()
    label.text = "0"
    label.font = .boldSystemFont(ofSize: 25)
    return label
  }()
  
  let subtractButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("-", for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    setupLayout()
  }
}

extension ViewController {
  private func setupLayout() {
    view.backgroundColor = .white
    
    view.addSubview(countLabel)
    countLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}

