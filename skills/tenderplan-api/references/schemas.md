# Tenderplan API — Core Endpoint Schemas

Verbose reference for the ~150 most-used endpoints: parameters, required fields, defaults, enums.

For the full 374-endpoint list, see `endpoints.md`. For the raw OpenAPI spec, see `swagger.json`.


### `GET /api/tenders/get`
Получение полной модели тендера  
**Permission:** `[]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/v2/fullinfo`
Получение полной информации о тендере  
**Permission:** `NO`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/v2/getlist`
Получение списка коротких моделей тендеров по фильтру  
**Permission:** `[relations:read]`
**Query params:**
- `type` (query, number, fmt=float, enum=[0, 1, 2, 3, 4, 5]) — Подмножество выборки (0 - по ключу, 1 - по метке, 2 - по пользователю, 3- по корзине, 4 - по юр. заявкам, 5 - по задачам
- `id` (query, string, fmt=objectId) — Ид сущности для выборки, можно указать null для поиска по всему подмножеству
- `responsible` (query, boolean, default=False) — Используется в связке с user. Можно передать true для игнорирования тендеров, где пользователь исполнитель задачи
- `marks` (query, array, default=[]) — Фильтр по метке
- `users` (query, array, default=[]) — Фильтр по ответственным
- `fromSubmissionCloseDateTime` (query, integer) — Фильтр по нижней границе даты окончания подачи заявок
- `toSubmissionCloseDateTime` (query, integer) — Фильтр по верхней границе даты окончания подачи заявок
- `fromPublicationDateTime` (query, integer) — Фильтр по нижней границе даты публикации тендера
- `toPublicationDateTime` (query, integer) — Фильтр по верхней границе даты публикации тендера
- `fromTaskDueCompleteAtDateTime` (query, integer) — Фильтр по нижней границе даты исполнения задачи
- `toTaskDueCompleteAtDateTime` (query, integer) — Фильтр по верхней границе даты исполнения задачи
- `placingWays` (query, array, default=[]) — Фильтр по [способам размещения](https://tenderplan.ru/api/tools/placingways/list)
- `kinds` (query, array, default=[]) — Фильтр по разновидностям тендера (0 - тендер, 1 - план график, 2 - запрос цен)
- `statuses` (query, array, default=[]) — Фильтр по [статусам тендера](https://tenderplan.ru/api/tools/statuses/list)
- `commentStatuses` (query, array, default=[]) — Фильтр по комментариям (0 - прочитанные, 1 - новые)
- `taskAssignees` (query, array, default=[]) — Фильтр по исполнителям задач
- `taskStatuses` (query, array, default=[]) — Фильтр по задачам (0 - с датой, 1 - открытые, 2 - просроченные, 3 - закрытые)
- `submissionCloseDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
- `publicationDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате публикации тендера на площадке (1 по увеличению, -1 по уменьшению)
- `maxPrice` (query, integer, enum=[-1, 1]) — Сортировка по размеру НМЦ (1 по увеличению, -1 по уменьшению)
- `isChanged` (query, integer, enum=[-1, 1]) — Сортировка по измененным тендерам (1 измененные снизу, -1 сверху)
- `isRead` (query, integer, enum=[-1, 1]) — Сортировка по прочитанности (1 прочитанные снизу, -1 сверху)
- `page` (query, integer) — Номер страницы выборки
- `q` (query, string) — Фильтр по поисковым словам. Поиск по названию, номеру и классификаторам тендера

### `GET /api/tenders/v2/info`
Получение сопутствующей тендерной информации, такой как протоколы, контракты, гарантии  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/v2/highlight`
Подсветка слов, по которым нашлись ключи в тендере  
**Permission:** `[resources:personal]`
**Query params:**
- `tenderId*` (query, string, fmt=objectId) — ИД тендера
- `keyId*` (query, string, fmt=objectId) — ИД ключа

### `GET /api/tenders/attachments`
Получение массива аттачментов тендера  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/file`
Выгрузка файла тендера  
**Permission:** `[relations:read]`
**Query params:**
- `href*` (query, string) — 

### `GET /api/tenders/documents`
Получение массива пользовательских аттачментов тендера  
**Permission:** `[firm:read]`
**Query params:**
- `id` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/complaints`
Получение массива жалоб тендера  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/contracts`
Получение массива контрактов тендера  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/protocols`
Получение массива протоколов тендера  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/explanations`
Получение массива разъяснений тендера  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/bankguarantees`
Получение массива банковских гарантий тендера  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/rnp`
Получение массива записей РНП по тендеру  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/stages`
Получение массива стадий контрактов тендера  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tenders/archive`
Выгрузка файлов тендера одним архивом  
**Permission:** `[private]`
**Query params:**
- `tenderId*` (query, string, fmt=objectId) — 

### `POST /api/tenders/cursor/create`
Создание курсора для получения тендеров  
**Permission:** `[resources:external]`
**Body (application/json):**
  - `kinds`: array<integer> — Фильтр по видам тендеров (0 - тендер, 1 - план график, 2 - запрос цен)
  - `types`: array<integer> — Фильтр по [площадкам](https://tenderplan.ru/api/tools/types/list)
  - `placingWays`: array<integer> — Фильтр по [способам размещения](https://tenderplan.ru/api/tools/placingways/list)
  - `regions`: array<integer> — Фильтр по [регионам](https://tenderplan.ru/api/tools/regions/list)
  - `publicationDateTime`: integer — Фильтр по минимальной дате публикации тендеров
  - `maxPrice`: number (float) — Фильтр по максимальной НМЦ тендеров
  - `minPrice`: number (float) — Фильтр по минимальной НМЦ тендеров
  - `guaranteeAppMax`: number (float) — Фильтр по максимальной гарантии заявки тендеров
  - `guaranteeContractMax`: number (float) — Фильтр по максимальной гарантии контракта тендеров

### `GET /api/tenders/cursor/get`
Получение тендеров по курсору  
**Permission:** `[resources:external]`
**Query params:**
- `cursor*` (query, string, fmt=objectId) — ИД курсора
- `noack` (query, boolean) — Необходимость подтверждения получения данных
- `json` (query, boolean) — Включать в выдачу модель для рендера json

### `POST /api/cursors/ack`
Метод подтверждения получения данных по курсору  
**Permission:** `[resources:external]`
**Body (application/json):**
  - `cursor*`: string (objectId) — ИД курсора

### `GET /api/search/tender`
ApiSearchTender  
**Permission:** `[resources:external]`
**Query params:**
- `number*` (query, string) — 
- `page` (query, number, fmt=float) — 

### `POST /api/search/list`
ApiSearchList  
**Permission:** `[resources:personal]`
**Query params:**
- `set` (query, string) — 
- `submissionCloseDateTime` (query, integer) — 
- `maxPrice` (query, integer) — 
- `maxPriceSum` (query, integer) — 
- `winPrice` (query, integer) — 
- `priceAvg` (query, integer) — 
- `quantityAvg` (query, integer) — 
- `totalCount` (query, integer) — 
- `admittedCount` (query, integer) — 
- `winnerCount` (query, integer) — 
- `participantsCount` (query, integer) — 
- `priceDropAvg` (query, integer) — 
- `priceDrop` (query, integer) — 
- `complaints` (query, boolean) — 
- `winner` (query, boolean) — 
- `rival` (query, boolean) — 
- `statuses` (query, array) — 
- `marks` (query, boolean) — 
- `page` (query, integer) — 
- `q` (query, string) — 
**Body (application/json):**
  - `regions`: array<integer> — 
  - `deliveryPlaces`: array<string> — 
  - `words`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `docWords`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `customers`: string — 
  - `excludedCustomers`: string — 
  - `participants`: string — 
  - `excludedParticipants`: string — 
  - `classificators`: array<object> — 
      - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
      - `value*`: array<string> — 
  - `statuses`: array<integer> — 
  - `placingWayNames`: array<integer> — 
  - `types`: array<integer> — 
  - `garDeliveryPlaces`: array<string> — 
  - `minPrice`: number (float) — 
  - `maxPrice`:  — 
  - `guaranteeAppMax`: number (float) — 
  - `guaranteeContractMax`: number (float) — 
  - `prepayment`: number (float) — 
  - `preference`: array<integer> — 
  - `excludedPreference`: array<integer> — 
  - `kind`: array<integer> — 
  - `condition`: string, enum=['or', 'and'], default='or' — 
  - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
  - `regionCondition`: string, enum=['or', 'and'], default='or' — 
  - `inDocs`: boolean, default=False — 
  - `selectedDeliveryPlaces`: array<object> — 
      - `name`: string — 
      - `fiasId`: string — 
      - `kladrId`: string — 
  - `fromReceiveDateTime`: integer — 
  - `toReceiveDateTime`: integer — 
  - `fromPublicationDateTime`: integer — 
  - `toPublicationDateTime`: integer — 
  - `fromSubmissionCloseDateTime`: integer — 
  - `toSubmissionCloseDateTime`: integer — 

### `POST /api/search/preview`
ApiSearchPreview  
**Permission:** `NO`
**Body (application/json):**
  - `regions`: array<integer> — 
  - `deliveryPlaces`: array<string> — 
  - `words`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `docWords`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `customers`: string — 
  - `excludedCustomers`: string — 
  - `participants`: string — 
  - `excludedParticipants`: string — 
  - `classificators`: array<object> — 
      - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
      - `value*`: array<string> — 
  - `statuses`: array<integer> — 
  - `placingWayNames`: array<integer> — 
  - `types`: array<integer> — 
  - `garDeliveryPlaces`: array<string> — 
  - `minPrice`: number (float) — 
  - `maxPrice`:  — 
  - `guaranteeAppMax`: number (float) — 
  - `guaranteeContractMax`: number (float) — 
  - `prepayment`: number (float) — 
  - `preference`: array<integer> — 
  - `excludedPreference`: array<integer> — 
  - `kind`: array<integer> — 
  - `condition`: string, enum=['or', 'and'], default='or' — 
  - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
  - `regionCondition`: string, enum=['or', 'and'], default='or' — 
  - `inDocs`: boolean, default=False — 
  - `selectedDeliveryPlaces`: array<object> — 
      - `name`: string — 
      - `fiasId`: string — 
      - `kladrId`: string — 

### `GET /api/search/address`
ApiSearchAddress  
**Permission:** `[resources:external]`
**Query params:**
- `query*` (query, string) — 
- `limit` (query, integer, default=15) — 

### `POST /api/search/address/codes`
ApiSearchAddressCodes  
**Permission:** `[resources:external]`
**Body (application/json):**
  - `codes`: array<string> — 

### `GET /api/keys/getall`
ApiKeysGetall  
**Permission:** `[keys:read]`

### `GET /api/keys/get`
ApiKeysGet  
**Permission:** `[keys:read]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 

