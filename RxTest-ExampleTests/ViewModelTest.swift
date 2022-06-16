//
//  RxTest_ExampleTests.swift
//  RxTest-ExampleTests
//
//  Created by 최민한 on 2022/06/16.
//

import XCTest
import RxSwift
import RxRelay
import RxTest
@testable import RxTest_Example

class RxTest_ExampleTests: XCTestCase {
  
  var viewController: ViewController!
  var viewModel: ViewModel!
  var disposeBag: DisposeBag!
  
  var scheduler: TestScheduler!
  var plusSubject: PublishSubject<Int>!
  
  override func setUp() {
    viewController = ViewController()
    viewModel = ViewModel()
    disposeBag = DisposeBag()
    
    scheduler = TestScheduler(initialClock: 0)
    plusSubject = PublishSubject<Int>()
  }
  
  override func tearDown() {
    viewController = nil
    viewModel = nil
    disposeBag = nil
    
    scheduler = nil
    plusSubject = nil
  }
  
  func testCountLabelFirstLabelText() {
    // When
    guard let countLabelText = try? XCTUnwrap(viewController.countLabel.text) else {
      XCTFail()
      return
    }
    
    // Then
    XCTAssertEqual("0", countLabelText)
  }
  
  func testButtonAction() {
    let count = scheduler.createObserver(String.self)
    
    viewModel.countLabelText
      .bind(to: count)
      .disposed(by: disposeBag)
    
    scheduler.createColdObservable([
      .next(10, ()),
      .next(20, ()),
      .next(30, ())
    ]).bind(to: viewModel.addButtonTapped)
      .disposed(by: disposeBag)
    
    scheduler.createColdObservable([
      .next(40, ())
    ]).bind(to: viewModel.resetButtonTapped)
      .disposed(by: disposeBag)
    
    scheduler.createColdObservable([
      .next(50, ())
    ]).bind(to: viewModel.subtractButtonTapped)
      .disposed(by: disposeBag)
    
    scheduler.start()
    
    XCTAssertEqual(count.events, [
      .next(0, "0"),
      .next(10, "1"),
      .next(20, "2"),
      .next(30, "3"),
      .next(40, "0"),
      .next(50, "-1")
    ])
    
  }
  
}
