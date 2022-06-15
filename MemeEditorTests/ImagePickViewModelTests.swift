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


}