### `POST /api/keys/add`
ApiKeysAdd  
**Permission:** `[keys:write]`
**Body (application/json):**
  - `regions`: array<integer> — 
  - `deliveryPlaces`: array<string> — 
  - `words`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `docWords`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `customers`: string — 
  - `excludedCustomers`: string — 
  - `participants`: string — 
  - `excludedParticipants`: string — 
  - `classificators`: array<object> — 
      - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
      - `value*`: array<string> — 
  - `statuses`: array<integer> — 
  - `placingWayNames`: array<integer> — 
  - `types`: array<integer> — 
  - `garDeliveryPlaces`: array<string> — 
  - `minPrice`: number (float) — 
  - `maxPrice`:  — 
  - `guaranteeAppMax`: number (float) — 
  - `guaranteeContractMax`: number (float) — 
  - `prepayment`: number (float) — 
  - `preference`: array<integer> — 
  - `excludedPreference`: array<integer> — 
  - `kind`: array<integer> — 
  - `condition`: string, enum=['or', 'and'], default='or' — 
  - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
  - `regionCondition`: string, enum=['or', 'and'], default='or' — 
  - `inDocs`: boolean, default=False — 
  - `selectedDeliveryPlaces`: array<object> — 
      - `name`: string — 
      - `fiasId`: string — 
      - `kladrId`: string — 
  - `name*`: string — 
  - `removeEnded`: boolean, default=False — 

### `POST /api/keys/update`
ApiKeysUpdate  
**Permission:** `[keys:write]`
**Body (application/json):**
  - `regions`: array<integer> — 
  - `deliveryPlaces`: array<string> — 
  - `words`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `docWords`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `customers`: string — 
  - `excludedCustomers`: string — 
  - `participants`: string — 
  - `excludedParticipants`: string — 
  - `classificators`: array<object> — 
      - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
      - `value*`: array<string> — 
  - `statuses`: array<integer> — 
  - `placingWayNames`: array<integer> — 
  - `types`: array<integer> — 
  - `garDeliveryPlaces`: array<string> — 
  - `minPrice`: number (float) — 
  - `maxPrice`:  — 
  - `guaranteeAppMax`: number (float) — 
  - `guaranteeContractMax`: number (float) — 
  - `prepayment`: number (float) — 
  - `preference`: array<integer> — 
  - `excludedPreference`: array<integer> — 
  - `kind`: array<integer> — 
  - `condition`: string, enum=['or', 'and'], default='or' — 
  - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
  - `regionCondition`: string, enum=['or', 'and'], default='or' — 
  - `inDocs`: boolean, default=False — 
  - `selectedDeliveryPlaces`: array<object> — 
      - `name`: string — 
      - `fiasId`: string — 
      - `kladrId`: string — 
  - `name*`: string — 
  - `removeEnded`: boolean, default=False — 
  - `_id*`: string (objectId) — 

### `POST /api/keys/remove`
ApiKeysRemove  
**Permission:** `[keys:write]`
**Body (application/json):**
  - `keys*`: array<string objectId> — 

### `POST /api/keys/restore`
ApiKeysRestore  
**Permission:** `[keys:write]`
**Body (application/json):**
  - `keys*`: array<string objectId> — 

### `GET /api/keys/count`
ApiKeysCount  
**Permission:** `[keys:read]`

### `GET /api/keys/getkeywords`
ApiKeysGetkeywords  
**Permission:** `[keys:read]`

### `GET /api/marks/getall`
ApiMarksGetall  
**Permission:** `[marks:read]`

### `GET /api/marks/get`
ApiMarksGet  
**Permission:** `[marks:read]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 

### `POST /api/marks/add`
ApiMarksAdd  
**Permission:** `[marks:write]`
**Body (application/json):**
  - `name*`: string — 
  - `color`: string — 
  - `shape`: integer — 
  - `globalSettings`: object — 
    - `plannedTenders`: boolean, default=False — 
  - `settings`: object — 
    - `newComment`: boolean, default=True — 
    - `protocolsWinners`: boolean, default=True — 
    - `tenderChange`: boolean, default=True — 
    - `tenderDeadline`: boolean, default=True — 
    - `tenderMark`: boolean, default=False — 
    - `tenderFuture`: boolean, default=True — 
    - `taskAdd`: boolean, default=True — 
    - `taskDue`: boolean, default=True — 

### `POST /api/marks/update`
ApiMarksUpdate  
**Permission:** `[marks:write]`
**Body (application/json):**
  - `name*`: string — 
  - `color`: string — 
  - `shape`: integer — 
  - `globalSettings`: object — 
    - `plannedTenders`: boolean, default=False — 
  - `settings`: object — 
    - `newComment`: boolean, default=True — 
    - `protocolsWinners`: boolean, default=True — 
    - `tenderChange`: boolean, default=True — 
    - `tenderDeadline`: boolean, default=True — 
    - `tenderMark`: boolean, default=False — 
    - `tenderFuture`: boolean, default=True — 
    - `taskAdd`: boolean, default=True — 
    - `taskDue`: boolean, default=True — 
  - `_id*`: string (objectId) — 

### `POST /api/marks/remove`
ApiMarksRemove  
**Permission:** `[marks:write]`
**Body (application/json):**
  - `marks*`: array<string objectId> — 

### `POST /api/marks/restore`
ApiMarksRestore  
**Permission:** `[marks:write]`
**Body (application/json):**
  - `marks*`: array<string objectId> — 

### `GET /api/marks/count`
ApiMarksCount  
**Permission:** `[marks:read]`

### `POST /api/relations/v2/list`
ApiRelationsV2List  
**Permission:** `[resources:external]`
**Query params:**
- `set` (query, string, enum=['winner', 'participant', 'potential', 'products'], default='winner') — Выбранная вкладка аналитики
- `tendersCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
- `maxPrice` (query, integer, enum=[-1, 1]) — Сортировка по цене (1 по увеличению, -1 по уменьшению)
- `winPrice` (query, integer, enum=[-1, 1]) — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
- `winnerCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
- `priceDropAvg` (query, integer, enum=[-1, 1]) — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
- `winLastDateTime` (query, integer, enum=[-1, 1]) — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
- `submissionCloseDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
- `submissionStartDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
- `priceDrop` (query, integer, enum=[-1, 1]) — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
- `participantsCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
- `priceAvg` (query, integer, enum=[-1, 1]) — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
- `quantityAvg` (query, integer, enum=[-1, 1]) — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
- `page` (query, integer) — Номер страницы выборки
- `q` (query, string) — Фильтр по поисковым словам
**Body (application/json):**
  - `participants*`: string — Ид поставщика
  - `customers*`: string — Ид заказчика
  - `filter`: object — 
    - `placed`: boolean — Фильтр по размещению закупки
    - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
    - `withNotes`: boolean, default=False — Фильтр по наличию заметки
    - `status`: array<integer> — Фильтр по статусу тендера
    - `marks`: array<string objectId> — Фильтр по выбранным меткам
    - `keys`: array<object> — Фильтр по выбранным ключам
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
        - `fromReceiveDateTime`: integer — 
        - `toReceiveDateTime`: integer — 
    - `users`: array<string objectId> — Фильтр по выбранным ответственным
    - `conflicts`: array<string> — Фильтр по конфликтности
    - `rivals`: array<string> — Фильтр по конкуренции
    - `priceDrop`: array<string> — Фильтр по снижению цены
    - `events`: array<string> — Фильтр по событиям
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения

### `POST /api/relations/marks/set`
ApiRelationsMarksSet  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 
  - `marks*`: array<string objectId> — 

