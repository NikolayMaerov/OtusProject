﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Обработчик команды формы отчета.
//
// Параметры:
//   Форма     - ФормаКлиентскогоПриложения - форма отчета.
//   Команда   - КомандаФормы     - команда, которая была вызвана.
//
// Места использования:
//   ОбщаяФорма.ФормаОтчета.Подключаемый_Команда().
//
Процедура СоздатьНовуюРассылкуИзОтчета(Форма, Команда) Экспорт
	ОткрытьРассылкуИзФормыОтчета(Форма);
КонецПроцедуры

// Обработчик команды формы отчета.
//
// Параметры:
//   Форма     - ФормаКлиентскогоПриложения - форма отчета.
//   Команда   - КомандаФормы     - команда, которая была вызвана.
//
// Места использования:
//   ОбщаяФорма.ФормаОтчета.Подключаемый_Команда().
//
Процедура ПрисоединитьОтчетКСуществующейРассылке(Форма, Команда) Экспорт
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	ПараметрыФормы.Вставить("ВыборГруппИЭлементов", ИспользованиеГруппИЭлементов.Элементы);
	ПараметрыФормы.Вставить("МножественныйВыбор", Ложь);
	
	ОткрытьФорму("Справочник.РассылкиОтчетов.ФормаВыбора", ПараметрыФормы, Форма);
КонецПроцедуры

// Обработчик команды формы отчета.
//
// Параметры:
//   Форма     - ФормаКлиентскогоПриложения - форма отчета.
//   Команда   - КомандаФормы     - команда, которая была вызвана.
//
// Места использования:
//   ОбщаяФорма.ФормаОтчета.Подключаемый_Команда().
//
Процедура ОткрытьРассылкиСОтчетом(Форма, Команда) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Отчет", Форма.НастройкиОтчета.ВариантСсылка);
	ОткрытьФорму("Справочник.РассылкиОтчетов.ФормаСписка", ПараметрыФормы, Форма);
	
КонецПроцедуры

