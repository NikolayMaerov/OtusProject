@startuml
!define C4Context
!include https://raw.githubusercontent.com/plantuml-stdlib/C4-PlantUML/master/C4_Container.puml

LAYOUT_TOP_DOWN()

title Схема C4: Запись на услуги по стрижке

Person(user, "Пользователь", "Записывается на услуги по стрижке")

System_Boundary(web_mobile_app, "Веб и Мобильные приложения") {
    Container(webApp, "Веб-сайт", "React", "Позволяет пользователю записаться на услугу через интернет")
    Container(mobileApp, "Мобильное приложение", "iOS/Android", "Позволяет пользователю записаться на услугу через мобильное устройство")
}

Container_Boundary(backend, "Бэкэнд") {
    Container(rabbitMQ, "RabbitMQ", "Message Broker", "Передаёт данные о заказах в 1С")
    Container(OneC, "1С", "1С:Барбершоп", "Обрабатывает заказы и оформляет оказание услуг")

    ContainerDb(postgreSQL, "PostgreSQL", "База данных", "Хранит данные 1С")
}

Rel(user, webApp, "Записывается на услугу через веб-сайт")
Rel(user, mobileApp, "Записывается на услугу через мобильное приложение")
Rel(webApp, rabbitMQ, "Отправляет данные о заказе")
Rel(mobileApp, rabbitMQ, "Отправляет данные о заказе")
Rel(rabbitMQ, OneC, "Передаёт данные о заказах")
Rel(OneC, postgreSQL, "Сохраняет данные")

@enduml
