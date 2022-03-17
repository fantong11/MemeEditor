//
//  UserDefaultInfoTests.swift
//  MemeEditorTests
//
//  Created by 范桶 on 2022/3/17.
//

import XCTest
@testable import MemeEditor

class UserDefaultInfoTests: XCTestCase {

    override func setUpWithError() throws {
        UserDefaults.standard.removeDefaults()
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.removeDefaults()
    }

    func testIntegerDefaults() {
        let integerInfo = UserDefaultInfo(key: "integerInfo", defaultValue: 12345)
        XCTAssertEqual(integerInfo.get(), 12345)
        integerInfo.set(54321)
        XCTAssertEqual(integerInfo.get(), 54321)
        integerInfo.set(9876)
        XCTAssertNotEqual(integerInfo.get(), 0)
    }
    
    func testUserDefaultsShouldBeEmptyWhenRemoveAll() {
        let integerInfo = UserDefaultInfo(key: "integerInfo", defaultValue: 12345)
        let stringInfo = UserDefaultInfo(key: "stringInfo", defaultValue: "12345")
        var integer: Int {
            get { return integerInfo.get() }
            set { return integerInfo.set(newValue) }
        }
        var string: String {
            get { return stringInfo.get() }
            set { return stringInfo.set(newValue) }
        }
        integer = 123
        string = "123"
        UserDefaults.standard.removeDefaults()
        // should be default value after remove
        XCTAssertEqual(integer, 12345)
        XCTAssertEqual(string, "12345")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