// Обработчик выбора формы отчета.
//
// Параметры:
//   Форма             - ФормаКлиентскогоПриложения - форма отчета.
//   ВыбранноеЗначение - Произвольный     - результат выбора в подчиненной форме.
//   ИсточникВыбора    - ФормаКлиентскогоПриложения - форма, где осуществлен выбор.
//   Результат         - Булево           - Истина, если результат выбора обработан.
//
// Места использования:
//   ОбщаяФорма.ФормаОтчета.ОбработкаВыбора().
//
Процедура ФормаОтчетаОбработкаВыбора(Форма, ВыбранноеЗначение, ИсточникВыбора, Результат) Экспорт
	
	Если Результат = Истина Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ВыбранноеЗначение) = Тип("СправочникСсылка.РассылкиОтчетов") Тогда
		
		ОткрытьРассылкуИзФормыОтчета(Форма, ВыбранноеЗначение);
		
		Результат = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОчиститьИсториюРассылкиОтчетов(Форма) Экспорт

	Если Форма.НаборКонстант.ХранитьИсториюРассылкиОтчетов Тогда
		ТекстВопроса = СтроковыеФункцииКлиент.ФорматированнаяСтрока(НСтр(
		"ru = 'Очистить устаревшую историю рассылки отчетов?'"));
	Иначе
		ТекстВопроса = СтроковыеФункцииКлиент.ФорматированнаяСтрока(НСтр(
		"ru = 'Очистить историю рассылки отчетов?'"));
	КонецЕсли;

	Параметры = Новый Структура("Форма", Форма);

	ПоказатьВопрос(Новый ОписаниеОповещения("ОтветОчиститьИсториюРассылкиОтчетов", ЭтотОбъект, Параметры), ТекстВопроса,
		РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует список получателей рассылки, предлагает пользователю выбрать
//   конкретного получателя или всех получателей рассылки и возвращает
//   результат выбора пользователя.
// Вызывается из формы элемента.
//
Процедура ВыбратьПолучателя(ОбработчикРезультата, Объект, МножественныйВыбор, ВозвращатьСоответствие) Экспорт
	
	Если Объект.Личная = Истина Тогда
		НаборПараметров = "Ссылка, ВидПочтовогоАдресаПолучателей, Личная, Автор";
	Иначе
		НаборПараметров = "Ссылка, ВидПочтовогоАдресаПолучателей, Личная, ТипПолучателейРассылки, Получатели";
	КонецЕсли;
	
	ПараметрыПолучателей = Новый Структура(НаборПараметров);
	ЗаполнитьЗначенияСвойств(ПараметрыПолучателей, Объект);
	РезультатВыполнения = РассылкаОтчетовВызовСервера.СформироватьСписокПолучателейРассылки(ПараметрыПолучателей);
	
	Если РезультатВыполнения.БылиКритичныеОшибки Тогда
		ПараметрыВопросаПользователю = СтандартныеПодсистемыКлиент.ПараметрыВопросаПользователю();
		ПараметрыВопросаПользователю.ПредлагатьБольшеНеЗадаватьЭтотВопрос = Ложь;
		ПараметрыВопросаПользователю.Картинка = БиблиотекаКартинок.Предупреждение32;
		СтандартныеПодсистемыКлиент.ПоказатьВопросПользователю(Неопределено, РезультатВыполнения.Текст, 
			РежимДиалогаВопрос.ОК, ПараметрыВопросаПользователю);
		Возврат;
	КонецЕсли;
	
	Получатели = РезультатВыполнения.Получатели;
	Если Получатели.Количество() = 1 Тогда
		Результат = Получатели;
		Если Не ВозвращатьСоответствие Тогда
			Для Каждого КлючИЗначение Из Получатели Цикл
				Результат = Новый Структура("Получатель, ПочтовыйАдрес", КлючИЗначение.Ключ, КлючИЗначение.Значение);
			КонецЦикла;
		КонецЕсли;
		ВыполнитьОбработкуОповещения(ОбработчикРезультата, Результат);
		Возврат;
	КонецЕсли;
	
	ВозможныеПолучатели = Новый СписокЗначений;
	Для Каждого КлючИЗначение Из Получатели Цикл
		ВозможныеПолучатели.Добавить(КлючИЗначение.Ключ, Строка(КлючИЗначение.Ключ) +" <"+ КлючИЗначение.Значение +">");
	КонецЦикла;
	Если МножественныйВыбор Тогда
		ВозможныеПолучатели.Вставить(0, Неопределено, НСтр("ru = 'Всем получателям'"));
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ОбработчикРезультата", ОбработчикРезультата);
	ДополнительныеПараметры.Вставить("Получатели", Получатели);
	ДополнительныеПараметры.Вставить("ВозвращатьСоответствие", ВозвращатьСоответствие);
	
	Обработчик = Новый ОписаниеОповещения("ВыбратьПолучателяЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	ВозможныеПолучатели.ПоказатьВыборЭлемента(Обработчик, НСтр("ru = 'Выбор получателя'"));
	
КонецПроцедуры

// Обработчик результата работы процедуры ВыбратьПолучателя.
// 
// Параметры:
//   ВыбранныйЭлемент - ЭлементСпискаЗначений
//   ДополнительныеПараметры - Структура:
//     * ОбработчикРезультата - ОписаниеОповещения
//     * Получатели - Соответствие из КлючЗначение:
//       ** Ключ - Произвольный
//       ** Значение - Строка 
//     * ВозвращатьСоответствие - Булево
//
Процедура ВыбратьПолучателяЗавершение(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	Если ВыбранныйЭлемент = Неопределено Тогда
		Результат = Неопределено;
	Иначе
		Если ДополнительныеПараметры.ВозвращатьСоответствие Тогда
			Если ВыбранныйЭлемент.Значение = Неопределено Тогда
				Результат = ДополнительныеПараметры.Получатели;
			Иначе
				Результат = Новый Соответствие;
				Результат.Вставить(ВыбранныйЭлемент.Значение, ДополнительныеПараметры.Получатели[ВыбранныйЭлемент.Значение]);
			КонецЕсли;
		Иначе
			Результат = Новый Структура("Получатель, ПочтовыйАдрес", ВыбранныйЭлемент.Значение, ДополнительныеПараметры.Получатели[ВыбранныйЭлемент.Значение]);
		КонецЕсли;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОбработчикРезультата, Результат);
КонецПроцедуры

// Выполняет рассылки в фоне.
Процедура ВыполнитьСейчас(Параметры) Экспорт
	Обработчик = Новый ОписаниеОповещения("ВыполнитьСейчасВФоне", ЭтотОбъект, Параметры);
	Если Параметры.ЭтоФормаЭлемента Тогда
		Объект = Параметры.Форма.Объект;
		Если Не Объект.Подготовлена Тогда
			ПоказатьПредупреждение(, НСтр("ru = 'Рассылка не подготовлена.'"));
			Возврат;
		КонецЕсли;
		Если Объект.ИспользоватьЭлектроннуюПочту Тогда
			ВыбратьПолучателя(Обработчик, Параметры.Форма.Объект, Истина, Истина);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	ВыполнитьОбработкуОповещения(Обработчик, Неопределено);
КонецПроцедуры

// Запускает фоновое задание, вызывается когда все параметры уже готовы.
Процедура ВыполнитьСейчасВФоне(Получатели, Параметры) Экспорт
	ПредварительныеНастройки = Неопределено;
	Если Параметры.ЭтоФормаЭлемента Тогда
		Если Параметры.Форма.Объект.ИспользоватьЭлектроннуюПочту Тогда
			Если Получатели = Неопределено Тогда
				Возврат;
			КонецЕсли;
			ПредварительныеНастройки = Новый Структура("Получатели", Получатели);
		КонецЕсли;
		ТекстСостояния = НСтр("ru = 'Выполняется рассылка отчетов.'");
	Иначе
		ТекстСостояния = НСтр("ru = 'Выполняются рассылки отчетов.'");
	КонецЕсли;
	
	ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("МассивРассылок", Параметры.МассивРассылок);
	ПараметрыМетода.Вставить("ПредварительныеНастройки", ПредварительныеНастройки);
	
	Задание = РассылкаОтчетовВызовСервера.ЗапуститьФоновоеЗадание(ПараметрыМетода, Параметры.Форма.УникальныйИдентификатор);
	
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Параметры.Форма);
	НастройкиОжидания.ВыводитьОкноОжидания = Истина;
	НастройкиОжидания.ТекстСообщения = ТекстСостояния;
	
	Обработчик = Новый ОписаниеОповещения("ВыполнитьСейчасВФонеЗавершение", ЭтотОбъект, Параметры);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(Задание, Обработчик, НастройкиОжидания);
	
КонецПроцедуры

// Принимает результат выполнения фонового задания.
Процедура ВыполнитьСейчасВФонеЗавершение(Задание, Параметры) Экспорт
	
	Если Задание = Неопределено Тогда
		Возврат; // Отменено.
	КонецЕсли;
	
	Если Задание.Статус = "Выполнено" Тогда
		Результат = ПолучитьИзВременногоХранилища(Задание.АдресРезультата);
		КоличествоРассылок = Результат.Рассылки.Количество();
		Если КоличествоРассылок > 0 Тогда
			ОповеститьОбИзменении(?(КоличествоРассылок > 1, Тип("СправочникСсылка.РассылкиОтчетов"), Результат.Рассылки[0]));
		КонецЕсли;
		ПоказатьОповещениеПользователя(,, Результат.Текст, БиблиотекаКартинок.РассылкаОтчетов, СтатусОповещенияПользователя.Информация);
		
	Иначе
		ВызватьИсключение НСтр("ru = 'Не удалось выполнить рассылки отчетов:'")
			+ Символы.ПС + Задание.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
КонецПроцедуры

// Открывает рассылку отчетов из формы отчета.
//
// Параметры:
//   Форма  - ФормаКлиентскогоПриложения - форма отчета.
//   Ссылка - СправочникСсылка.РассылкиОтчетов - ссылка рассылки отчетов.
//
Процедура ОткрытьРассылкуИзФормыОтчета(Форма, Ссылка = Неопределено)
	НастройкиОтчета = Форма.НастройкиОтчета;
	РежимВариантаОтчета = (ТипЗнч(Форма.КлючТекущегоВарианта) = Тип("Строка") И Не ПустаяСтрока(Форма.КлючТекущегоВарианта));
	
	СтрокаОтчетыПараметры = Новый Структура("ОтчетПолноеИмя, КлючВарианта, ВариантСсылка, Настройки");
	СтрокаОтчетыПараметры.ОтчетПолноеИмя = НастройкиОтчета.ПолноеИмя;
	СтрокаОтчетыПараметры.КлючВарианта   = Форма.КлючТекущегоВарианта;
	СтрокаОтчетыПараметры.ВариантСсылка  = НастройкиОтчета.ВариантСсылка;
	Если РежимВариантаОтчета Тогда
		СтрокаОтчетыПараметры.Настройки = Форма.Отчет.КомпоновщикНастроек.ПользовательскиеНастройки;
	КонецЕсли;
	
	ПрисоединяемыеОтчеты = Новый Массив;
	ПрисоединяемыеОтчеты.Добавить(СтрокаОтчетыПараметры);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ПрисоединяемыеОтчеты", ПрисоединяемыеОтчеты);
	Если Ссылка <> Неопределено Тогда
		ПараметрыФормы.Вставить("Ключ", Ссылка);
	КонецЕсли;
	
	ОткрытьФорму("Справочник.РассылкиОтчетов.ФормаОбъекта", ПараметрыФормы, , Строка(Форма.УникальныйИдентификатор) + ".ОткрытьРассылкуОтчетов");
	
КонецПроцедуры

// Возвращает набор шаблонов заполнения расписаний регламентного задания.
Функция СписокВариантовЗаполненияРасписаний() Экспорт
	
	СписокВариантов = Новый СписокЗначений;
	СписокВариантов.Добавить(1, НСтр("ru = 'Каждый день'"));
	СписокВариантов.Добавить(2, НСтр("ru = 'Каждый второй день'"));
	СписокВариантов.Добавить(3, НСтр("ru = 'Каждый четвертый день'"));
	СписокВариантов.Добавить(4, НСтр("ru = 'По будням'"));
	СписокВариантов.Добавить(5, НСтр("ru = 'По выходным'"));
	СписокВариантов.Добавить(6, НСтр("ru = 'По понедельникам'"));
	СписокВариантов.Добавить(7, НСтр("ru = 'По пятницам'"));
	СписокВариантов.Добавить(8, НСтр("ru = 'По воскресеньям'"));
	СписокВариантов.Добавить(9, НСтр("ru = 'В первый день месяца'"));
	СписокВариантов.Добавить(10, НСтр("ru = 'В последний день месяца'"));
	СписокВариантов.Добавить(11, НСтр("ru = 'Каждый квартал десятого числа'"));
	СписокВариантов.Добавить(12, НСтр("ru = 'Другое...'"));
	
	Возврат СписокВариантов;
КонецФункции

// Разбирает строку FTP адреса на Логин, Пароль, Сервер, Порт и Каталог.
//   Подробнее - см. RFC 1738 (http://tools.ietf.org/html/rfc1738#section-3.1).
//   Шаблон: "ftp://<user>:<password>@<host>:<port>/<url-path>".
//   Фрагменты "<user>:<password>@", ":<password>", ":<port>" и "/<url-path>" могут отсутствовать.
//
// Параметры:
//   FTPАдрес - Строка - полный путь к ftp ресурсу.
//
// Возвращаемое значение:
//   Структура - результат - Структура - Результат разбора полного пути:
//       * Логин - Строка - имя пользователя ftp.
//       * Пароль - Строка - пароль пользователя ftp.
//       * Сервер - Строка - имя сервера.
//       * Порт - Число - порт сервера. По умолчанию 21.
//       * Каталог - Строка - путь к каталогу на сервере. Первый символ всегда "/".
//
Функция РазобратьFTPАдрес(ПолныйFTPАдрес) Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Логин", "");
	Результат.Вставить("Пароль", "");
	Результат.Вставить("Сервер", "");
	Результат.Вставить("Порт", 21);
	Результат.Вставить("Каталог", "/");
	
	FTPАдрес = ПолныйFTPАдрес;
	
	// Вырезать "ftp://".
	Поз = СтрНайти(FTPАдрес, "://");
	Если Поз > 0 Тогда
		FTPАдрес = Сред(FTPАдрес, Поз + 3);
	КонецЕсли;
	
	// Каталог.
	Поз = СтрНайти(FTPАдрес, "/");
	Если Поз > 0 Тогда
		Результат.Каталог = Сред(FTPАдрес, Поз);
		FTPАдрес = Лев(FTPАдрес, Поз - 1);
	КонецЕсли;
	
	// Логин и пароль.
	Поз = СтрНайти(FTPАдрес, "@");
	Если Поз > 0 Тогда
		ЛогинПароль = Лев(FTPАдрес, Поз - 1);
		FTPАдрес = Сред(FTPАдрес, Поз + 1);
		
		Поз = СтрНайти(ЛогинПароль, ":");
		Если Поз > 0 Тогда
			Результат.Логин = Лев(ЛогинПароль, Поз - 1);
			Результат.Пароль = Сред(ЛогинПароль, Поз + 1);
		Иначе
			Результат.Логин = ЛогинПароль;
		КонецЕсли;
	КонецЕсли;
	
	// Сервер и порт.
	Поз = СтрНайти(FTPАдрес, ":");
	Если Поз > 0 Тогда
		
		Результат.Сервер = Лев(FTPАдрес, Поз - 1);
		
		ТипЧисло = Новый ОписаниеТипов("Число");
		Порт     = ТипЧисло.ПривестиЗначение(Сред(FTPАдрес, Поз + 1));
		Результат.Порт = ?(Порт > 0, Порт, Результат.Порт);
		
	Иначе
		
		Результат.Сервер = FTPАдрес;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Выполняет рассылку SMS с паролями рассылки в фоне.
Процедура ВыполнитьРассылкуSMS(Параметры) Экспорт
	Обработчик = Новый ОписаниеОповещения("ВыполнитьРассылкуSMSВФоне", ЭтотОбъект, Параметры);
	ВыполнитьОбработкуОповещения(Обработчик, Неопределено);
КонецПроцедуры

// Запускает фоновое задание, вызывается когда все параметры уже готовы.
Процедура ВыполнитьРассылкуSMSВФоне(Получатели, Параметры) Экспорт

	ПараметрыМетода = Новый Структура;
	ПараметрыМетода.Вставить("ПодготовленныеSMS", Параметры.ПодготовленныеSMS);
	ПараметрыМетода.Вставить("КоличествоНеОтправлено", Параметры.КоличествоНеОтправлено);
	
	Задание = РассылкаОтчетовВызовСервера.ЗапуститьФоновоеЗаданиеРассылкиSMSСПаролями(ПараметрыМетода,
		Параметры.Форма.УникальныйИдентификатор);
	
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Параметры.Форма);
	НастройкиОжидания.ВыводитьОкноОжидания = Истина;
	НастройкиОжидания.ТекстСообщения = НСтр("ru = 'Выполняется рассылка SMS с паролями для рассылки отчетов.'");
	
	Обработчик = Новый ОписаниеОповещения("ВыполнитьРассылкуSMSВФонеЗавершение", ЭтотОбъект, Параметры);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(Задание, Обработчик, НастройкиОжидания);

