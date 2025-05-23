﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ, Замещение)
	
	Для Каждого Запись Из ЭтотОбъект Цикл
		
		АктуальныйСтатусЗаказа = Запись.Статус;
		
		Если АктуальныйСтатусЗаказа = Перечисления.СтатусыЗаказовКлиентов.Подан Тогда
			
			ИсходящееСообщение = Документы.ИсходящееСообщение.СоздатьИсходящееСообщениеПоЗаказу(Запись.Заказ);
			
			ПараметрыЗадания = Новый Массив;
			ПараметрыЗадания.Добавить(Запись.Заказ);
			ПараметрыЗадания.Добавить(ИсходящееСообщение);
			
			ФоновыеЗадания.Выполнить(
				"РаботаССообщениямиRMQ.ОтправитьИсходящееСообщениеПоЗаказу",
				ПараметрыЗадания,
				Новый УникальныйИдентификатор,
				"Отправка сообщение в RMQ"
			);
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли
