//
//  Created by Антон Лобанов on 06.06.2021.
//

import Foundation

// MARK: - FileLogOutputStrategy

final class FileLogOutputStrategy {
	private static let accurateDateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd-MM-yyyy HH:mm:ss.SSS"
		return formatter
	}()

	private let logFilePath: URL
	private let needSyncAfterEachWrite: Bool

	private let fileManager = FileManager.default
	private var fileHandle: FileHandle?

	init(logFilePath: URL, needSyncAfterEachWrite: Bool = false) {
		self.logFilePath = logFilePath
		self.needSyncAfterEachWrite = needSyncAfterEachWrite
	}

	deinit {
		self.writeEndSeparator()
		self.fileHandle?.closeFile()
	}
}

// MARK: - ILogOutputStrategy

extension FileLogOutputStrategy: ILogOutputStrategy {
	func log(_: LogType, message: String, callPoint _: String) {
		guard let origin = Bundle.main.bundleIdentifier else {
			assertionFailure("Bundle.main.bundleIdentifier должен существовать.")
			return
		}

		let currentDateTime = FileLogOutputStrategy.accurateDateFormatter.string(from: Date())

		let outputContent = String(
			format: Environment.Appearance.defaultLogFormat,
			currentDateTime,
			origin,
			message
		)

		if (try? self.logFilePath.checkResourceIsReachable()) ?? false {
			self.writeToEnd(content: outputContent)
		}
		else {
			self.createAndWrite(content: outputContent)
		}
	}
}

// MARK: - Private Helpers

private extension FileLogOutputStrategy {
	func createAndWrite(content: String) {
		do {
			try content.appending("\n").write(to: self.logFilePath, atomically: true, encoding: .utf8)
		}
		catch {
			assertionFailure("Не получилось cоздать или записать логи в файл: \(self.logFilePath)\nError: \(error)")
		}
	}

	func writeToEnd(content: String) {
		if self.fileHandle == nil {
			do {
				self.fileHandle = try FileHandle(forWritingTo: self.logFilePath)
			}
			catch {
				assertionFailure("Не получилось записать логи в файл: \(self.logFilePath)\nError: \(error)")
			}
		}

		self.fileHandle?.seekToEndOfFile()

		guard let contentData = content.appending("\n").data(using: .utf8) else {
			assertionFailure("Не получилось конвертировать string-лог в Data: \(content)\n")
			return
		}

		self.fileHandle?.write(contentData)

		if self.needSyncAfterEachWrite {
			self.fileHandle?.synchronizeFile()
		}
	}

	func writeEndSeparator() {
		let separator = String(repeating: "=", count: Environment.Appearance.separatorLength)
		self.writeToEnd(content: separator)
	}
}
