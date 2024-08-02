//
//  StorageManager.swift
//  massenger
//
//  Created by Ozan Öneyman on 29.07.2024.
//

import Foundation
import FirebaseStorage

final class StorageManager{
    static let shared = StorageManager()
     
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String,Error>) -> Void
     
     
     
     ///uploads picture to firebase storeage and returns completion with url sting to download
    
    public func uploadProfilePicture(with data : Data, fileName: String, completion : @escaping UploadPictureCompletion )
    {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { metadata , error in
            guard error == nil else{
                print("failed to upload data to firebase")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else{
                    print("failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return 
                }
                
                let urlString = url.absoluteString
                print("download url returned : \(urlString)")
                completion(.success(urlString))
            })
            
        })
    }
    public enum StorageErrors : Error {
        case failedToUpload
        case failedToGetDownloadUrl
        
    }
    
    public  func downloadURL(for path: String,  completion: @escaping (Result< URL ,Error>) -> Void){
        let reference = storage.child(path)
        
        reference.downloadURL(completion: { url, error in
            guard let url = url , error == nil else{
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
                    
            completion(.success(url))
        })
    }
}
