//
//  Created by Антон Лобанов on 06.06.2021.
//

public protocol ILogger: AnyObject {
	/// Информация большого объёма, анализ или описание того или иного момента.
	/// В большинстве случаев является избыточным уровнем логирования.
	static func verbose(
		_ message: String,
		_ file: StaticString,
		_ function: StaticString,
		_ line: UInt
	)

	/// Информация, которая может быть полезна не только для разработчиков.
	/// Для более детальной информации, в info помечается, что есть дополнительная информация,
	/// которая, в свою очередь, записывается в verbose.
	static func info(
		_ message: String,
		_ file: StaticString,
		_ function: StaticString,
		_ line: UInt
	)

	/// Информация, которая может быть полезна разработчикам в рамках Debug-режима: значения переменных и т.п.
	static func debug(
		_ message: String,
		_ file: StaticString,
		_ function: StaticString,
		_ line: UInt
	)

	/// Предупреждения, которые не приводят к сбоям и некорректной работе программы.
	static func warning(
		_ message: String,
		_ file: StaticString,
		_ function: StaticString,
		_ line: UInt
	)

	/// Ошибки, которые могут привести к сбоям и некорректной работе программы.
	static func error(
		_ message: String,
		_ file: StaticString,
		_ function: StaticString,
		_ line: UInt
	)
}
