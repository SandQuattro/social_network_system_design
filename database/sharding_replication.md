# Шардирование и репликация компонентов социальной сети для путешественников

### Таблицы Пользователи, профили и посты
Шардируем по user_id. Это позволит держать данные пользователя и его профиля на одном шарде.
Посты также будут храниться на одном шарде, что обеспечит быстрый доступ к ним

### Комментарии, лайки, media, просмотры
Шардируем по post_id, Комментарии, лайки, media, просмотры будут храниться на одном шарде, 
что обеспечит быстрый доступ к ним, упростит одновременное извлечение этих данных

### Сообщения
Шардируем по sender_id, все сообщения от одного пользователя будут храниться на одном шарде, 
что позволит быстро их извлекать

### Друзья
Шардируем по user_id и friend_id для равномерного распределения данных

# Репликация
Мы будем использовать Multi-Master репликацию для обеспечения высокой доступности и отказоустойчивости,
что особенно актуально для таблиц постов и комментариев. Мастер реплики, для обеспечения высокой доступности и отказоустойчивости,
необходимо располагать в разных ЦОД