### `POST /api/relations/marks/add`
ApiRelationsMarksAdd  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 
  - `marks*`: array<string objectId> — 

### `POST /api/relations/marks/remove`
ApiRelationsMarksRemove  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 
  - `marks*`: array<string objectId> — 

### `POST /api/relations/users/set`
ApiRelationsUsersSet  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 
  - `users*`: array<string objectId> — 

### `POST /api/relations/users/add`
ApiRelationsUsersAdd  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 
  - `users*`: array<string objectId> — 

### `POST /api/relations/users/remove`
ApiRelationsUsersRemove  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 
  - `users*`: array<string objectId> — 

### `POST /api/relations/read`
ApiRelationsRead  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 

### `POST /api/relations/unread`
ApiRelationsUnread  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 

### `POST /api/relations/remove`
ApiRelationsRemove  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 

### `POST /api/relations/restore`
ApiRelationsRestore  
**Permission:** `[relations:write]`
**Body (application/json):**
  - `tenders*`: array<string objectId> — 

### `GET /api/comments/getall`
Получение всех комментария по ид тендера/извещения  
**Permission:** `[comments:read]`
**Query params:**
- `id*` (query, string, fmt=objectId) — Ид тендера

### `GET /api/comments/get`
Получение одного комментария по ид комментария  
**Permission:** `[comments:read]`
**Query params:**
- `id*` (query, string, fmt=objectId) — Ид комментария

### `GET /api/comments/getmany`
Получение информации комментариев по их ИД  
**Permission:** `[comments:read]`
**Query params:**
- `comments*` (query, array) — Массив ИД комментариев

### `POST /api/comments/add`
Добавление комментария  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `text`:  — Текст комментария
  - `attachments`:  — Прикрепленные файлы
  - `receiver`: object — Комментарий для ответа
    - `userId`: string (objectId) — 
    - `commentId`: string (objectId) — 
  - `doc`: object — Документ юриста
    - `position`: array<any> — 
    - `highlight`: object — 
    - `name*`: string — 
    - `source*`: string — 
    - `type*`: integer — 
    - `text`: string — 
  - `reactions`: object — Объект реакций/эмодзи вида [эмодзи]: [массив ид пользователей поставивших реакцию] 
  - `mentions`: array<string objectId> — Упомянутые пользователи
  - `tenderId*`: string (objectId) — Ид тендера

### `POST /api/comments/update`
Обновление комментария  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `text`:  — Текст комментария
  - `attachments`:  — Прикрепленные файлы
  - `receiver`: object — Комментарий для ответа
    - `userId`: string (objectId) — 
    - `commentId`: string (objectId) — 
  - `doc`: object — Документ юриста
    - `position`: array<any> — 
    - `highlight`: object — 
    - `name*`: string — 
    - `source*`: string — 
    - `type*`: integer — 
    - `text`: string — 
  - `reactions`: object — Объект реакций/эмодзи вида [эмодзи]: [массив ид пользователей поставивших реакцию] 
  - `mentions`: array<string objectId> — Упомянутые пользователи
  - `_id*`: string (objectId) — Ид комментария
  - `tenderId*`: string (objectId) — Ид тендера

### `POST /api/comments/remove`
Удаление комментария  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `_id*`: string (objectId) — Ид комментария

### `POST /api/comments/restore`
Восстановление удаленного комментария  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `_id*`: string (objectId) — Ид комментария

### `POST /api/comments/pin`
Закрепление комментария  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `_id*`: string (objectId) — Ид комментария

### `POST /api/comments/unpin`
Открепление комментария  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `_id*`: string (objectId) — Ид комментария

### `POST /api/comments/setread`
Чтение комментариев  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `tenderId*`: string (objectId) — Ид тендера
  - `comments*`: array<string objectId> — Массив ид комментариев

### `POST /api/comments/addreaction`
Добавление реакции к комментарию - максимально 8 различных реакций под одним комментарием, 1 пользователь - 1 реакция каждого вида  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `_id*`: string (objectId) — Ид комментария
  - `emoji*`: string — Эмодзи

### `POST /api/comments/deletereaction`
Удаление реакции  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `_id*`: string (objectId) — Ид комментария
  - `emoji*`: string — Эмодзи

### `POST /api/attachments/upload`
ApiAttachmentsUpload  
**Permission:** `[comments:write]`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `POST /api/attachments/uploadmany`
ApiAttachmentsUploadmany  
**Permission:** `[comments:write]`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `GET /api/attachments/get`
ApiAttachmentsGet  
**Permission:** `[comments:read]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 

### `POST /api/attachments/remove`
ApiAttachmentsRemove  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `attachments`: array<string objectId> — 

### `POST /api/attachments/restore`
ApiAttachmentsRestore  
**Permission:** `[comments:write]`
**Body (application/json):**
  - `attachments`: array<string objectId> — 

### `POST /api/attachments/external`
Создание аттачмента по внешней ссылке  
**Permission:** `[documents:write]`
**Body (application/json):**
  - `href*`: string — 
  - `name*`: string — 

### `POST /api/attachments/external/info`
Получение мета информации о документе по ссылке  
**Permission:** `Получение мета информации о документе по ссылке (источник, размер, имя файла)
 [documents:read]`
**Body (application/json):**
  - `href`: string — Ссылка на файл

### `GET /api/images/get`
ApiImagesGet  
**Permission:** `NO`
**Query params:**
- `id*` (query, string) — 

### `POST /api/images/upload`
ApiImagesUpload  
**Permission:** `[comments:write]`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `GET /api/tasks/getall`
Получение списка задач и разделов, их порядка и аттачментов к ним  
**Permission:** `[tasks:read]`
**Query params:**
- `tenderId*` (query, string, fmt=objectId) — ИД тендера

### `GET /api/tasks/getmany`
Получение информации о задачах по их ИД  
**Permission:** `[tasks:read]`
**Query params:**
- `tasks*` (query, array) — Массив ИД задач

### `POST /api/tasks/add`
Добавление задачи/раздела  
**Permission:** `[tasks:write]`
**Body (application/json):**
  - `warning`: string, enum=['.alternatives() object - select 1 option only'] — 
  - `option_0`: object — Задача
    - `name`: string — Название
    - `desc`: string — Заметки
    - `assigneeId`: string (objectId) — Исполнитель
    - `dueAt`: number (float) — Срок выполнения
    - `dueReminderAt`: number (float) — Дата напоминания
    - `dueCompleteAt`: number (float) — Дата выполнения
    - `attachments`: array<string objectId> — Список аттачментов
    - `tenderId*`: string (objectId) — Тендер к которому принадлежит задача
    - `type*`: string, enum=['task'] — Тип (задача)
  - `option_1`: object — Раздел
    - `tenderId*`: string (objectId) — Тендер к которому добавляется задача
    - `name`: string — Название
    - `type*`: string, enum=['partition'] — Тип (раздел)

### `POST /api/tasks/update`
Обновление задачи/раздела  
**Permission:** `[tasks:write]`
**Body (application/json):**
  - `warning`: string, enum=['.alternatives() object - select 1 option only'] — 
  - `option_0`: object — Задача
    - `name`: string — Название
    - `desc`: string — Заметки
    - `assigneeId`: string (objectId) — Исполнитель
    - `dueAt`: number (float) — Срок выполнения
    - `dueReminderAt`: number (float) — Дата напоминания
    - `dueCompleteAt`: number (float) — Дата выполнения
    - `attachments`: array<string objectId> — Список аттачментов
    - `tenderId*`: string (objectId) — Тендер к которому принадлежит задача
    - `type*`: string, enum=['task'] — Тип (задача)
    - `_id*`: string (objectId) — 
  - `option_1`: object — Раздел
    - `tenderId*`: string (objectId) — Тендер к которому добавляется задача
    - `name`: string — Название
    - `type*`: string, enum=['partition'] — Тип (раздел)
    - `_id*`: string (objectId) — 

### `POST /api/tasks/complete`
Открытие или закрытие задачи  
**Permission:** `[tasks:write]`
**Body (application/json):**
  - `_id*`: string (objectId) — 
  - `complete*`: boolean — 

### `POST /api/tasks/remove`
Удаление задачи/раздела  
**Permission:** `[tasks:write]`
**Body (application/json):**
  - `_id*`: array<string objectId> — ИД задач/разделов
  - `tenderId*`: string (objectId) — ИД тендера

### `POST /api/tasks/restore`
Восстановление задач/разделов  
**Permission:** `[tasks:write]`
**Body (application/json):**
  - `_id*`: array<string objectId> — Ид задач/разделов
  - `tenderId*`: string (objectId) — 

### `POST /api/tasks/setread`
Прочтение задач пользователем  
**Permission:** `[tasks:write]`
**Body (application/json):**
  - `_id*`: array<string objectId> — Ид задач/разделов

### `POST /api/tasks/setorder`
Обновление порядка задач/разделов  
**Permission:** `[tasks:write]`
**Body (application/json):**
  - `_id*`: array<string objectId> — Ид задач/разделов
  - `tenderId*`: string (objectId) — 

### `GET /api/notifications/count`
Получение количества уведомлений пользователя  
**Permission:** `[notifications:read]`

### `GET /api/notifications/getlist`
ApiNotificationsGetlist  
**Permission:** `[notifications:read]`
**Query params:**
- `key` (query, string, fmt=objectId) — 
- `mark` (query, string, fmt=objectId) — 
- `placingWay` (query, integer) — 
- `fromSubmissionCloseDateTime` (query, integer) — 
- `toSubmissionCloseDateTime` (query, integer) — 
- `publicationDateTime` (query, integer) — 
- `maxPrice` (query, integer) — 
- `isChanged` (query, integer) — 
- `isRead` (query, integer) — 
- `isDeleted` (query, boolean) — 
- `isActual` (query, integer) — 
- `smp` (query, boolean) — 
- `kind` (query, integer) — 
- `marks` (query, integer) — 
- `users` (query, array) — 
- `page` (query, integer) — 
- `q` (query, string) — 

### `GET /api/notifications/v2/getlist`
Получение списка коротких моделей тендеров по уведомлениям  
**Permission:** `[notifications:read]`
**Query params:**
- `types` (query, array, default=[]) — Фильтр по типам уведомлений (1 - Напоминание о задаче, 2 - Новый комментарий, 3 - Вас назначили ответственным, 4 - Добавились новые задачи по чек-листу, 5 - Тендер отмечен меткой, 6 - Изменения, 7 - Р
- `page` (query, integer) — Номер страницы выборки
- `q` (query, string) — Фильтр по поисковым словам. Поиск по названию, номеру и классификаторам тендера

### `POST /api/notifications/readall`
Прочтение всех уведомлений пользователя  
**Permission:** `[notifications:write]`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `POST /api/customers/v2/list`
ApiCustomersV2List  
**Permission:** `[resources:personal]`
**Query params:**
- `set` (query, string, enum=['actual', 'closed', 'future', 'participants', 'products'], default='actual') — Выбранная вкладка аналитики
- `tendersCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
- `maxPrice` (query, integer, enum=[-1, 1]) — Сортировка по цене (1 по увеличению, -1 по уменьшению)
- `winPrice` (query, integer, enum=[-1, 1]) — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
- `winnerCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
- `priceDropAvg` (query, integer, enum=[-1, 1]) — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
- `winLastDateTime` (query, integer, enum=[-1, 1]) — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
- `submissionCloseDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
- `submissionStartDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
- `priceDrop` (query, integer, enum=[-1, 1]) — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
- `participantsCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
- `priceAvg` (query, integer, enum=[-1, 1]) — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
- `quantityAvg` (query, integer, enum=[-1, 1]) — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
- `page` (query, integer) — Номер страницы выборки
- `q` (query, string) — Фильтр по поисковым словам
**Body (application/json):**
  - `filter`: object — 
    - `placed`: boolean — Фильтр по размещению закупки
    - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
    - `withNotes`: boolean, default=False — Фильтр по наличию заметки
    - `status`: array<integer> — Фильтр по статусу тендера
    - `marks`: array<string objectId> — Фильтр по выбранным меткам
    - `keys`: array<object> — Фильтр по выбранным ключам
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
        - `fromReceiveDateTime`: integer — 
        - `toReceiveDateTime`: integer — 
    - `users`: array<string objectId> — Фильтр по выбранным ответственным
    - `conflicts`: array<string> — Фильтр по конфликтности
    - `rivals`: array<string> — Фильтр по конкуренции
    - `priceDrop`: array<string> — Фильтр по снижению цены
    - `events`: array<string> — Фильтр по событиям
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `key`: object — 
    - `regions`: array<integer> — 
    - `deliveryPlaces`: array<string> — 
    - `words`: object — 
      - `slop`: integer — 
      - `value`: string — 
      - `excluded`: string — 
    - `docWords`: object — 
      - `slop`: integer — 
      - `value`: string — 
      - `excluded`: string — 
    - `customers`: string — 
    - `excludedCustomers`: string — 
    - `participants`: string — 
    - `excludedParticipants`: string — 
    - `classificators`: array<object> — 
        - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
        - `value*`: array<string> — 
    - `statuses`: array<integer> — 
    - `placingWayNames`: array<integer> — 
    - `types`: array<integer> — 
    - `garDeliveryPlaces`: array<string> — 
    - `minPrice`: number (float) — 
    - `maxPrice`:  — 
    - `guaranteeAppMax`: number (float) — 
    - `guaranteeContractMax`: number (float) — 
    - `prepayment`: number (float) — 
    - `preference`: array<integer> — 
    - `excludedPreference`: array<integer> — 
    - `kind`: array<integer> — 
    - `condition`: string, enum=['or', 'and'], default='or' — 
    - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
    - `regionCondition`: string, enum=['or', 'and'], default='or' — 
    - `inDocs`: boolean, default=False — 
    - `selectedDeliveryPlaces`: array<object> — 
        - `name`: string — 
        - `fiasId`: string — 
        - `kladrId`: string — 
    - `fromReceiveDateTime`: number (float) — 
    - `toReceiveDateTime`: number (float) — 

