//
//  ImagePickerTests.swift
//  MemeEditorTests
//
//  Created by 范桶 on 2022/3/10.
//

import XCTest
@testable import MemeEditor

class ImagePickeViewModelTests: XCTestCase {
    private var viewModel: ImagePickViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ImagePickViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testLoadImage() {
        viewModel.inputImage = UIImage(named: "hello-peter")
    }
    
    func testAddCreation() {
        viewModel.addCreation(creation: Creation(name: "test", image: UIImage(named: "hello-peter")))
        viewModel.addCreation(creation: Creation(name: "test", image: UIImage(named: "hello-peter")))
        XCTAssertEqual(viewModel.creations.count, 2)
    }
    
    func testDeleteCreation() {
        viewModel.addCreation(creation: Creation(name: "test", image: UIImage(named: "hello-peter")))
        viewModel.addCreation(creation: Creation(name: "test", image: UIImage(named: "hello-peter")))
        viewModel.deleteCreation(at: .init(integer: 1))
        XCTAssertEqual(viewModel.creations.count, 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
