﻿///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2023, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Для Каждого ФайлСсылка Из Параметры.МассивФайлов Цикл
		НовыйЭлемент = ВыбранныеФайлы.Добавить();
		НовыйЭлемент.Ссылка = ФайлСсылка;
		НовыйЭлемент.ИндексКартинки = ФайлСсылка.ИндексКартинки;
	КонецЦикла;
	
	ЕстьВерсииФайлов = Параметры.ЕстьВерсииФайлов;
	Редактирует = Параметры.Редактирует;
	
	Элементы.ХранитьВерсии.Видимость = ЕстьВерсииФайлов;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ХранитьВерсии = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыВыбранныеФайлы

&НаКлиенте
Процедура ВыбранныеФайлыПередНачаломДобавления(Элемент, Отказ, Копирование)
	Отказ = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗакончитьРедактирование()
	
	МассивФайлов = Новый Массив;
	Для Каждого ЭлементСписка Из ВыбранныеФайлы Цикл
		МассивФайлов.Добавить(ЭлементСписка.Ссылка);
	КонецЦикла;
	
	ПараметрыОбновленияФайлов = Новый Структура;
	ПараметрыОбновленияФайлов.Вставить("МассивФайлов",                     МассивФайлов);
	ПараметрыОбновленияФайлов.Вставить("ВозможностьСоздаватьВерсииФайлов", ЕстьВерсииФайлов);
	ПараметрыОбновленияФайлов.Вставить("ХранитьВерсии", ХранитьВерсии);
	Если Не ЕстьВерсииФайлов Тогда
		ПараметрыОбновленияФайлов.Вставить("СоздатьНовуюВерсию", Ложь);
	КонецЕсли;
	ПараметрыОбновленияФайлов.Вставить("ФайлРедактируетТекущийПользователь", Истина);
	ПараметрыОбновленияФайлов.Вставить("ОбработчикРезультата",               Неопределено);
	ПараметрыОбновленияФайлов.Вставить("ИдентификаторФормы",                 УникальныйИдентификатор);
	ПараметрыОбновленияФайлов.Вставить("Редактирует",                        Редактирует);
	ПараметрыОбновленияФайлов.Вставить("КомментарийКВерсии",                 Комментарий);
	ПараметрыОбновленияФайлов.Вставить("ПоказыватьОповещение",               Ложь);
	РаботаСФайламиСлужебныйКлиент.ЗакончитьРедактированиеПоСсылкамСОповещением(ПараметрыОбновленияФайлов);
	Закрыть();
КонецПроцедуры

#КонецОбласти