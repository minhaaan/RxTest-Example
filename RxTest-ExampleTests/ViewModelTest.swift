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
import RxNimble
import Nimble
@testable import RxTest_Example

class RxTest_ExampleTests: XCTestCase {
  
  var viewController: ViewController!
  var viewModel: ViewModel!
  var disposeBag: DisposeBag!
  
  override func setUp() {
    viewController = ViewController()
    viewModel = ViewModel()
    disposeBag = DisposeBag()
  }
  
  override func tearDown() {
    viewController = nil
    viewModel = nil
    disposeBag = nil
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
  
}
