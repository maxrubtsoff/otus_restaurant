﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура СоздатьНовуюСвязь(Объект, Сообщение) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ТипЗнч(Сообщение) = Тип("ДокументСсылка.ВходящееСообщение") Тогда
		Направление = Перечисления.НаправленияСообщенийRMQ.Входящее;
		Обменник = Сообщение.Обменник;
	ИначеЕсли ТипЗнч(Сообщение) = Тип("ДокументСсылка.ИсходящееСообщение") Тогда
		Направление = Перечисления.НаправленияСообщенийRMQ.Исходящее;
		Обменник = Сообщение.Обменник;
	Иначе
		ВызватьИсключение "Передан неизвестный тип сообщения RMQ";
	КонецЕсли;
	
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Период = ТекущаяДатаСеанса();
	МенеджерЗаписи.Направление = Направление;
	МенеджерЗаписи.Сообщение = Сообщение;
	МенеджерЗаписи.Объект = Объект;
	МенеджерЗаписи.Обменник = Обменник;
	МенеджерЗаписи.Записать();
	
КонецПроцедуры

Функция НайтиСообщения(Объект, Направление, Обменник, ИскатьПоследнее = Истина) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Сообщения = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СвязиОбъектовИСообщенийRMQ.Сообщение КАК Сообщение
		|ИЗ
		|	РегистрСведений.СвязиОбъектовИСообщенийRMQ КАК СвязиОбъектовИСообщенийRMQ
		|ГДЕ
		|	СвязиОбъектовИСообщенийRMQ.Объект = &Объект
		|	И СвязиОбъектовИСообщенийRMQ.Направление = &Направление
		|	И СвязиОбъектовИСообщенийRMQ.Обменник = &Обменник
		|
		|УПОРЯДОЧИТЬ ПО
		|	СвязиОбъектовИСообщенийRMQ.Период УБЫВ";
	
	Запрос.УстановитьПараметр("Направление", Направление);
	Запрос.УстановитьПараметр("Обменник", Обменник);
	Запрос.УстановитьПараметр("Объект", Объект);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Если ИскатьПоследнее Тогда
		Если Выборка.Следующий() Тогда
			Сообщения.Добавить(Выборка.Сообщение);
		КонецЕсли;
	Иначе
		Пока Выборка.Следующий() Цикл
			Сообщения.Добавить(Выборка.Сообщение);
		КонецЦикла;
	КонецЕсли;
	
	Возврат Сообщения;
	
КонецФункции

#КонецОбласти

#КонецЕсли
