﻿
Процедура ПодпискаНаСобытиеЗаписиНоменклатуры(Источник, Отказ) Экспорт
	
	МенеджерЗаписи = РегистрыСведений.ОтправкаВRabbitMQ.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Номенклатура = Источник.Ссылка;
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

&НаСервере
Процедура ОтправитьСообщение() Экспорт
	
	//В данной настройке можно определить для каждого сообщения свой ключ маршрутизации. Сделать несколько активных записей в регистре с растройками 
	//и брать нужный под необходимые цели
	Настройки = RebbitMQСервер.ПолучитьНастройкиПодключенияИзРегистра();
	Компонента = RebbitMQСервер.ПолучитьКомпоненту();
	
	//Проверка по условию. Можно реализовать любого рода проверку
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОтправкаВRabbitMQ.Салон КАК Салон,
		|	ОтправкаВRabbitMQ.Сотрудник КАК Сотрудник,
		|	ОтправкаВRabbitMQ.Услуга КАК Услуга,
		|	ОтправкаВRabbitMQ.Клиент КАК Клиент,
		|	ОтправкаВRabbitMQ.Комментарий КАК Комментарий,
		|	ОтправкаВRabbitMQ.Дата КАК Дата,
		|	ОтправкаВRabbitMQ.ТелефонКлиента КАК ТелефонКлиента
		|ИЗ
		|	РегистрСведений.ОтправкаВRabbitMQ КАК ОтправкаВRabbitMQ
		|ГДЕ
		|	ОтправкаВRabbitMQ.ОтметкаОбОтправке = ЛОЖЬ";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	//МассивНоменклатур = Новый Массив;
	СтруктураУслуг = Новый Структура;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		
		СтруктураУслуг.Вставить("Салон",Строка(ВыборкаДетальныеЗаписи.Салон)); 
		СтруктураУслуг.Вставить("Сотрудник",Строка(ВыборкаДетальныеЗаписи.Сотрудник));
		СтруктураУслуг.Вставить("Услуга",Строка(ВыборкаДетальныеЗаписи.Услуга));
		СтруктураУслуг.Вставить("Клиент",Строка(ВыборкаДетальныеЗаписи.Клиент));
		СтруктураУслуг.Вставить("Комментарий",Строка(ВыборкаДетальныеЗаписи.Комментарий));
		СтруктураУслуг.Вставить("Дата",Строка(ВыборкаДетальныеЗаписи.Дата));  
		СтруктураУслуг.Вставить("ТелефонКлиента",ВыборкаДетальныеЗаписи.ТелефонКлиента);
		
		//МассивНоменклатур.Добавить(Строка(ВыборкаДетальныеЗаписи.Салон));
		//МассивНоменклатур.Добавить(Строка(ВыборкаДетальныеЗаписи.Сотрудник));
		//МассивНоменклатур.Добавить(Строка(ВыборкаДетальныеЗаписи.Услуга)); 
		//МассивНоменклатур.Добавить(Строка(ВыборкаДетальныеЗаписи.Клиент));
		//МассивНоменклатур.Добавить(Строка(ВыборкаДетальныеЗаписи.Комментарий));
		//МассивНоменклатур.Добавить(Строка(ВыборкаДетальныеЗаписи.Дата));
		//МассивНоменклатур.Добавить(Строка(ВыборкаДетальныеЗаписи.Время));
		
	КонецЦикла;                              
	
	//Если ТекСообщение <> Неопределено Тогда
	Если СтруктураУслуг.Количество() > 0 Тогда
		//ТекстJSON = RebbitMQКлиентСервер.СериализоватьВJSON(ТекСообщение);
		ТекстJSON = RebbitMQКлиентСервер.СериализоватьВJSON(СтруктураУслуг);
		RebbitMQКлиентСервер.ОтправитьСообщение(Компонента, Настройки, ТекстJSON);
	КонецЕсли; 
	
КонецПроцедуры

