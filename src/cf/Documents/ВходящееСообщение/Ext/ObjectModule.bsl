﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("Объект") Тогда
		РегистрыСведений.СвязиОбъектовИСообщенийRMQ.СоздатьНовуюСвязь(ДополнительныеСвойства.Объект, Ссылка);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли