//
//  PeopleListViewControllerTests.swift
//  Birthdays
//
//  Created by Kan Chen on 3/7/16.
//  Copyright © 2016 Dominik Hauser. All rights reserved.
//
import UIKit
import XCTest
import Birthdays
import CoreData
import AddressBookUI

class PeopleListViewControllerTests: XCTestCase {
    var viewController: PeopleListViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PeopleListViewController") as! PeopleListViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testDataProviderHasTableViewPropertySetAfterLoading() {
        // Given
        let mockDataProvider = MockDataProvider()
        viewController.dataProvider = mockDataProvider
        // When
        XCTAssertNil(mockDataProvider.tableView, "Before loading the table view should be nil")
        let _ = viewController.view
        // then
        XCTAssertTrue(mockDataProvider.tableView != nil, "The table view should be set")
        XCTAssert(mockDataProvider.tableView == viewController.tableView,
            "The table view should be set to the table view of the data source")
    }

    func testCallsAddPersonOfThePeopleDataSourceAfterAddingAPersion() {
        // Given
        let mockDataSource = MockDataProvider()

        viewController.dataProvider = mockDataSource
        // When
        let record = ABPersonCreate().takeRetainedValue()
        ABRecordSetValue(record, kABPersonFirstNameProperty, "TestFirstname", nil)
        ABRecordSetValue(record, kABPersonLastNameProperty, "TestLastname", nil)
        ABRecordSetValue(record, kABPersonBirthdayProperty, NSDate(), nil)

        viewController.peoplePickerNavigationController(ABPeoplePickerNavigationController(), didSelectPerson: record)

        // Then
        XCTAssert(mockDataSource.addPersonGotCalled, "addPerson should have been called")
    }

    func testSortingCanBeChanged() {
        // given
        // 1
        let mockUserDefaults = MockUserDefault(suiteName: "testing")!
        viewController.userDefaults = mockUserDefaults

        //when
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(viewController, action: "changeSorting:", forControlEvents: .ValueChanged)
        segmentedControl.sendActionsForControlEvents(.ValueChanged)

        XCTAssertTrue(mockUserDefaults.sortWasChanged, "Sort value in user defaults should be altered")
    }

    class MockUserDefault: NSUserDefaults {
        var sortWasChanged = false
        override func setInteger(value: Int, forKey defaultName: String) {
            if defaultName == "sort" {
                sortWasChanged = true
            }
        }
    }

    class MockDataProvider: NSObject, PeopleListDataProviderProtocol {
        var managedObjectContext: NSManagedObjectContext?
        var addPersonGotCalled = false
        weak var tableView: UITableView!
        func addPerson(personInfo: PersonInfo) {
            addPersonGotCalled = true
        }
        func fetch() {

        }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }

    class MockAPICommunicator: APICommunicatorProtocol {
        var allPersonInfo = [PersonInfo]()
        var postPersionGotCalled = false

        func getPeople() -> (NSError?, [PersonInfo]?) {
            return (nil, allPersonInfo)
        }

        func postPerson(personInfo: PersonInfo) -> NSError? {
            postPersionGotCalled = true
            return nil
        }
    }

    func testFetchingPeopleFromAPICallsAddPeople() {
        let mockDataProvider = MockDataProvider()
        viewController.dataProvider = mockDataProvider

        let mockCommunicator = MockAPICommunicator()
        mockCommunicator.allPersonInfo = [PersonInfo(firstName: "firstName", lastName: "lastNAme", birthday: NSDate())]
        viewController.communicator = mockCommunicator

        viewController.fetchPeopleFromAPI()
        XCTAssert(mockDataProvider.addPersonGotCalled, "addPersion should heve beend called")

    }
}