### `POST /api/customers/list`
ApiCustomersList  
**Permission:** `[resources:personal]`
**Query params:**
- `set` (query, string) — 
- `submissionCloseDateTime` (query, integer) — 
- `maxPrice` (query, integer) — 
- `maxPriceSum` (query, integer) — 
- `winPrice` (query, integer) — 
- `priceAvg` (query, integer) — 
- `quantityAvg` (query, integer) — 
- `totalCount` (query, integer) — 
- `admittedCount` (query, integer) — 
- `winnerCount` (query, integer) — 
- `participantsCount` (query, integer) — 
- `priceDropAvg` (query, integer) — 
- `priceDrop` (query, integer) — 
- `complaints` (query, boolean) — 
- `winner` (query, boolean) — 
- `rival` (query, boolean) — 
- `statuses` (query, array) — 
- `marks` (query, boolean) — 
- `page` (query, integer) — 
- `q` (query, string) — 
**Body (application/json):**
  - `regions`: array<integer> — 
  - `deliveryPlaces`: array<string> — 
  - `words`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `docWords`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `customers`: string — 
  - `excludedCustomers`: string — 
  - `participants`: string — 
  - `excludedParticipants`: string — 
  - `classificators`: array<object> — 
      - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
      - `value*`: array<string> — 
  - `statuses`: array<integer> — 
  - `placingWayNames`: array<integer> — 
  - `types`: array<integer> — 
  - `garDeliveryPlaces`: array<string> — 
  - `minPrice`: number (float) — 
  - `maxPrice`:  — 
  - `guaranteeAppMax`: number (float) — 
  - `guaranteeContractMax`: number (float) — 
  - `prepayment`: number (float) — 
  - `preference`: array<integer> — 
  - `excludedPreference`: array<integer> — 
  - `kind`: array<integer> — 
  - `condition`: string, enum=['or', 'and'], default='or' — 
  - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
  - `regionCondition`: string, enum=['or', 'and'], default='or' — 
  - `inDocs`: boolean, default=False — 
  - `selectedDeliveryPlaces`: array<object> — 
      - `name`: string — 
      - `fiasId`: string — 
      - `kladrId`: string — 
  - `fromReceiveDateTime`: integer — 
  - `toReceiveDateTime`: integer — 

