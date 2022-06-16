//
//  ViewModel.swift
//  RxTest-Example
//
//  Created by 최민한 on 2022/06/16.
//

import Foundation
import RxSwift
import RxRelay

final class ViewModel {
  
  // MARK: Properties
  
  private let disposeBag = DisposeBag()
  
  // MARK: Input
  
  let subtractButtonTapped = PublishRelay<Void>()
  let addButtonTapped = PublishRelay<Void>()
  let resetButtonTapped = PublishRelay<Void>()
  
  // MARK: Output
  
  let countLabelText = BehaviorRelay<String>(value: "0")
  
  // MARK: init
  
  init(){
    bind()
  }
  
  // MARK: Method
  
  private func bind() {
    resetButtonTapped
      .map{ "0" }
      .bind(to: countLabelText)
      .disposed(by: disposeBag)
    
    Observable.of(
      subtractButtonTapped.asObservable().map{ Int(self.countLabelText.value)! - 1 },
      addButtonTapped.asObservable().map{ Int(self.countLabelText.value)! + 1 }
    ).merge()
      .map { "\($0)" }
      .bind(to: countLabelText)
      .disposed(by: disposeBag)
  }
  
}
