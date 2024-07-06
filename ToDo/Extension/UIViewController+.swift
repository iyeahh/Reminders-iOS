//
//  UIViewController+.swift
//  ToDo
//
//  Created by Bora Yang on 7/6/24.
//

import UIKit

extension UIViewController {
    func saveImageToDocument(image: UIImage, filename: String) {

        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }

        // ⭐️ 이미지를 저장할 경로(파일명) 지정
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")

        // 이미지 압축 (압축률) - png도 가능
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }

        // 이미지 파일 저장
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }

    func loadImageToDocument(filename: String) -> UIImage? {

        // 도큐먼트 찾아가기
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }

        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")

        //이 경로에 실제로 파일이 존재하는 지 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return nil
        }
    }

    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }

        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")

        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
            // 완벽하게 처리될 때까지 다른 일을 하지 않도록
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("file remove error", error)
            }

        } else {
            print("file no exist")
        }
    }
}
