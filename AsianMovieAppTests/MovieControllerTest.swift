//
//  MovieControllerTest.swift
//  AsianMovieAppTests
//
//  Created by SourabhMehta on 12/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import XCTest
@testable import AsianMovieApp

class MovieControllerTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    
    func testMovies() {
        // Create an expectation object.
        let moviesRetrieved = expectation(description: "Movies retrieved")
        MovieController.movies(pageIndex: 1, withCompletion: { result in
            switch result {
            case .success(let allMovies):
                XCTAssert(allMovies.results.count > 0)
                moviesRetrieved.fulfill()
            case .failure(_):
                 XCTFail("Could not retrieve Movies")
            }
        })
        waitForExpectations(timeout: 10, handler: { error in })
    }
    
    func testMovieDetails() {
           // Create an expectation object.
           let movieId = 301528
           MovieController.movieDetail(movieId: movieId, withCompletion:{ result in
               switch result {
               case .success(let movieObject):
                   XCTAssertEqual(movieObject.id, movieId, "Movie Detail retrieved")
               case .failure(_):
                    XCTFail("Could not retrieve Movies")
               }
           })
       }
    
    
    func testAllMoviesWithIndex() {
        // Create an expectation object.
        let moviesWithIndexTitleRetrieved = expectation(description: "All Movies retrieved with index title like A,B,C,....#")
        var movieListSections: [MovieListSection] = []
        MovieController.movies(pageIndex: 1, withCompletion: { result in
            switch result {
            case .success(let allMovies):
                movieListSections = MovieController.getAllMoviesWithIndex(movies: allMovies.results)
                XCTAssert(movieListSections.count > 0)
                moviesWithIndexTitleRetrieved.fulfill()
            case .failure(_):
                XCTFail("Could not retrieve movies with index title like A,B,C,....#")
            }
        })
        waitForExpectations(timeout: 10, handler: { error in })
    }
    
    func testPerformanceMovies() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            MovieController.movies(pageIndex: 1, withCompletion: { result in
                switch result {
                case .success(let allMovies):
                    XCTAssert(allMovies.results.count > 0)
                case .failure(_):
                    XCTFail("Could not retrieve movies")
                }
            })
        }
    }
    func testPerformanceMovieDetail() {
        // This is an example of a performance test case.
        self.measure {
             let movieId = 301528
            // Put the code you want to measure the time of here.
            MovieController.movieDetail(movieId: movieId, withCompletion: { result in
                switch result {
                case .success(let movieObject):
                    XCTAssertEqual(movieObject.id, movieId, "Movie Detail retrieved")
                case .failure(_):
                    XCTFail("Could not retrieve movie detail")
                }
            })
        }
    }

}