КонецПроцедуры

// Принимает результат выполнения фонового задания.
//
// Параметры:
//   Задание - см. ДлительныеОперации.ВыполнитьВФоне
//   Параметры - Структура:
//     * КоличествоНеОтправлено - Число
//     * ПодготовленныеSMS - Массив из Структура:
//         ** НомераТелефонов - Массив из строк
//         ** ТекстSMS - Строка
//         ** Получатель - ОпределяемыйТип.ПолучательРассылки	
//     * Форма - ФормаКлиентскогоПриложения:
//         ** Элементы - ВсеЭлементыФормы
//         ** РезультатРассылкиSMS - ДанныеФормыКоллекция
//         ** РезультатРассылкиSMSБезОтборов - ДанныеФормыКоллекция
//
Процедура ВыполнитьРассылкуSMSВФонеЗавершение(Задание, Параметры) Экспорт
	
	Если Задание = Неопределено Тогда
		Возврат; // Отменено.
	КонецЕсли;
		
	Форма = Параметры.Форма;     
	
	Если НЕ Форма.Элементы.Закрыть.Видимость Тогда
		Форма.Элементы.Закрыть.Видимость = Истина;      
	КонецЕсли;
	
	Если Задание.Статус = "Выполнено" Тогда
		Результат = ПолучитьИзВременногоХранилища(Задание.АдресРезультата);
		ПоказатьОповещениеПользователя(,, Результат.Текст, БиблиотекаКартинок.РассылкаОтчетов, СтатусОповещенияПользователя.Информация);	
		Для Каждого РезультатПолучателя Из Результат.РезультатПоПолучателям Цикл
			СтрокаРезультата = Форма.РезультатРассылкиSMS.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРезультата, РезультатПолучателя);
			СтрокаРезультатБезОтборов = Форма.РезультатРассылкиSMSБезОтборов.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРезультатБезОтборов, СтрокаРезультата);
		КонецЦикла;      
		Форма.КоличествоОтправлено = Результат.КоличествоОтправлено;
		Форма.КоличествоНеОтправлено = Результат.КоличествоНеОтправлено;
		Форма.Автозаголовок = Ложь;
		Форма.Заголовок = НСтр("ru = 'Результат отправки SMS с паролями архивов'");
		Форма.Элементы.Страницы.ТекущаяСтраница = Форма.Элементы.СтраницаИнформация;
	Иначе
		Форма.Элементы.Страницы.ТекущаяСтраница = Форма.Элементы.СтраницаИнформация;
		ВызватьИсключение НСтр("ru = 'Не удалось выполнить SMS-рассылку с паролями для получения рассылки отчетов.'")
			+ Символы.ПС + Задание.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОтветОчиститьИсториюРассылкиОтчетов(Результат, Параметры) Экспорт  
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		Обработчик = Новый ОписаниеОповещения("ВыполнитьОчисткуИсторииРассылкиОтчетовВФоне", ЭтотОбъект, Параметры);
		ВыполнитьОбработкуОповещения(Обработчик, Неопределено);
	КонецЕсли;
	
