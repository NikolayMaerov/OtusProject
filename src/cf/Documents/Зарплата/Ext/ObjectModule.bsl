﻿
Процедура ОбработкаПроведения(Отказ, Режим)

	// регистр Зарплата Расход
	Движения.Зарплата.Записывать = Истина;
	Для Каждого ТекСтрокаСотрудники Из Сотрудники Цикл
		Движение = Движения.Зарплата.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Салон = Салон;
		Движение.Сотрудник = ТекСтрокаСотрудники.Сотрудник;
		Движение.Месяц = Месяц;
		Движение.Сумма = ТекСтрокаСотрудники.Сумма;
	КонецЦикла;
	
	Движения.ДвижениеДенежныхСредств.Записывать = Истина;
	Движение = Движения.ДвижениеДенежныхСредств.Добавить();
	Движение.Период = Дата;
	Движение.Салон = Салон;
	Движение.ТипДенежныхСредств = СпособВыплаты;
	Движение.Статья = Статья;
	Движение.СуммаРасход = Сотрудники.Итог("Сумма");

КонецПроцедуры
