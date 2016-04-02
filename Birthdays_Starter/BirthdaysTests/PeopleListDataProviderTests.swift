//
//  PeopleListDataProviderTests.swift
//  Birthdays
//
//  Created by Kan Chen on 3/7/16.
//  Copyright © 2016 Dominik Hauser. All rights reserved.
//

import XCTest
import CoreData
import Birthdays

class PeopleListDataProviderTests: XCTestCase {
    var storeCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext!
    var managedObjectModel: NSManagedObjectModel!
    var store: NSPersistentStore!

    var dataProvider: PeopleListDataProvider!

    var tableView: UITableView!
    var testRecord: PersonInfo!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)
        storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        store = try! storeCoordinator.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)

        managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = storeCoordinator

        dataProvider = PeopleListDataProvider()
        dataProvider.managedObjectContext = managedObjectContext

        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PeopleListViewController") as! PeopleListViewController
        viewController.dataProvider = dataProvider
        tableView = viewController.tableView
        testRecord = PersonInfo(firstName: "TestFirstName", lastName: "TestLastName", birthday: NSDate())
    }
    
    override func tearDown() {
        managedObjectContext = nil
        var error: NSError? = nil
        do {
            try storeCoordinator.removePersistentStore(store)
        } catch let error1 as NSError {
            error = error1
            XCTAssert(false, "could not remove \(error1)")
        }
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThatStoreIsSetUp() {
        XCTAssertNotNil(store, "no Persistent store")
    }

    func testOnePersonInThePersistantStoreResultsInOneRow() {
        dataProvider.addPerson(testRecord)
        XCTAssertEqual(tableView.dataSource!.tableView(tableView, numberOfRowsInSection: 0), 1,
            "After adding one person number of rows is not 1")
    }
}