КонецПроцедуры

// Запускает фоновое задание, вызывается когда все параметры уже готовы.
Процедура ВыполнитьОчисткуИсторииРассылкиОтчетовВФоне(Параметры, ДополнительныеПараметры) Экспорт

	ПараметрыМетода = Новый Структура;
	
	Задание = РассылкаОтчетовВызовСервера.ЗапуститьФоновоеЗаданиеОчисткиИсторииРассылкиОтчетов(ПараметрыМетода,
		ДополнительныеПараметры.Форма.УникальныйИдентификатор);
	
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ДополнительныеПараметры.Форма);
	НастройкиОжидания.ВыводитьОкноОжидания = Истина;
	НастройкиОжидания.ТекстСообщения = НСтр("ru = 'Выполняется очистка истории рассылки отчетов.'");
	
	Обработчик = Новый ОписаниеОповещения("ВыполнитьОчисткуИсторииРассылкиОтчетовЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(Задание, Обработчик, НастройкиОжидания);

КонецПроцедуры

Процедура ВыполнитьОчисткуИсторииРассылкиОтчетовЗавершение(Задание, Параметры) Экспорт
	
	Если Задание = Неопределено Тогда
		Возврат; // Отменено.
	КонецЕсли;
	
	Если Задание.Статус = "Выполнено" Тогда
		Результат = ПолучитьИзВременногоХранилища(Задание.АдресРезультата);
		ПоказатьОповещениеПользователя(,, Результат.Текст, , СтатусОповещенияПользователя.Информация);	
	Иначе
		ВызватьИсключение НСтр("ru = 'Не удалось выполнить очистку истории рассылки отчетов.'")
			+ Символы.ПС + Задание.КраткоеПредставлениеОшибки;
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти
