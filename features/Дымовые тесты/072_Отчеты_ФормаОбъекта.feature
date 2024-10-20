﻿
#language: ru

@tree

Функциональность: Дымовые тесты - Отчеты - ФормаОбъекта
# Конфигурация: Барбершоп
# Версия: 1.0.1.1

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Открытие формы отчета "Анализ журнала регистрации"

	Дано Я открываю основную форму отчета "АнализЖурналаРегистрации"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета АнализЖурналаРегистрации"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета АнализЖурналаРегистрации"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Даты запрета загрузки"

	Дано Я открываю основную форму отчета "ДатыЗапретаЗагрузки"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДатыЗапретаЗагрузки"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДатыЗапретаЗагрузки"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Даты запрета изменения"

	Дано Я открываю основную форму отчета "ДатыЗапретаИзменения"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДатыЗапретаИзменения"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДатыЗапретаИзменения"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Движения документа"

	Дано Я открываю основную форму отчета "ДвиженияДокумента"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДвиженияДокумента"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДвиженияДокумента"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Длительность отложенного обновления"

	Дано Я открываю основную форму отчета "ДлительностьОтложенногоОбновления"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДлительностьОтложенногоОбновления"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДлительностьОтложенногоОбновления"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Контроль рассылки отчетов"

	Дано Я открываю основную форму отчета "КонтрольРассылкиОтчетов"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета КонтрольРассылкиОтчетов"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета КонтрольРассылкиОтчетов"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Оценка производительности"

	Дано Я открываю основную форму отчета "ОценкаПроизводительности"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ОценкаПроизводительности"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ОценкаПроизводительности"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Прогресс отложенного обновления"

	Дано Я открываю основную форму отчета "ПрогрессОтложенногоОбновления"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ПрогрессОтложенногоОбновления"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ПрогрессОтложенногоОбновления"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Универсальный отчет"

	Дано Я открываю основную форму отчета "УниверсальныйОтчет"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета УниверсальныйОтчет"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета УниверсальныйОтчет"
	И Я закрываю текущее окно

Сценарий: Открытие формы отчета "Продажи (дашборд)"

	Дано Я открываю основную форму отчета "ДашбордПродажи"
	Если появилось предупреждение Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДашбордПродажи"
	Если имя текущей формы "ErrorWindow" Тогда
		Тогда я вызываю исключение "Не удалось открыть основную форму отчета ДашбордПродажи"
	И Я закрываю текущее окно
