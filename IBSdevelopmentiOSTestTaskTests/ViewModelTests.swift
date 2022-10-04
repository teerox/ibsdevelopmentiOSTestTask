//
//  ViewModelTests.swift
//  IBSdevelopmentiOSTestTaskTests
//
//  Created by Mac on 03/10/2022.
//

import XCTest
import Combine
@testable import IBSdevelopmentiOSTestTask

class ViewModelTests: XCTestCase {
    
    private var mockRepository: MockRepository!
    private var viewModelToTest: ViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        mockRepository = MockRepository()
        viewModelToTest = ViewModel(with: mockRepository)
    }

    override func tearDownWithError() throws {
        mockRepository = nil
        viewModelToTest = nil
    }

    func testDataIsRetured() {
        let mockData = mockRepository.mockData.results
        let expectation = XCTestExpectation(description: "Data is fetched")
        
        mockRepository.fetchAllResult = Result.success(mockData).publisher.eraseToAnyPublisher()
        viewModelToTest.getAllData()
        
        viewModelToTest.$allData.sink { result in
            XCTAssertEqual(result.count, 3)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFirstNameSearchAndFilter() {
        let mockData = mockRepository.mockData.results
        let expectation = XCTestExpectation(description: "Data is fetched")
        
        mockRepository.fetchAllResult = Result.success(mockData).publisher.eraseToAnyPublisher()
        viewModelToTest.getAllData()
        viewModelToTest.searchText = "T"
        
        viewModelToTest.$searchResult.sink { result in
            XCTAssertEqual(result.count, 2)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    func testLastNameSearchAndFilter() {
        let mockData = mockRepository.mockData.results
        let expectation = XCTestExpectation(description: "Data is fetched")
        
        mockRepository.fetchAllResult = Result.success(mockData).publisher.eraseToAnyPublisher()
        viewModelToTest.getAllData()
        viewModelToTest.searchText = "o"
        
        viewModelToTest.$searchResult.sink { result in
            XCTAssertEqual(result.count, 3)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchFieldEmptyShouldShowAllData() {
        let mockData = mockRepository.mockData.results
        let expectation = XCTestExpectation(description: "Data is fetched")
        
        mockRepository.fetchAllResult = Result.success(mockData).publisher.eraseToAnyPublisher()
        viewModelToTest.getAllData()
        viewModelToTest.searchText = ""
        
        viewModelToTest.$searchResult.sink { result in
            XCTAssertEqual(result.count, 3)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoginCriteria() {
        viewModelToTest.email = "oduekene@gmail.com"
        viewModelToTest.password = "123456"
        let expectation = XCTestExpectation(description: "Login is Succesfull")
        viewModelToTest.login()
        viewModelToTest.isLoginValid.sink { result in
            XCTAssertEqual(result, true)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testEmailLoginCriteriaReturnsFalseForWrongEmailFormat() {
        viewModelToTest.email = "oduekene.com"
        viewModelToTest.password = "123456"
        let expectation = XCTestExpectation(description: "Email is Wrong")
        
        viewModelToTest.login()
        viewModelToTest.isLoginValid.sink { result in
            XCTAssertEqual(result, false)
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPasswordLoginCriteriaIsWrong() {
        viewModelToTest.email = "oduekene@gmail.com"
        viewModelToTest.password = "12345"
        let expectation = XCTestExpectation(description: "Password is wrong")
        
        viewModelToTest.login()
        viewModelToTest.isLoginValid.sink { result in
            XCTAssertEqual(result, false)
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPasswordErrorFieldIsShown() {
        viewModelToTest.email = "oduekene@gmail.com"
        viewModelToTest.password = "12345"
        let expectation = XCTestExpectation(description: "Password Error Field is shown")
        
        viewModelToTest.login()
        viewModelToTest.isLoginValid.sink { _ in
            XCTAssertEqual(self.viewModelToTest.showPasswordError, true)
            expectation.fulfill()
        }.store(in: &cancellables)
       
        wait(for: [expectation], timeout: 1)
    }
    
    func testEmailErrorFieldIsShown() {
        viewModelToTest.email = "oduekene.com"
        viewModelToTest.password = "123456"
        let expectation = XCTestExpectation(description: "Email Error Field is shown")
        
        viewModelToTest.login()
        viewModelToTest.isLoginValid.sink { _ in
            XCTAssertEqual(self.viewModelToTest.showEmailError, true)
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPasswordErrorFieldIsNotShown() {
        viewModelToTest.email = "oduekene@gmail.com"
        viewModelToTest.password = "123456"
        let expectation = XCTestExpectation(description: "Password Error Field is not shown")
        
        viewModelToTest.login()
        viewModelToTest.isLoginValid.sink { _ in
            XCTAssertEqual(self.viewModelToTest.showPasswordError, false)
            expectation.fulfill()
        }.store(in: &cancellables)
       
        wait(for: [expectation], timeout: 1)
    }
    
    func testEmailErrorFieldIsNotShown() {
        viewModelToTest.email = "oduekene@gmail.com"
        viewModelToTest.password = "123456"
        let expectation = XCTestExpectation(description: "Email Error Field is not shown")
        
        viewModelToTest.login()
        viewModelToTest.isLoginValid.sink { _ in
            XCTAssertEqual(self.viewModelToTest.showEmailError, false)
            expectation.fulfill()
        }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
}
