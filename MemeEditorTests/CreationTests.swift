//
//  CreationTests.swift
//  MemeEditorTests
//
//  Created by 范桶 on 2022/6/16.
//

import XCTest
@testable import MemeEditor

class CreationTests: XCTestCase {
    private var creation: Creation!

    override func setUpWithError() throws {
        creation = Creation(name: "test", image: UIImage(named: "hello-peter"))
    }

    func testAddTextBoxesTest() throws {
        creation.addTextBoxes(textBox: TextBox())
        creation.addTextBoxes(textBox: TextBox())
        creation.addTextBoxes(textBox: TextBox())
        
        XCTAssertEqual(creation.textBoxesSize(), 3)
    }
    
    func testAddStickerTest() throws {
        creation.addStickers(sticker: Sticker(name: ""))
        creation.addStickers(sticker: Sticker(name: ""))
        creation.addStickers(sticker: Sticker(name: ""))
        
        XCTAssertEqual(creation.stickersSize(), 3)
    }
}
