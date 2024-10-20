﻿Функция ОсновнойСалон() Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Салоны.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Салоны КАК Салоны
		|ГДЕ
		|	НЕ Салоны.ПометкаУдаления";
	
	РезультатЗапроса = Запрос.Выполнить();       
	
	Салон = Справочники.Салоны.ПустаяСсылка();
	Если НЕ РезультатЗапроса.Пустой() Тогда
	
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		
		Салон = Выборка.Ссылка;
	
	КонецЕсли;  
	
	Возврат Салон;

КонецФункции // ()
