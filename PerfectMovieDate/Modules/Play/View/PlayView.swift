//
//  PlayView.swift
//  PerfectMovieDate
//
//  Created by Muhammad Rezky on 31/07/24.
//

import SwiftUI

class PlayViewModel: ObservableObject {
    @Published var movieTitle: String = ""
    @Published var posterURL: URL?
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
}


struct PlayView: View, PlayViewProtocol {
    func updatePosterImage(_ image: UIImage?) {
    }
    
    func showMatchedMovieModal() {
    }
    
    @ObservedObject var vm: PlayViewModel
    
    var presenter: PlayPresenterProtocol?

    var body: some View {
        VStack {
            if vm.isLoading {
                ProgressView("Loading...")
            } else {
                Text(vm.movieTitle)
                if let posterURL = vm.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image.resizable()
                             .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 300)
                }
                HStack {
                    Button("Yes", action: {
                        presenter?.didTapYes()
                    })
                }
            }
        }
        .onAppear {
            presenter?.viewDidLoad()
        }
        .alert(isPresented: $vm.showError) {
            Alert(title: Text("Error"), message: Text(vm.errorMessage), dismissButton: .default(Text("OKeeeee")))
        }
    }
    
    func updateCurrentMovie(with movie: MovieEntityProtocol) {
        vm.movieTitle = movie.title
        print(vm.movieTitle, "121212")
        print(movie.title, "akhsoah")
        if let posterPath = movie.posterPath {
            vm.posterURL = URL(string: "https://image.tmdb.org/t/p/w400/\(posterPath)")
        }
    }
}


//#Preview {
//    var view = PlayView(vm: PlayViewModel())
//    let presenter: PlayPresenterProtocol = PlayPresenter()
//    let repository: RoomRepository = FirebaseRoomRepository()
//    let movieService: MovieServiceProtocol = TMDBMovieService()
//    let interactor: PlayInteractorProtocol = PlayInteractor(
//        repository: repository,
//        movieService: movieService
//    )
//    let router: PlayRouterProtocol = PlayRouter()
//
//    view.presenter = presenter
//    presenter.view = view
//    presenter.interactor = interactor
//    presenter.router = router
//    interactor.presenter = presenter as? PlayInteractorOutputProtocol
//
//    return view
//}
