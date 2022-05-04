//
//  ImageEditViewModelTests.swift
//  MemeEditorTests
//
//  Created by 范桶 on 2022/5/4.
//

import XCTest
@testable import MemeEditor


class ImageEditViewModelTests: XCTestCase {
    private var viewModel: ImageEditViewModel!
    private var canvasView: CanvasView!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ImageEditViewModel()
        canvasView = CanvasView(canvas: .constant(viewModel.canvas), toolPicker: .constant(viewModel.toolPicker), image: .constant(UIImage(named: "hello-peter")), rect: CGSize())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTextBoxesIsEmptyWhenCreateTextBoxIsAddingTextBox() {
        viewModel.addingTextBox = true;
        viewModel.createTextBox()
        XCTAssertTrue(viewModel.textBoxes.isEmpty)
    }
    
    func testTextBoxesIsNotEmptyWhenCreateTextBoxNotAddingTextBox() {
        viewModel.createTextBox()
        XCTAssertFalse(viewModel.textBoxes.isEmpty)
    }
    
    func testToolPickerShouldBeInVisibleWhenCreateTextBox() {
        viewModel.createTextBox()
        XCTAssertFalse(viewModel.toolPicker.isVisible)
    }
    
    func testTextBoxesHaveCorrectLengthWhenCreateTextBox() {
        viewModel.createTextBox()
        viewModel.addTextBox()
        viewModel.createTextBox()
        viewModel.addTextBox()
        viewModel.createTextBox()
        viewModel.addTextBox()
        viewModel.createTextBox()
        viewModel.addTextBox()
        XCTAssertEqual(viewModel.textBoxes.count, 4)
    }
    
    func testTextBoxesHaveCorrectLengthWhenCreateTextBoxAndCancelTextBoxView() {
        viewModel.createTextBox()
        viewModel.addTextBox()
        viewModel.createTextBox()
        viewModel.addTextBox()
        viewModel.createTextBox()
        viewModel.addTextBox()
        viewModel.createTextBox()
        viewModel.cancelTextBoxView()
        XCTAssertEqual(viewModel.textBoxes.count, 3)
    }
    
    func testGetIndex() {
        let textBox = TextBox()
        viewModel.textBoxes.append(TextBox())
        viewModel.textBoxes.append(textBox)
        viewModel.textBoxes.append(TextBox())
        viewModel.textBoxes.append(TextBox())
        XCTAssertEqual(viewModel.getIndex(of: textBox), 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
