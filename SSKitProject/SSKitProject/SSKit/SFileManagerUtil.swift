//
//  FileManagerUtil.swift
//  1xpocket
//
//  Created by 黄世文 on 2022/3/8.
//

import Foundation

class SFileManagerUtil {
    
    static let share = SFileManagerUtil()
    
    private init() {}
    
    var systemNotice: String {
        get {
            return "SystemNotice"
        }
    }
    
    var transferNotice: String {
        get {
            return "transferNotice"
        }
    }
    
    var walletAddress: String {
        get {
            return "walletAddress"
        }
    }
    
    var multipleAddress: String {
        get {
            return "MultipleAddress"
        }
    }
    
    /// 指定文件是否存在
    func hasFile(fileName: String) -> Bool {
        let fileManager = FileManager.default
        let filePath:String = NSHomeDirectory() + "/Documents/" + fileName + "/" + fileName + ".txt"
        let exist = fileManager.fileExists(atPath: filePath)
        return exist
    }
    
    /// 创建文件
    func createFile(fileName: String) {
        let myDirectory:String = NSHomeDirectory() + "/Documents/" + fileName
        let fileManager = FileManager.default
         //withIntermediateDirectories为ture表示路径中间如果有不存在的文件夹都会创建
        try! fileManager.createDirectory(atPath: myDirectory,
                                         withIntermediateDirectories: true, attributes: nil)
       
        let manager = FileManager.default
        
        let file = NSHomeDirectory() + "/Documents/" + fileName + "/" + fileName + ".txt"
        print("文件: \(file)")
        let exist = manager.fileExists(atPath: file)
        if !exist {
            let data = Data()
            let createSuccess = manager.createFile(atPath: file,contents:data,attributes:nil)
            print("文件创建结果: \(createSuccess)")
        }
    }
    
    func saveFileData(fileName: String, dataJson: String) {
        let filePath:String = NSHomeDirectory() + "/Documents/" + fileName + "/" + fileName + ".txt"
        try? dataJson.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
    }
    
    func dataJsonFileData(fileName: String) -> String? {
        let manager = FileManager.default
        let file = NSHomeDirectory() + "/Documents/" + fileName + "/" + fileName + ".txt"
        let exist = manager.fileExists(atPath: file)
        if exist {
            let fileContent = try? String(contentsOfFile: file, encoding: .utf8)
            return fileContent
        }
        return nil
    }
}
