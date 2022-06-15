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
        viewModel = ImageEditViewModel(creation: Creation.sampleData[0])
        canvasView = CanvasView(canvas: .constant(viewModel.canvas), toolPicker: .constant(viewModel.toolPicker), image: .constant(UIImage(named: "hello-peter")), rect: CGSize())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTextBoxesIsEmptyWhenCreateTextBoxIsAddingTextBox() {
        viewModel.addingTextBox = true;
        viewModel.createTextBox()
        XCTAssertTrue(viewModel.creation.textBoxList.textBoxes.isEmpty)
    }
    
    func testTextBoxesIsNotEmptyWhenCreateTextBoxNotAddingTextBox() {
        viewModel.createTextBox()
        XCTAssertFalse(viewModel.creation.textBoxList.textBoxes.isEmpty)
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
        XCTAssertEqual(viewModel.creation.textBoxList.textBoxes.count, 4)
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
        XCTAssertEqual(viewModel.creation.textBoxList.textBoxes.count, 3)
    }
    
    func testGetIndex() {
        let textBox = TextBox()
        viewModel.creation.textBoxList.textBoxes.append(TextBox())
        viewModel.creation.textBoxList.textBoxes.append(textBox)
        viewModel.creation.textBoxList.textBoxes.append(TextBox())
        viewModel.creation.textBoxList.textBoxes.append(TextBox())
        XCTAssertEqual(viewModel.getIndex(of: textBox), 1)
    }

}
