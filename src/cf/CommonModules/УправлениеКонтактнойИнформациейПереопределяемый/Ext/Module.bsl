﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Изменяет, добавляет, удаляет стандартные команды контактной информации, отображаемые в справочниках и документах,
// Вкл./Выкл. отображение иконок контактной информации слева от заголовка вида контактной информации
//
// Параметры:
//  Настройки - Структура:
//    * ОтображатьИконки - Булево
//    * ОписаниеКоманд - см. УправлениеКонтактнойИнформацией.ОписаниеКоманд
//    
//  Пример:
//	   Настройки.ОтображатьИконки = Истина;
//	   Адрес = Перечисления.ТипыКонтактнойИнформации.Адрес;
//	   Настройки.ОписаниеКоманд[Адрес].ЗапланироватьВстречу.Заголовок  = НСтр("ru='Встреча'");
//     Настройки.ОписаниеКоманд[Адрес].ЗапланироватьВстречу.Подсказка  = НСтр("ru='Создать событие встречи'");
//     Настройки.ОписаниеКоманд[Адрес].ЗапланироватьВстречу.Картинка   = БиблиотекаКартинок.ЗапланированноеВзаимодействие;
//     Настройки.ОписаниеКоманд[Адрес].ЗапланироватьВстречу.Действие   = "_ДемоСтандартныеПодсистемыКлиент.ОткрытьФормуДокументаВстреча";
//    
//     _ДемоФактическийАдресОрганизации = УправлениеКонтактнойИнформацией.ВидКонтактнойИнформацииПоИмени("_ДемоФактическийАдресОрганизации");
//      Настройки.ОписаниеКоманд[_ДемоФактическийАдресОрганизации] = 
//    	УправлениеКонтактнойИнформацией.КомандыТипаКонтактнойИнформации(Перечисления.ТипыКонтактнойИнформации.Адрес);
//      Настройки.ОписаниеКоманд[_ДемоФактическийАдресОрганизации].ЗапланироватьВстречу.Действие = ""; // Отключение действия команды для вида
//
//   Процедурам, указанных в свойстве Действие, передаются 2 параметра:
//       КонтактнаяИнформация - Структура:
//         * Представление - Строка
//         * Значение      - Строка
//         * Тип           - ПеречислениеСсылка.ТипКонтактнойИнформации
//         * Вид           - СправочникСсылка.ВидыКонтактнойИнформации
//       ДополнительныеПараметры - Структура:        
//         * ВладелецКонтактнойИнформации - ОпределяемыйТип.ВладелецКонтактнойИнформации.
//         * Форма - ФормаКлиентскогоПриложения - форма объекта-владельца, предназначенная для вывода контактной информации.
//
//   Пример: 
//     Процедура ОткрытьФормуДокументаВстреча(КонтактнаяИнформация, ДополнительныеПараметры) Экспорт
//		  ЗначенияЗаполнения = Новый Структура;
//		  ЗначенияЗаполнения.Вставить("МестоПроведенияВстречи", КонтактнаяИнформация.Представление);
//		  Если ТипЗнч(ДополнительныеПараметры.ВладелецКонтактнойИнформации) = Тип("ДокументСсылка._ДемоЗаказПокупателя") Тогда
//		    	ЗначенияЗаполнения.Вставить("Предмет", ДополнительныеПараметры.ВладелецКонтактнойИнформации);
//		    	ЗначенияЗаполнения.Вставить("Контакт", "");
//		  Иначе
//		    	ЗначенияЗаполнения.Вставить("Контакт", ДополнительныеПараметры.ВладелецКонтактнойИнформации);
//		    	ЗначенияЗаполнения.Вставить("Предмет", "");
//		  КонецЕсли;
//
//		  ОткрытьФорму("Документ.Встреча.ФормаОбъекта", Новый Структура("ЗначенияЗаполнения", ЗначенияЗаполнения),
//			ДополнительныеПараметры.Форма);
//	   КонецПроцедуры
//
Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
	
    
КонецПроцедуры

// Получает наименования видов контактной информации на разных языках.
//
// Параметры:
//  Наименования - Соответствие из КлючИЗначение - представление вида контактной информации на переданном языке:
//     * Ключ     - Строка - имя вида контактной информации. Например, "_ДемоАдресПартнера".
//     * Значение - Строка - наименование вида контактной информации для переданного кода языка.
//  КодЯзыка - Строка - код языка. Например, "en".
//
// Пример:
//  Наименования["_ДемоАдресПартнера"] = НСтр("ru='Адрес'; en='Address';", КодЯзыка);
//
Процедура ПриПолученииНаименованийВидовКонтактнойИнформации(Наименования, КодЯзыка) Экспорт
	
	
	
КонецПроцедуры

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов
// 
// Параметры:
//  Настройки - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов.Настройки
//
Процедура ПриНастройкеНачальногоЗаполненияЭлементов(Настройки) Экспорт
	
КонецПроцедуры

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов
//
// Параметры:
//  КодыЯзыков - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.КодыЯзыков
//  Элементы   - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.Элементы
//  ТабличныеЧасти - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.ТабличныеЧасти
//
Процедура ПриНачальномЗаполненииЭлементов(КодыЯзыков, Элементы, ТабличныеЧасти) Экспорт
	
	
	
КонецПроцедуры

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов
//
// Параметры:
//  Объект                  - СправочникОбъект.РолиИсполнителей - заполняемый объект.
//  Данные                  - СтрокаТаблицыЗначений - данные заполнения объекта.
//  ДополнительныеПараметры - Структура:
//   * ПредопределенныеДанные - ТаблицаЗначений - данные заполненные в процедуре ПриНачальномЗаполненииЭлементов.
//
Процедура ПриНачальномЗаполненииЭлемента(Объект, Данные, ДополнительныеПараметры) Экспорт
	
КонецПроцедуры

#КонецОбласти