Процедура ПолучитьИзRabbitMQ() Экспорт
	
	Попытка
		
		Настройки = RebbitMQСервер.ПолучитьНастройкиПодключенияИзРегистра();
		Компонента = RebbitMQСервер.ПолучитьКомпоненту();
		
		Ответ = RebbitMQКлиентСервер.ПрочитатьСообщение(Компонента, Настройки);  
		
		Если Ответ = Неопределено Тогда
			Возврат;
		КонецЕсли; 
		
		ГотовыйОтвет = RebbitMQКлиентСервер.ДесериализоватьИзJSON(Ответ);
		
		//Для каждого СтрокаОтвета Из ГотовыйОтвет Цикл
		
		Салон = Справочники.Салоны.НайтиПоНаименованию(ГотовыйОтвет.Салон);
		Сотрудник = Справочники.Сотрудники.НайтиПоНаименованию(ГотовыйОтвет.Сотрудник); 
		Услуга = Справочники.Услуги.НайтиПоНаименованию(ГотовыйОтвет.Услуга);
		Если Справочники.Клиенты.НайтиПоНаименованию(ГотовыйОтвет.Клиент) <> Справочники.Клиенты.ПустаяСсылка() Тогда
			Клиент = Справочники.Клиенты.НайтиПоНаименованию(ГотовыйОтвет.Клиент);
		Иначе
			НовыйКлиент = Справочники.Клиенты.СоздатьЭлемент();
			НовыйКлиент.Наименование = ГотовыйОтвет.Клиент;
			НовыйКлиент.Телефон = ГотовыйОтвет.ТелефонКлиента; 
			НовыйКлиент.Записать();
			Клиент = НовыйКлиент;
		КонецЕсли;
		
		
		
		Комментарий = ГотовыйОтвет.Комментарий;
		Дата = Дата(ГотовыйОтвет.Дата);
		Длительность = Услуга.Длительность;
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЦеныСрезПоследних.Цена КАК Цена
		|ИЗ
		|	РегистрСведений.Цены.СрезПоследних(, Услуга = &Услуга) КАК ЦеныСрезПоследних";
		
		Запрос.УстановитьПараметр("Услуга", Услуга);
		
		РезультатЗапроса = Запрос.Выполнить();
		
		Если РезультатЗапроса.Пустой() Тогда
			//Нужно отработать
		КонецЕсли;
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Сумма = ВыборкаДетальныеЗаписи.Цена;
		КонецЦикла;
		
		СозданнаяЗапись = Документы.Запись.СоздатьДокумент();
		СозданнаяЗапись.Салон = Салон;
		СозданнаяЗапись.Сотрудник = Сотрудник;
		СозданнаяЗапись.Услуга = Услуга;
		СозданнаяЗапись.Клиент = Клиент;
		СозданнаяЗапись.Комментарий = Комментарий;
		СозданнаяЗапись.Дата = Дата;
		СозданнаяЗапись.Длительность = Услуга.Длительность;
		СозданнаяЗапись.Сумма = Сумма;
		СозданнаяЗапись.Цвет = Новый Цвет(184,202,255);   
		СозданнаяЗапись.ДатаОкончания = Дата  + Длительность * 60;
		//СозданнаяЗапись.Проведен = Истина;
		СозданнаяЗапись.Записать(РежимЗаписиДокумента.Проведение);
		
		ТекЗапись = РегистрыСведений.ОтправкаВRabbitMQ.СоздатьМенеджерЗаписи();
		ТекЗапись.Салон = Салон; 
		ТекЗапись.Сотрудник = Сотрудник;
		ТекЗапись.Услуга = Услуга;
		ТекЗапись.Клиент = Клиент;
		ТекЗапись.Комментарий = Комментарий;
		ТекЗапись.Дата = Дата;
		ТекЗапись.Прочитать();
		ТекЗапись.ОтметкаОбОтправке  = Истина;
		ТекЗапись.Записать();					
		
	Исключение
		//Отрабатываем исключение. Сообщение, письмо на почту и тд
		
	КонецПопытки;
	
КонецПроцедуры