### `POST /api/participants/v2/list`
ApiParticipantsV2List  
**Permission:** `[resources:personal]`
**Query params:**
- `set` (query, string, enum=['winner', 'participant', 'potential', 'customers', 'rivals', 'products'], default='winner') — Выбранная вкладка аналитики
- `tendersCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
- `maxPrice` (query, integer, enum=[-1, 1]) — Сортировка по цене (1 по увеличению, -1 по уменьшению)
- `winPrice` (query, integer, enum=[-1, 1]) — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
- `winnerCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
- `priceDropAvg` (query, integer, enum=[-1, 1]) — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
- `winLastDateTime` (query, integer, enum=[-1, 1]) — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
- `submissionCloseDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
- `submissionStartDateTime` (query, integer, enum=[-1, 1]) — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
- `priceDrop` (query, integer, enum=[-1, 1]) — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
- `participantsCount` (query, integer, enum=[-1, 1]) — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
- `priceAvg` (query, integer, enum=[-1, 1]) — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
- `quantityAvg` (query, integer, enum=[-1, 1]) — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
- `page` (query, integer) — Номер страницы выборки
- `q` (query, string) — Фильтр по поисковым словам
**Body (application/json):**
  - `filter`: object — 
    - `placed`: boolean — Фильтр по размещению закупки
    - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
    - `withNotes`: boolean, default=False — Фильтр по наличию заметки
    - `status`: array<integer> — Фильтр по статусу тендера
    - `marks`: array<string objectId> — Фильтр по выбранным меткам
    - `keys`: array<object> — Фильтр по выбранным ключам
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
        - `fromReceiveDateTime`: integer — 
        - `toReceiveDateTime`: integer — 
    - `users`: array<string objectId> — Фильтр по выбранным ответственным
    - `conflicts`: array<string> — Фильтр по конфликтности
    - `rivals`: array<string> — Фильтр по конкуренции
    - `priceDrop`: array<string> — Фильтр по снижению цены
    - `events`: array<string> — Фильтр по событиям
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `key`: object — 
    - `regions`: array<integer> — 
    - `deliveryPlaces`: array<string> — 
    - `words`: object — 
      - `slop`: integer — 
      - `value`: string — 
      - `excluded`: string — 
    - `docWords`: object — 
      - `slop`: integer — 
      - `value`: string — 
      - `excluded`: string — 
    - `customers`: string — 
    - `excludedCustomers`: string — 
    - `participants`: string — 
    - `excludedParticipants`: string — 
    - `classificators`: array<object> — 
        - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
        - `value*`: array<string> — 
    - `statuses`: array<integer> — 
    - `placingWayNames`: array<integer> — 
    - `types`: array<integer> — 
    - `garDeliveryPlaces`: array<string> — 
    - `minPrice`: number (float) — 
    - `maxPrice`:  — 
    - `guaranteeAppMax`: number (float) — 
    - `guaranteeContractMax`: number (float) — 
    - `prepayment`: number (float) — 
    - `preference`: array<integer> — 
    - `excludedPreference`: array<integer> — 
    - `kind`: array<integer> — 
    - `condition`: string, enum=['or', 'and'], default='or' — 
    - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
    - `regionCondition`: string, enum=['or', 'and'], default='or' — 
    - `inDocs`: boolean, default=False — 
    - `selectedDeliveryPlaces`: array<object> — 
        - `name`: string — 
        - `fiasId`: string — 
        - `kladrId`: string — 
    - `fromReceiveDateTime`: number (float) — 
    - `toReceiveDateTime`: number (float) — 

### `POST /api/participants/list`
ApiParticipantsList  
**Permission:** `[resources:personal]`
**Query params:**
- `set` (query, string) — 
- `submissionCloseDateTime` (query, integer) — 
- `maxPrice` (query, integer) — 
- `maxPriceSum` (query, integer) — 
- `winPrice` (query, integer) — 
- `priceAvg` (query, integer) — 
- `quantityAvg` (query, integer) — 
- `totalCount` (query, integer) — 
- `admittedCount` (query, integer) — 
- `winnerCount` (query, integer) — 
- `participantsCount` (query, integer) — 
- `priceDropAvg` (query, integer) — 
- `priceDrop` (query, integer) — 
- `complaints` (query, boolean) — 
- `winner` (query, boolean) — 
- `rival` (query, boolean) — 
- `statuses` (query, array) — 
- `marks` (query, boolean) — 
- `page` (query, integer) — 
- `q` (query, string) — 
**Body (application/json):**
  - `regions`: array<integer> — 
  - `deliveryPlaces`: array<string> — 
  - `words`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `docWords`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `customers`: string — 
  - `excludedCustomers`: string — 
  - `participants`: string — 
  - `excludedParticipants`: string — 
  - `classificators`: array<object> — 
      - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
      - `value*`: array<string> — 
  - `statuses`: array<integer> — 
  - `placingWayNames`: array<integer> — 
  - `types`: array<integer> — 
  - `garDeliveryPlaces`: array<string> — 
  - `minPrice`: number (float) — 
  - `maxPrice`:  — 
  - `guaranteeAppMax`: number (float) — 
  - `guaranteeContractMax`: number (float) — 
  - `prepayment`: number (float) — 
  - `preference`: array<integer> — 
  - `excludedPreference`: array<integer> — 
  - `kind`: array<integer> — 
  - `condition`: string, enum=['or', 'and'], default='or' — 
  - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
  - `regionCondition`: string, enum=['or', 'and'], default='or' — 
  - `inDocs`: boolean, default=False — 
  - `selectedDeliveryPlaces`: array<object> — 
      - `name`: string — 
      - `fiasId`: string — 
      - `kladrId`: string — 
  - `fromReceiveDateTime`: integer — 
  - `toReceiveDateTime`: integer — 

### `GET /api/organizations/get`
ApiOrganizationsGet  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
- `regNum` (query, string) — 
- `inn` (query, string) — 
- `kpp` (query, string) — 

### `GET /api/organizations/getshort`
ApiOrganizationsGetshort  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 

### `GET /api/organizations/getmanyshort`
ApiOrganizationsGetmanyshort  
**Permission:** `[resources:external]`
**Query params:**
- `ids*` (query, array) — 

### `GET /api/organizations/search`
ApiOrganizationsSearch  
**Permission:** `[resources:external]`
**Query params:**
- `query` (query, string, default='""') — 
- `kpp` (query, string) — 
- `from` (query, integer) — 
- `size` (query, integer) — 
- `sort` (query, string) — 
- `main` (query, string, enum=['0', '1']) — 

### `GET /api/organizations/suggestions`
ApiOrganizationsSuggestions  
**Permission:** `[resources:external]`
**Query params:**
- `from` (query, integer) — 
- `size` (query, integer) — 
- `query` (query, string) — 

### `GET /api/organizations/getname`
ApiOrganizationsGetname  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 

### `GET /api/organizations/getcontacts`
ApiOrganizationsGetcontacts  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
- `count` (query, integer) — 
- `date` (query, integer) — 

### `POST /api/organizations/requisites`
Получение реквизитов организации по поисковому запросу  
**Permission:** `Параметры для запроса https://dadata.ru/api/suggest/party/
 [resources:external]`
**Body (application/json):**
  - `query*`: string — Поисковый запрос
  - `count`: integer, default=10 — Количество компаний в выдаче
  - `type`: string — 
  - `status`: array<string> — 
  - `okved`: array<string> — 
  - `locations`: array<object> — 
      - `kladr_id`: string — 
  - `locations_boost`: array<object> — 
      - `kladr_id`: string — 

### `POST /api/organizations/deliveryplaces`
Получение адресов по поисковому запросу  
**Permission:** `Параметры для запроса https://dadata.ru/api/suggest/address/
 [resources:external]`
**Body (application/json):**
  - `query*`: string — Поисковый запрос
  - `count`: integer, default=10 — Количество адресов в выдаче
  - `locations`: array<object> — 
      - `kladr_id`: string — 
  - `locations_boost`: array<object> — 
      - `kladr_id`: string — 
  - `from_bound`: object — 
    - `value`: string — 
  - `to_bound`: object — 
    - `value`: string — 

### `POST /api/organizations/address`
Получение адресов по поисковому запросу  
**Permission:** `Параметры для запроса https://dadata.ru/api/suggest/address/
 [resources:external]`
**Body (application/json):**
  - `query*`: string — Поисковый запрос
  - `count`: integer, default=10 — Количество адресов в выдаче
  - `locations`: array<object> — 
      - `kladr_id`: string — 
  - `locations_boost`: array<object> — 
      - `kladr_id`: string — 
  - `from_bound`: object — 
    - `value`: string — 
  - `to_bound`: object — 
    - `value`: string — 

### `POST /api/organizations/decline`
Склонение фразы по падежам  
**Permission:** `[resources:external]`
**Body (application/json):**
  - `phrase*`: string — Фраза
  - `case`: string, enum=['именительный', 'родительный', 'дательный', 'винительный', 'творительный', 'предложный', 'местный'] — Падеж

### `GET /api/organizations/data/egrul`
ApiOrganizationsDataEgrul  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
- `set` (query, string, enum=['branches', 'agencies', 'founders', 'changes', 'arbitration']) — 
- `q` (query, string) — 

### `GET /api/organizations/data/rnp`
ApiOrganizationsDataRnp  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
- `desc` (query, boolean) — 
- `page` (query, integer) — 
- `type` (query, string, enum=['actual', 'all']) — 
- `q` (query, string) — 

### `GET /api/organizations/data/bankguarantees`
ApiOrganizationsDataBankguarantees  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
- `desc` (query, boolean) — 
- `page` (query, integer) — 
- `type` (query, integer, enum=[0, 1]) — 
- `orderBy` (query, string) — 
- `status` (query, string, enum=['actual', 'closed', 'all'], default='all') — 
- `q` (query, string) — 

### `GET /api/organizations/data/acts`
ApiOrganizationsDataActs  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
- `desc` (query, boolean) — 
- `page` (query, integer) — 
- `roles` (query, array) — 
- `types` (query, array) — 
- `q` (query, string) — 

### `GET /api/organizations/data/acts/stats`
ApiOrganizationsDataActsStats  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — Ид организации

### `POST /api/organizations/data/autocomplete`
ApiOrganizationsDataAutocomplete  
**Permission:** `[resources:external]`
**Body (application/json):**
  - `query*`: string — ИНН/КПП/ОГРН, название иили адреса
  - `count`: number (float), default=20 — Количество возвращаемых организаций - максимум 20
  - `type`: string, enum=['LEGAL', 'INDIVIDUAL'] — Фильтр по типу организации
  - `status`: array<string> — Фильтр по статусу организации
  - `okved`: array<string> — Фильтр по коду ОКВЭД
  - `locations`: array<object> — Фильтр по региону организации
  - `locations_boost`: array<object> — Приоритет города при ранжировании организаций

### `POST /api/organizations/graphics/customer`
ApiOrganizationsGraphicsCustomer  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `POST /api/organizations/graphics/participant`
ApiOrganizationsGraphicsParticipant  
**Permission:** `[resources:external]`
**Query params:**
- `id*` (query, string, fmt=objectId) — 
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `GET /api/searchfilters/v2/getall`
ApiSearchfiltersV2Getall  
**Permission:** `[user:read]`

### `GET /api/searchfilters/v2/get`
ApiSearchfiltersV2Get  
**Permission:** `[user:read]`
**Query params:**
- `type` (query, number, fmt=float, enum=[0, 1, 2, 3, 4, 5]) — Подмножество выборки (0 - по ключу, 1 - по метке, 2 - по пользователю, 3- по корзине, 4 - по юр. заявкам, 5 - по задачам
- `id` (query, string, fmt=objectId) — Ид сущности для выборки, можно указать null для поиска по всему подмножеству

### `POST /api/searchfilters/v2/add`
ApiSearchfiltersV2Add  
**Permission:** `[user:write]`
**Body (application/json):**
  - `type`: number (float), enum=[0, 1, 2, 3, 4, 5] — Подмножество выборки (0 - по ключу, 1 - по метке, 2 - по пользователю, 3- по корзине, 4 - по юр. зая
  - `id`: string (objectId) — Ид сущности для выборки, можно указать null для поиска по всему подмножеству
  - `responsible`: boolean, default=False — Используется в связке с user. Можно передать true для игнорирования тендеров, где пользователь испол
  - `marks`: array<string objectId> — Фильтр по метке
  - `users`: array<string objectId> — Фильтр по ответственным
  - `fromSubmissionCloseDateTime`: integer — Фильтр по нижней границе даты окончания подачи заявок
  - `toSubmissionCloseDateTime`: integer — Фильтр по верхней границе даты окончания подачи заявок
  - `fromPublicationDateTime`: integer — Фильтр по нижней границе даты публикации тендера
  - `toPublicationDateTime`: integer — Фильтр по верхней границе даты публикации тендера
  - `fromTaskDueCompleteAtDateTime`: integer — Фильтр по нижней границе даты исполнения задачи
  - `toTaskDueCompleteAtDateTime`: integer — Фильтр по верхней границе даты исполнения задачи
  - `placingWays`: array<integer> — Фильтр по [способам размещения](https://tenderplan.ru/api/tools/placingways/list)
  - `kinds`: array<integer> — Фильтр по разновидностям тендера (0 - тендер, 1 - план график, 2 - запрос цен)
  - `statuses`: array<integer> — Фильтр по [статусам тендера](https://tenderplan.ru/api/tools/statuses/list)
  - `commentStatuses`: array<number float> — Фильтр по комментариям (0 - прочитанные, 1 - новые)
  - `taskAssignees`: array<string objectId> — Фильтр по исполнителям задач
  - `taskStatuses`: array<number float> — Фильтр по задачам (0 - с датой, 1 - открытые, 2 - просроченные, 3 - закрытые)
  - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
  - `publicationDateTime`: integer, enum=[-1, 1] — Сортировка по дате публикации тендера на площадке (1 по увеличению, -1 по уменьшению)
  - `maxPrice`: integer, enum=[-1, 1] — Сортировка по размеру НМЦ (1 по увеличению, -1 по уменьшению)
  - `isChanged`: integer, enum=[-1, 1] — Сортировка по измененным тендерам (1 измененные снизу, -1 сверху)
  - `isRead`: integer, enum=[-1, 1] — Сортировка по прочитанности (1 прочитанные снизу, -1 сверху)

### `POST /api/searchfilters/v2/update`
ApiSearchfiltersV2Update  
**Permission:** `[user:write]`
**Body (application/json):**
  - `type`: number (float), enum=[0, 1, 2, 3, 4, 5] — Подмножество выборки (0 - по ключу, 1 - по метке, 2 - по пользователю, 3- по корзине, 4 - по юр. зая
  - `id`: string (objectId) — Ид сущности для выборки, можно указать null для поиска по всему подмножеству
  - `responsible`: boolean, default=False — Используется в связке с user. Можно передать true для игнорирования тендеров, где пользователь испол
  - `marks`: array<string objectId> — Фильтр по метке
  - `users`: array<string objectId> — Фильтр по ответственным
  - `fromSubmissionCloseDateTime`: integer — Фильтр по нижней границе даты окончания подачи заявок
  - `toSubmissionCloseDateTime`: integer — Фильтр по верхней границе даты окончания подачи заявок
  - `fromPublicationDateTime`: integer — Фильтр по нижней границе даты публикации тендера
  - `toPublicationDateTime`: integer — Фильтр по верхней границе даты публикации тендера
  - `fromTaskDueCompleteAtDateTime`: integer — Фильтр по нижней границе даты исполнения задачи
  - `toTaskDueCompleteAtDateTime`: integer — Фильтр по верхней границе даты исполнения задачи
  - `placingWays`: array<integer> — Фильтр по [способам размещения](https://tenderplan.ru/api/tools/placingways/list)
  - `kinds`: array<integer> — Фильтр по разновидностям тендера (0 - тендер, 1 - план график, 2 - запрос цен)
  - `statuses`: array<integer> — Фильтр по [статусам тендера](https://tenderplan.ru/api/tools/statuses/list)
  - `commentStatuses`: array<number float> — Фильтр по комментариям (0 - прочитанные, 1 - новые)
  - `taskAssignees`: array<string objectId> — Фильтр по исполнителям задач
  - `taskStatuses`: array<number float> — Фильтр по задачам (0 - с датой, 1 - открытые, 2 - просроченные, 3 - закрытые)
  - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
  - `publicationDateTime`: integer, enum=[-1, 1] — Сортировка по дате публикации тендера на площадке (1 по увеличению, -1 по уменьшению)
  - `maxPrice`: integer, enum=[-1, 1] — Сортировка по размеру НМЦ (1 по увеличению, -1 по уменьшению)
  - `isChanged`: integer, enum=[-1, 1] — Сортировка по измененным тендерам (1 измененные снизу, -1 сверху)
  - `isRead`: integer, enum=[-1, 1] — Сортировка по прочитанности (1 прочитанные снизу, -1 сверху)

### `POST /api/searchfilters/v2/remove`
ApiSearchfiltersV2Remove  
**Permission:** `[user:write]`
**Body (application/json):**
  - `type`: number (float), enum=[0, 1, 2, 3, 4, 5] — Подмножество выборки (0 - по ключу, 1 - по метке, 2 - по пользователю, 3- по корзине, 4 - по юр. зая
  - `id`: string (objectId) — Ид сущности для выборки, можно указать null для поиска по всему подмножеству

### `POST /api/products/list`
ApiProductsList  
**Permission:** `[resources:personal]`
**Query params:**
- `set` (query, string) — 
- `submissionCloseDateTime` (query, integer) — 
- `maxPrice` (query, integer) — 
- `maxPriceSum` (query, integer) — 
- `winPrice` (query, integer) — 
- `priceAvg` (query, integer) — 
- `quantityAvg` (query, integer) — 
- `totalCount` (query, integer) — 
- `admittedCount` (query, integer) — 
- `winnerCount` (query, integer) — 
- `participantsCount` (query, integer) — 
- `priceDropAvg` (query, integer) — 
- `priceDrop` (query, integer) — 
- `complaints` (query, boolean) — 
- `winner` (query, boolean) — 
- `rival` (query, boolean) — 
- `statuses` (query, array) — 
- `marks` (query, boolean) — 
- `page` (query, integer) — 
- `q` (query, string) — 
**Body (application/json):**
  - `regions`: array<integer> — 
  - `deliveryPlaces`: array<string> — 
  - `words`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `docWords`: object — 
    - `slop`: integer — 
    - `value`: string — 
    - `excluded`: string — 
  - `customers`: string — 
  - `excludedCustomers`: string — 
  - `participants`: string — 
  - `excludedParticipants`: string — 
  - `classificators`: array<object> — 
      - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
      - `value*`: array<string> — 
  - `statuses`: array<integer> — 
  - `placingWayNames`: array<integer> — 
  - `types`: array<integer> — 
  - `garDeliveryPlaces`: array<string> — 
  - `minPrice`: number (float) — 
  - `maxPrice`:  — 
  - `guaranteeAppMax`: number (float) — 
  - `guaranteeContractMax`: number (float) — 
  - `prepayment`: number (float) — 
  - `preference`: array<integer> — 
  - `excludedPreference`: array<integer> — 
  - `kind`: array<integer> — 
  - `condition`: string, enum=['or', 'and'], default='or' — 
  - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
  - `regionCondition`: string, enum=['or', 'and'], default='or' — 
  - `inDocs`: boolean, default=False — 
  - `selectedDeliveryPlaces`: array<object> — 
      - `name`: string — 
      - `fiasId`: string — 
      - `kladrId`: string — 
  - `products*`: object — 
  - `fromReceiveDateTime`: integer — 
  - `toReceiveDateTime`: integer — 

### `GET /api/products/search`
ApiProductsSearch  
**Permission:** `[resources:external]`
**Query params:**
- `q*` (query, string) — 
- `size` (query, integer) — 

### `GET /api/info/firm`
ApiInfoFirm  
**Permission:** `[firm:read]`

### `GET /api/info/user`
ApiInfoUser  
**Permission:** `[user:read]`

### `GET /api/info/prices`
ApiInfoPrices  
**Permission:** `NO`

### `GET /api/info/roles`
ApiInfoRoles  
**Permission:** `NO`

### `GET /api/info/status`
ApiInfoStatus  
**Permission:** `NO`

### `GET /api/info/v2/rights`
Получение списка прав доступа  
**Permission:** `NO`

### `GET /api/info/v2/roles`
Получение списка ролей  
**Permission:** `NO`

### `GET /api/info/provider`
ApiInfoProvider  
**Permission:** `NO`

### `GET /api/users/getall`
ApiUsersGetall  
**Permission:** `[users:read]`

### `GET /api/users/getinfo`
ApiUsersGetinfo  
**Permission:** `[user:read, users:read, firm:read, invites:read]`

### `GET /api/users/count`
ApiUsersCount  
**Permission:** `[users:read]`

### `POST /api/users/pat/create`
ApiUsersPatCreate  
**Permission:** `[private]`
**Body (application/json):**
  - `displayName`: string — 
  - `scope`:  — 

### `GET /api/users/pat/list`
ApiUsersPatList  
**Permission:** `[private]`

### `POST /api/users/pat/revoke`
ApiUsersPatRevoke  
**Permission:** `[private]`
**Body (application/json):**
  - `id*`: string (objectId) — 

### `POST /api/users/update/info`
ApiUsersUpdateInfo  
**Permission:** `[private]`
**Body (application/json):**
  - `_id*`: string (objectId) — 
  - `displayName`: string — 
  - `email`: string (email) — 
  - `phoneNumber`: string — 
  - `role`: integer — 

### `POST /api/users/update/settings`
ApiUsersUpdateSettings  
**Permission:** `[user:write]`
**Body (application/json):**
  - `frequency`: object — 
    - `weekdayOnly`: boolean — 
    - `from`: integer — 
    - `to`: integer — 
  - `settings`: object — 
    - `importantOnly`: boolean — 
    - `desktopNotifications`: boolean — 
    - `notificationFrequency`: boolean — 
    - `tenderCount`: boolean — 
    - `markChange`: boolean — 
    - `localTime`: boolean — 
    - `showTutorial`: boolean — 
    - `showTutorialPartner`: boolean — Флаг показа туториала для партнеров
    - `showTutorialSettings`: boolean — 
    - `showTutorialCalendar`: boolean — 
    - `showTutorialKazakhstan`: boolean — 
    - `showCheckListsTutorial`: boolean — 
    - `showLawyersMark`: boolean — 
    - `tenderShowKeys`: boolean — настройка показа доп. поля "Ключи, по которым нашлось"
    - `tenderShowPlatform`: boolean — настройка показа доп. поля "Площадка"
    - `tenderShowNumber`: boolean — настройка показа доп. поля "Номер извещения"
    - `documentsOpenInNewWindow`: boolean — Настройка открытия документов в новом окне
    - `showBidRequestButton`: boolean — 
    - `tutorialLawyersPage`:  — 
    - `showPotential`: boolean — 
    - `selectedMyFirm`: string (objectId) — Ид выбранной моей компании
    - `listRestrictions`: object — Настройка ограничения отображаемых элементов списков левой панели
      - `keys`: integer, enum=[5, 10, 15, 25] — 
      - `marks`: integer, enum=[5, 10, 15, 25] — 
      - `customers`: integer, enum=[5, 10, 15, 25] — 
      - `participants`: integer, enum=[5, 10, 15, 25] — 
      - `users`: integer, enum=[5, 10, 15, 25] — 
  - `calendar`: object — 
    - `reminders`: object — 
      - `1`: object — 
        - `remindTime`: integer — 
        - `remindDesktop`: boolean — 
        - `remindEmail`: boolean — 
      - `2`: object — 
        - `remindTime`: integer — 
        - `remindDesktop`: boolean — 
        - `remindEmail`: boolean — 
      - `4`: object — 
        - `remindTime`: integer — 
        - `remindDesktop`: boolean — 
        - `remindEmail`: boolean — 
      - `8`: object — 
        - `remindTime`: integer — 
        - `remindDesktop`: boolean — 
        - `remindEmail`: boolean — 
    - `onlyPersonal`: boolean — 
    - `onlyPersonalReminders`: boolean — 
    - `monthView`: boolean — 
    - `showHolidays`: boolean — 
    - `showVertical`: boolean — 
    - `showFull`: boolean — 
    - `workingFrom`: integer — 
    - `workingTo`: integer — 
  - `services`: object — 
    - `email`: boolean — 
  - `export`: object — 
    - `selection`: array<any> — 
    - `search`: array<any> — 
    - `customer`: array<any> — 
    - `participant`: array<any> — 
  - `exportv2`: object — 
    - `selection`: array<any> — 
    - `search`: array<any> — 
    - `customer`: array<any> — 
    - `participant`: array<any> — 
    - `relation`: array<any> — 
    - `firm`: array<any> — 
    - `marks`: array<any> — 
  - `referralSettings`: object — 
    - `registerNew`: boolean — 
  - `viewSettings`: object — 
    - `tendersList`: object — Настройки отображения карточки тендера
      - `orderNameLines`: integer, enum=[2, 3] — Количество строк для названия тендера
      - `visibleDate`: string, enum=['submissionCloseDateTime', 'publicationDateTime'] — Показывать дату окончания или публикации
      - `showCustomer`: boolean — Показывать название заказчика
      - `showType`: boolean — Показывать тип размещения
      - `showNumber`: boolean — Показывать номер извещения
      - `showPlacingWay`: boolean — Показывать название площадки
      - `showDelete`: boolean — Отображать кнопку удаления тендера
      - `showRestore`: boolean — Отображать кнопку восстановления тендера

### `POST /api/users/settimezone`
ApiUsersSettimezone  
**Permission:** `[user:write]`
**Body (application/json):**
  - `timeZone*`: integer — 

### `GET /api/telegram/check`
ApiTelegramCheck  
**Permission:** `[resources:external]`

### `POST /api/telegram/integrate`
ApiTelegramIntegrate  
**Permission:** `[resources:external]`
**Body (application/json):**
  - `keys_id*`: array<string objectId> — Ид ключей для выгрузок уведомлений по приходящим тендерам

### `POST /api/telegram/deactivate`
ApiTelegramDeactivate  
**Permission:** `[resources:external]`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `POST /api/telegram/update`
ApiTelegramUpdate  
**Permission:** `[resources:external]`
**Body (application/json):**
  - `keys_id*`: array<string objectId> — Ид ключей для выгрузок уведомлений по приходящим тендерам

### `POST /api/export/v2/search`
ApiExportV2Search  
**Permission:** `[private]`
**Body (application/json):**
  - `key`: object — 
    - `regions`: array<integer> — 
    - `deliveryPlaces`: array<string> — 
    - `words`: object — 
      - `slop`: integer — 
      - `value`: string — 
      - `excluded`: string — 
    - `docWords`: object — 
      - `slop`: integer — 
      - `value`: string — 
      - `excluded`: string — 
    - `customers`: string — 
    - `excludedCustomers`: string — 
    - `participants`: string — 
    - `excludedParticipants`: string — 
    - `classificators`: array<object> — 
        - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
        - `value*`: array<string> — 
    - `statuses`: array<integer> — 
    - `placingWayNames`: array<integer> — 
    - `types`: array<integer> — 
    - `garDeliveryPlaces`: array<string> — 
    - `minPrice`: number (float) — 
    - `maxPrice`:  — 
    - `guaranteeAppMax`: number (float) — 
    - `guaranteeContractMax`: number (float) — 
    - `prepayment`: number (float) — 
    - `preference`: array<integer> — 
    - `excludedPreference`: array<integer> — 
    - `kind`: array<integer> — 
    - `condition`: string, enum=['or', 'and'], default='or' — 
    - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
    - `regionCondition`: string, enum=['or', 'and'], default='or' — 
    - `inDocs`: boolean, default=False — 
    - `selectedDeliveryPlaces`: array<object> — 
        - `name`: string — 
        - `fiasId`: string — 
        - `kladrId`: string — 
  - `filter`: object — Фильтр для аналитики
    - `keys`: array<object> — Массив ключей для фильтрации
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `list`: object — 
    - `actual`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `closed`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `future`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `customers`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `participants`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `products`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `settings`: array<any> — 

### `POST /api/export/v2/customer`
ApiExportV2Customer  
**Permission:** `[private]`
**Body (application/json):**
  - `customer*`: string (objectId) — 
  - `filter`: object — Фильтр для аналитики
    - `keys`: array<object> — Массив ключей для фильтрации
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `list`: object — 
    - `actual`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `closed`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `future`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `participants`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `products`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `settings`: array<any> — 

### `POST /api/export/v2/participant`
ApiExportV2Participant  
**Permission:** `[private]`
**Body (application/json):**
  - `participant*`: string (objectId) — 
  - `filter`: object — Фильтр для аналитики
    - `keys`: array<object> — Массив ключей для фильтрации
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `list`: object — 
    - `winner`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `participant`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `potential`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `customers`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `rivals`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `products`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `settings`: array<any> — 

### `POST /api/export/v2/firm`
ApiExportV2Firm  
**Permission:** `[private]`
**Body (application/json):**
  - `organization*`: string (objectId) — 
  - `filter`: object — Фильтр для аналитики
    - `keys`: array<object> — Массив ключей для фильтрации
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `list`: object — 
    - `winner`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `participant`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `potential`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `customers`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `rivals`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `products`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `settings`: array<any> — 

### `POST /api/export/v2/relation`
ApiExportV2Relation  
**Permission:** `[private]`
**Body (application/json):**
  - `participantId*`: string (objectId) — 
  - `customerId*`: string (objectId) — 
  - `filter`: object — Фильтр для аналитики
    - `keys`: array<object> — Массив ключей для фильтрации
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `list`: object — 
    - `winner`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `participant`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `potential`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `products`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `settings`: array<any> — 

### `POST /api/export/v2/marks`
ApiExportV2Marks  
**Permission:** `[private]`
**Body (application/json):**
  - `marks`: array<string objectId> — Метки для фильтрации
  - `filter`: object — Фильтр для аналитики
    - `keys`: array<object> — Массив ключей для фильтрации
        - `regions`: array<integer> — 
        - `deliveryPlaces`: array<string> — 
        - `words`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `docWords`: object — 
          - `slop`: integer — 
          - `value`: string — 
          - `excluded`: string — 
        - `customers`: string — 
        - `excludedCustomers`: string — 
        - `participants`: string — 
        - `excludedParticipants`: string — 
        - `classificators`: array<object> — 
            - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
            - `value*`: array<string> — 
        - `statuses`: array<integer> — 
        - `placingWayNames`: array<integer> — 
        - `types`: array<integer> — 
        - `garDeliveryPlaces`: array<string> — 
        - `minPrice`: number (float) — 
        - `maxPrice`:  — 
        - `guaranteeAppMax`: number (float) — 
        - `guaranteeContractMax`: number (float) — 
        - `prepayment`: number (float) — 
        - `preference`: array<integer> — 
        - `excludedPreference`: array<integer> — 
        - `kind`: array<integer> — 
        - `condition`: string, enum=['or', 'and'], default='or' — 
        - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
        - `regionCondition`: string, enum=['or', 'and'], default='or' — 
        - `inDocs`: boolean, default=False — 
        - `selectedDeliveryPlaces`: array<object> — 
            - `name`: string — 
            - `fiasId`: string — 
            - `kladrId`: string — 
    - `date`: object — Фильтр по дате
      - `fromReceiveDateTime`: integer — Данные ОТ даты получения
      - `toReceiveDateTime`: integer — Данные ДО даты получения
      - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
      - `toPublicationDateTime`: integer — Данные ДО даты публикации
      - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
      - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `list`: object — 
    - `actual`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `closed`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `future`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `customers`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `participants`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
    - `products`: object — 
      - `query`: object — 
        - `tendersCount`: integer, enum=[-1, 1] — Сортировка по количеству тендеров (1 по увеличению, -1 по уменьшению)
        - `maxPrice`: integer, enum=[-1, 1] — Сортировка по цене (1 по увеличению, -1 по уменьшению)
        - `winPrice`: integer, enum=[-1, 1] — Сортировка по сумме контрактов (1 по увеличению, -1 по уменьшению)
        - `winnerCount`: integer, enum=[-1, 1] — Сортировка по количеству побед (1 по увеличению, -1 по уменьшению)
        - `priceDropAvg`: integer, enum=[-1, 1] — Сортировка по среднему снижению цены (1 по увеличению, -1 по уменьшению)
        - `winLastDateTime`: integer, enum=[-1, 1] — Сортировка по последней победе (1 по увеличению, -1 по уменьшению)
        - `submissionCloseDateTime`: integer, enum=[-1, 1] — Сортировка по дате окончания подачи заявки (1 по увеличению, -1 по уменьшению)
        - `submissionStartDateTime`: integer, enum=[-1, 1] — Сортировка по дате размещения закупки (1 по увеличению, -1 по уменьшению)
        - `priceDrop`: integer, enum=[-1, 1] — Сортировка по падению цены (1 по увеличению, -1 по уменьшению)
        - `participantsCount`: integer, enum=[-1, 1] — Сортировка по количеству участников (1 по увеличению, -1 по уменьшению)
        - `priceAvg`: integer, enum=[-1, 1] — Сортировка по средней стоимости товаров (1 по увеличению, -1 по уменьшению)
        - `quantityAvg`: integer, enum=[-1, 1] — Сортировка по среднему объему товаров (1 по увеличению, -1 по уменьшению)
        - `page`: integer — Номер страницы выборки
        - `q`: string — Фильтр по поисковым словам
      - `filter`: object — 
        - `placed`: boolean — Фильтр по размещению закупки
        - `currentYear`: boolean, default=False — Фильтр по текущему году даты размещения закупки
        - `withNotes`: boolean, default=False — Фильтр по наличию заметки
        - `status`: array<integer> — Фильтр по статусу тендера
        - `marks`: array<string objectId> — Фильтр по выбранным меткам
        - `keys`: array<object> — Фильтр по выбранным ключам
            - `regions`: array<integer> — 
            - `deliveryPlaces`: array<string> — 
            - `words`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `docWords`: object — 
              - `slop`: integer — 
              - `value`: string — 
              - `excluded`: string — 
            - `customers`: string — 
            - `excludedCustomers`: string — 
            - `participants`: string — 
            - `excludedParticipants`: string — 
            - `classificators`: array<object> — 
                - `name`: string, enum=['okpd2', 'okpd', 'okdp'] — 
                - `value*`: array<string> — 
            - `statuses`: array<integer> — 
            - `placingWayNames`: array<integer> — 
            - `types`: array<integer> — 
            - `garDeliveryPlaces`: array<string> — 
            - `minPrice`: number (float) — 
            - `maxPrice`:  — 
            - `guaranteeAppMax`: number (float) — 
            - `guaranteeContractMax`: number (float) — 
            - `prepayment`: number (float) — 
            - `preference`: array<integer> — 
            - `excludedPreference`: array<integer> — 
            - `kind`: array<integer> — 
            - `condition`: string, enum=['or', 'and'], default='or' — 
            - `classificatorCondition`: string, enum=['or', 'and'], default='or' — 
            - `regionCondition`: string, enum=['or', 'and'], default='or' — 
            - `inDocs`: boolean, default=False — 
            - `selectedDeliveryPlaces`: array<object> — 
                - `name`: string — 
                - `fiasId`: string — 
                - `kladrId`: string — 
            - `fromReceiveDateTime`: integer — 
            - `toReceiveDateTime`: integer — 
        - `users`: array<string objectId> — Фильтр по выбранным ответственным
        - `conflicts`: array<string> — Фильтр по конфликтности
        - `rivals`: array<string> — Фильтр по конкуренции
        - `priceDrop`: array<string> — Фильтр по снижению цены
        - `events`: array<string> — Фильтр по событиям
        - `date`: object — Фильтр по дате
          - `fromReceiveDateTime`: integer — Данные ОТ даты получения
          - `toReceiveDateTime`: integer — Данные ДО даты получения
          - `fromPublicationDateTime`: integer — Данные ОТ даты публикации
          - `toPublicationDateTime`: integer — Данные ДО даты публикации
          - `fromSubmissionCloseDateTime`: integer — Данные ОТ даты завершения
          - `toSubmissionCloseDateTime`: integer — Данные ДО даты завершения
  - `settings`: array<any> — 

### `GET /api/integrations/list`
ApiIntegrationsList  
**Permission:** `[private]`

### `POST /api/integrations/authorize`
ApiIntegrationsAuthorize  
**Permission:** `[private]`
**Body (application/json):**
  - `clientId*`: string (objectId) — 

### `POST /api/integrations/revoke`
ApiIntegrationsRevoke  
**Permission:** `[private]`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `POST /auth/client/register`
AuthClientRegister  
**Permission:** `[private]`
**Body (application/json):**
  - `displayName*`: string — 
  - `clientType*`: string, enum=['confidential', 'public'] — 
  - `clientDomain*`: string, enum=['user', 'firm'] — 
  - `redirectURIs`: array<string> — 
  - `scope`:  — 

### `POST /auth/client/token`
AuthClientToken  
**Permission:** `NO`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `GET /auth/client/authorize`
AuthClientAuthorize  
**Permission:** `[private]`
**Query params:**
- `response_type*` (query, string) — 
- `client_id*` (query, string) — 
- `redirect_uri` (query, string) — 
- `scope` (query, ?) — 
- `state` (query, string) — 

### `POST /auth/client/introspect`
AuthClientIntrospect  
**Permission:** `NO`
**Body (application/json):**
  - `token*`: string — 

### `POST /auth/client/reset`
AuthClientReset  
**Permission:** `[private]`
**Body (application/json):**
  - `_id*`: string (objectId) — 

### `POST /auth/login`
AuthLogin  
**Permission:** `NO`
**Body (application/json):**
  - `username*`: string (email) — 
  - `password*`: string — 

### `POST /auth/logout`
AuthLogout  
**Permission:** `NO`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})

### `POST /auth/ensure`
AuthEnsure  
**Permission:** `NO`
**Body (application/json):**
(schema: {"type": "object", "properties": {}})