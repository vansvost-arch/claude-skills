# Tenderplan API — Endpoint Catalog

**Base URL:** `https://tenderplan.ru`  
**Version:** 3.5.0  
**Total paths:** 374

All endpoints return JSON unless noted (file downloads return binary).

`PERMISSION:` column shows the OAuth scope required. `NO` = no auth needed. `[private]` = first-party only (not available via OAuth for third-party apps).


## `auth`  (39 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/auth/change/email` | AuthChangeEmail | `[private]` |
| POST | `/auth/change/password` | AuthChangePassword | `[private]` |
| POST | `/auth/change/password/reset` | AuthChangePasswordReset | `NO` |
| GET | `/auth/client/authorize` | AuthClientAuthorize | `[private]` |
| POST | `/auth/client/authorize/decision` | AuthClientAuthorizeDecision | `[private]` |
| GET | `/auth/client/get` | AuthClientGet | `[private]` |
| POST | `/auth/client/introspect` | AuthClientIntrospect | `NO` |
| GET | `/auth/client/list` | AuthClientList | `[private]` |
| POST | `/auth/client/register` | AuthClientRegister | `[private]` |
| POST | `/auth/client/reset` | AuthClientReset | `[private]` |
| POST | `/auth/client/token` | AuthClientToken | `NO` |
| POST | `/auth/client/update` | AuthClientUpdate | `[private]` |
| GET | `/auth/confirm/email` | AuthConfirmEmail | `NO` |
| GET | `/auth/confirm/email/new` | AuthConfirmEmailNew | `NO` |
| POST | `/auth/confirm/invite` | AuthConfirmInvite | `NO` |
| POST | `/auth/confirm/password/reset` | AuthConfirmPasswordReset | `NO` |
| POST | `/auth/device/add` | AuthDeviceAdd | `[private]` |
| POST | `/auth/device/remove` | AuthDeviceRemove | `[private]` |
| POST | `/auth/ensure` | AuthEnsure | `NO` |
| POST | `/auth/external/tinkoff` | AuthExternalTinkoff | `[private]` |
| GET | `/auth/external/tinkoff/callback` | AuthExternalTinkoffCallback | `[private]` |
| POST | `/auth/external/tinkoff/revoke` | AuthExternalTinkoffRevoke | `[private]` |
| POST | `/auth/external/tinkoff/revoke/business` | AuthExternalTinkoffRevokeBusiness | `[private]` |
| POST | `/auth/login` | AuthLogin | `NO` |
| GET | `/auth/logout` | AuthLogout | `NO` |
| POST | `/auth/logout` | AuthLogout | `NO` |
| GET | `/auth/logout/all` | AuthLogoutAll | `NO` |
| POST | `/auth/logout/all` | AuthLogoutAll | `NO` |
| POST | `/auth/register/partner` | AuthRegisterPartner | `NO` |
| OPTIONS | `/auth/register/partner/gpb` | AuthRegisterPartnerGpb | `NO` |
| POST | `/auth/register/partner/gpb` | AuthRegisterPartnerGpb | `NO` |
| POST | `/auth/register/user` | AuthRegisterUser | `NO` |
| POST | `/auth/register/user/external` | AuthRegisterUserExternal | `NO` |
| POST | `/auth/register/user/internal` | AuthRegisterUserInternal | `[private]` |
| POST | `/auth/subscribe/email` | AuthSubscribeEmail | `NO` |
| GET | `/auth/subscribe/email` | AuthSubscribeEmail | `NO` |
| POST | `/auth/unsubscribe/email` | AuthUnsubscribeEmail | `NO` |
| GET | `/auth/unsubscribe/email` | AuthUnsubscribeEmail | `NO` |
| GET | `/auth/validate/password/reset` | AuthValidatePasswordReset | `NO` |

## `tenders`  (32 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/tenders/archive` | Выгрузка файлов тендера одним архивом | `[private]` |
| GET | `/api/tenders/attachments` | Получение массива аттачментов тендера | `[resources:external]` |
| GET | `/api/tenders/bankguarantees` | Получение массива банковских гарантий тендера | `[resources:external]` |
| GET | `/api/tenders/bankguarantees/attachments` | Получение массива аттачментов из банковских гарантий тендера | `[resources:external]` |
| GET | `/api/tenders/comments/attachments` | Получение массива аттачментов из комментариев тендера | `[comments:read]` |
| GET | `/api/tenders/complaints` | Получение массива жалоб тендера | `[resources:external]` |
| GET | `/api/tenders/complaints/attachments` | Получение массива аттачментов из жалоб тендера | `[resources:external]` |
| GET | `/api/tenders/contracts` | Получение массива контрактов тендера | `[resources:external]` |
| GET | `/api/tenders/contracts/attachments` | Получение массива аттачментов из контрактов тендера | `[resources:external]` |
| POST | `/api/tenders/cursor/create` | Создание курсора для получения тендеров | `[resources:external]` |
| GET | `/api/tenders/cursor/get` | Получение тендеров по курсору | `[resources:external]` |
| GET | `/api/tenders/documents` | Получение массива пользовательских аттачментов тендера | `[firm:read]` |
| POST | `/api/tenders/documents` | Привязка массива пользовательских аттачментов к тендеру | `[firm:write]` |
| GET | `/api/tenders/explanations` | Получение массива разъяснений тендера | `[resources:external]` |
| GET | `/api/tenders/explanations/attachments` | Получение массива аттачментов из разъяснений тендера | `[resources:external]` |
| GET | `/api/tenders/file` | Выгрузка файла тендера | `[relations:read]` |
| GET | `/api/tenders/get` | Получение полной модели тендера | `[]` |
| GET | `/api/tenders/getlist` | Получение списка коротких моделей тендеров по фильтру | `[relations:read]` |
| POST | `/api/tenders/getmanydata` | Получение списка моделей тендеров по ИД тендеров | `[relations:read]` |
| POST | `/api/tenders/getmanyshort` | Получение списка коротких моделей тендеров по ИД | `[relations:read]` |
| GET | `/api/tenders/info` | Получение сопутствующей тендерной информации, такой как протоколы, контракты, гарантии | `[resources:external]` |
| GET | `/api/tenders/mydocuments/attachments` | Получение пользовательских аттачментов тендера | `[firm:read]` |
| GET | `/api/tenders/protocols` | Получение массива протоколов тендера | `[resources:external]` |
| GET | `/api/tenders/protocols/attachments` | Получение массива аттачментов из протоколов тендера | `[resources:external]` |
| GET | `/api/tenders/rnp` | Получение массива записей РНП по тендеру | `[resources:external]` |
| GET | `/api/tenders/stages` | Получение массива стадий контрактов тендера | `[resources:external]` |
| GET | `/api/tenders/stages/attachments` | Получение массива аттачментов из стадий контрактов тендера | `[resources:external]` |
| GET | `/api/tenders/tasks/attachments` | Получение массива аттачментов из задач тендера | `[tasks:read]` |
| GET | `/api/tenders/v2/fullinfo` | Получение полной информации о тендере | `NO` |
| GET | `/api/tenders/v2/getlist` | Получение списка коротких моделей тендеров по фильтру | `[relations:read]` |
| GET | `/api/tenders/v2/highlight` | Подсветка слов, по которым нашлись ключи в тендере | `[resources:personal]` |
| GET | `/api/tenders/v2/info` | Получение сопутствующей тендерной информации, такой как протоколы, контракты, гарантии | `[resources:external]` |

## `search`  (9 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/search/address` | ApiSearchAddress | `[resources:external]` |
| POST | `/api/search/address/codes` | ApiSearchAddressCodes | `[resources:external]` |
| POST | `/api/search/analytics/base` | ApiSearchAnalyticsBase | `[resources:personal]` |
| POST | `/api/search/analytics/rest` | ApiSearchAnalyticsRest | `[resources:personal]` |
| POST | `/api/search/list` | ApiSearchList | `[resources:personal]` |
| POST | `/api/search/preview` | ApiSearchPreview | `NO` |
| GET | `/api/search/tender` | ApiSearchTender | `[resources:external]` |
| POST | `/api/search/v2/analytics/base` | ApiSearchV2AnalyticsBase | `[resources:personal]` |
| POST | `/api/search/v2/list` | ApiSearchV2List | `[resources:personal]` |

## `searchfilters`  (10 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/searchfilters/add` | ApiSearchfiltersAdd | `[user:write]` |
| GET | `/api/searchfilters/get` | ApiSearchfiltersGet | `[user:read]` |
| GET | `/api/searchfilters/getall` | ApiSearchfiltersGetall | `[user:read]` |
| POST | `/api/searchfilters/remove` | ApiSearchfiltersRemove | `[user:write]` |
| POST | `/api/searchfilters/update` | ApiSearchfiltersUpdate | `[user:write]` |
| POST | `/api/searchfilters/v2/add` | ApiSearchfiltersV2Add | `[user:write]` |
| GET | `/api/searchfilters/v2/get` | ApiSearchfiltersV2Get | `[user:read]` |
| GET | `/api/searchfilters/v2/getall` | ApiSearchfiltersV2Getall | `[user:read]` |
| POST | `/api/searchfilters/v2/remove` | ApiSearchfiltersV2Remove | `[user:write]` |
| POST | `/api/searchfilters/v2/update` | ApiSearchfiltersV2Update | `[user:write]` |

## `keys`  (14 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/keys/add` | ApiKeysAdd | `[keys:write]` |
| POST | `/api/keys/analytics/base` | ApiKeysAnalyticsBase | `[keys:read]` |
| POST | `/api/keys/analytics/list` | ApiKeysAnalyticsList | `[keys:read]` |
| POST | `/api/keys/analytics/rest` | ApiKeysAnalyticsRest | `[keys:read]` |
| GET | `/api/keys/bin` | ApiKeysBin | `[keys:read]` |
| GET | `/api/keys/count` | ApiKeysCount | `[keys:read]` |
| GET | `/api/keys/get` | ApiKeysGet | `[keys:read]` |
| GET | `/api/keys/getall` | ApiKeysGetall | `[keys:read]` |
| GET | `/api/keys/getkeywords` | ApiKeysGetkeywords | `[keys:read]` |
| POST | `/api/keys/remove` | ApiKeysRemove | `[keys:write]` |
| POST | `/api/keys/request` | ApiKeysRequest | `[keys:write]` |
| POST | `/api/keys/restore` | ApiKeysRestore | `[keys:write]` |
| POST | `/api/keys/update` | ApiKeysUpdate | `[keys:write]` |
| POST | `/api/keys/update/all` | ApiKeysUpdateAll | `[keys:write]` |

## `marks`  (15 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/marks/add` | ApiMarksAdd | `[marks:write]` |
| POST | `/api/marks/analytics/base` | ApiMarksAnalyticsBase | `[marks:read]` |
| POST | `/api/marks/analytics/list` | ApiMarksAnalyticsList | `[marks:read]` |
| POST | `/api/marks/analytics/rest` | ApiMarksAnalyticsRest | `[marks:read]` |
| POST | `/api/marks/analytics/v2/base` | ApiMarksAnalyticsV2Base | `[marks:read]` |
| POST | `/api/marks/analytics/v2/list` | ApiMarksAnalyticsV2List | `[marks:read]` |
| GET | `/api/marks/bin` | ApiMarksBin | `[marks:read]` |
| GET | `/api/marks/count` | ApiMarksCount | `[marks:read]` |
| GET | `/api/marks/get` | ApiMarksGet | `[marks:read]` |
| GET | `/api/marks/getall` | ApiMarksGetall | `[marks:read]` |
| GET | `/api/marks/planned/sum` | ApiMarksPlannedSum | `[marks:read]` |
| POST | `/api/marks/remove` | ApiMarksRemove | `[marks:write]` |
| POST | `/api/marks/restore` | ApiMarksRestore | `[marks:write]` |
| POST | `/api/marks/update` | ApiMarksUpdate | `[marks:write]` |
| POST | `/api/marks/update/settings` | ApiMarksUpdateSettings | `[marks:write]` |

## `relations`  (15 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/relations/analytics/base` | ApiRelationsAnalyticsBase | `[resources:external]` |
| POST | `/api/relations/analytics/list` | ApiRelationsAnalyticsList | `[resources:personal]` |
| POST | `/api/relations/analytics/rest` | ApiRelationsAnalyticsRest | `[resources:personal]` |
| POST | `/api/relations/marks/add` | ApiRelationsMarksAdd | `[relations:write]` |
| POST | `/api/relations/marks/remove` | ApiRelationsMarksRemove | `[relations:write]` |
| POST | `/api/relations/marks/set` | ApiRelationsMarksSet | `[relations:write]` |
| POST | `/api/relations/read` | ApiRelationsRead | `[relations:write]` |
| POST | `/api/relations/remove` | ApiRelationsRemove | `[relations:write]` |
| POST | `/api/relations/restore` | ApiRelationsRestore | `[relations:write]` |
| POST | `/api/relations/unread` | ApiRelationsUnread | `[relations:write]` |
| POST | `/api/relations/users/add` | ApiRelationsUsersAdd | `[relations:write]` |
| POST | `/api/relations/users/remove` | ApiRelationsUsersRemove | `[relations:write]` |
| POST | `/api/relations/users/set` | ApiRelationsUsersSet | `[relations:write]` |
| POST | `/api/relations/v2/analytics/base` | ApiRelationsV2AnalyticsBase | `[resources:external]` |
| POST | `/api/relations/v2/list` | ApiRelationsV2List | `[resources:external]` |

## `comments`  (12 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/comments/add` | Добавление комментария | `[comments:write]` |
| POST | `/api/comments/addreaction` | Добавление реакции к комментарию - максимально 8 различных реакций под одним комментарием, 1 пользователь - 1 реакция каждого вида | `[comments:write]` |
| POST | `/api/comments/deletereaction` | Удаление реакции | `[comments:write]` |
| GET | `/api/comments/get` | Получение одного комментария по ид комментария | `[comments:read]` |
| GET | `/api/comments/getall` | Получение всех комментария по ид тендера/извещения | `[comments:read]` |
| GET | `/api/comments/getmany` | Получение информации комментариев по их ИД | `[comments:read]` |
| POST | `/api/comments/pin` | Закрепление комментария | `[comments:write]` |
| POST | `/api/comments/remove` | Удаление комментария | `[comments:write]` |
| POST | `/api/comments/restore` | Восстановление удаленного комментария | `[comments:write]` |
| POST | `/api/comments/setread` | Чтение комментариев | `[comments:write]` |
| POST | `/api/comments/unpin` | Открепление комментария | `[comments:write]` |
| POST | `/api/comments/update` | Обновление комментария | `[comments:write]` |

## `attachments`  (7 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/attachments/external` | Создание аттачмента по внешней ссылке | `[documents:write]` |
| POST | `/api/attachments/external/info` | Получение мета информации о документе по ссылке | `Получение мета информации о документе по ссылке (источник, размер, имя файла)
 [documents:read]` |
| GET | `/api/attachments/get` | ApiAttachmentsGet | `[comments:read]` |
| POST | `/api/attachments/remove` | ApiAttachmentsRemove | `[comments:write]` |
| POST | `/api/attachments/restore` | ApiAttachmentsRestore | `[comments:write]` |
| POST | `/api/attachments/upload` | ApiAttachmentsUpload | `[comments:write]` |
| POST | `/api/attachments/uploadmany` | ApiAttachmentsUploadmany | `[comments:write]` |

## `images`  (2 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/images/get` | ApiImagesGet | `NO` |
| POST | `/api/images/upload` | ApiImagesUpload | `[comments:write]` |

## `tasks`  (9 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/tasks/add` | Добавление задачи/раздела | `[tasks:write]` |
| POST | `/api/tasks/complete` | Открытие или закрытие задачи | `[tasks:write]` |
| GET | `/api/tasks/getall` | Получение списка задач и разделов, их порядка и аттачментов к ним | `[tasks:read]` |
| GET | `/api/tasks/getmany` | Получение информации о задачах по их ИД | `[tasks:read]` |
| POST | `/api/tasks/remove` | Удаление задачи/раздела | `[tasks:write]` |
| POST | `/api/tasks/restore` | Восстановление задач/разделов | `[tasks:write]` |
| POST | `/api/tasks/setorder` | Обновление порядка задач/разделов | `[tasks:write]` |
| POST | `/api/tasks/setread` | Прочтение задач пользователем | `[tasks:write]` |
| POST | `/api/tasks/update` | Обновление задачи/раздела | `[tasks:write]` |

## `notifications`  (4 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/notifications/count` | Получение количества уведомлений пользователя | `[notifications:read]` |
| GET | `/api/notifications/getlist` | ApiNotificationsGetlist | `[notifications:read]` |
| POST | `/api/notifications/readall` | Прочтение всех уведомлений пользователя | `[notifications:write]` |
| GET | `/api/notifications/v2/getlist` | Получение списка коротких моделей тендеров по уведомлениям | `[notifications:read]` |

## `customers`  (11 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/customers/analytics/base` | ApiCustomersAnalyticsBase | `[resources:personal]` |
| GET | `/api/customers/analytics/cache` | ApiCustomersAnalyticsCache | `[resources:personal]` |
| POST | `/api/customers/analytics/compare` | ApiCustomersAnalyticsCompare | `[resources:personal]` |
| POST | `/api/customers/analytics/rest` | ApiCustomersAnalyticsRest | `[resources:personal]` |
| POST | `/api/customers/filters/add` | Добавление фильтра для списков аналитики заказчика | `[user:write]` |
| GET | `/api/customers/filters/get` | Получение фильтра для списков аналитики заказчика | `[user:read]` |
| POST | `/api/customers/filters/remove` | Удаление фильтра списков аналитики заказчика | `[user:write]` |
| POST | `/api/customers/filters/update` | Обновление фильтра списков аналитики заказчика | `[user:write]` |
| POST | `/api/customers/list` | ApiCustomersList | `[resources:personal]` |
| POST | `/api/customers/v2/analytics/base` | ApiCustomersV2AnalyticsBase | `[resources:personal]` |
| POST | `/api/customers/v2/list` | ApiCustomersV2List | `[resources:personal]` |

## `participants`  (8 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/participants/analytics/base` | ApiParticipantsAnalyticsBase | `[resources:personal]` |
| GET | `/api/participants/analytics/cache` | ApiParticipantsAnalyticsCache | `[resources:personal]` |
| POST | `/api/participants/analytics/compare` | ApiParticipantsAnalyticsCompare | `[resources:personal]` |
| POST | `/api/participants/analytics/rest` | ApiParticipantsAnalyticsRest | `[resources:personal]` |
| GET | `/api/participants/contacts` | Получение контактов поставщика | `Получение контактов поставщика
 [resources:personal]` |
| POST | `/api/participants/list` | ApiParticipantsList | `[resources:personal]` |
| POST | `/api/participants/v2/analytics/base` | ApiParticipantsV2AnalyticsBase | `[resources:personal]` |
| POST | `/api/participants/v2/list` | ApiParticipantsV2List | `[resources:personal]` |

## `firms`  (13 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/firms/analytics/base` | ApiFirmsAnalyticsBase | `[firm:read]` |
| POST | `/api/firms/analytics/keys` | ApiFirmsAnalyticsKeys | `[firm:read, keys:read]` |
| POST | `/api/firms/analytics/marks` | ApiFirmsAnalyticsMarks | `[firm:read, marks:read]` |
| POST | `/api/firms/analytics/rest` | ApiFirmsAnalyticsRest | `[firm:read]` |
| POST | `/api/firms/analytics/users` | ApiFirmsAnalyticsUsers | `[firm:read, users:read]` |
| POST | `/api/firms/analytics/v2/analytics` | Данные для вкладки - Тендеры и ключи | `[firm:read]` |
| POST | `/api/firms/analytics/v2/keys` | Данные для вкладки - Тендеры и ключи | `[firm:read]` |
| POST | `/api/firms/analytics/v2/list` | ApiFirmsAnalyticsV2List | `[firm:read]` |
| GET | `/api/firms/attachments` | Получение всех аттачментов фирмы | `[firm:read]` |
| POST | `/api/firms/attachments` | Привязка аттачментов к фирме | `[firm:write]` |
| GET | `/api/firms/get` | ApiFirmsGet | `[firm:read]` |
| POST | `/api/firms/list` | ApiFirmsList | `[firm:read]` |
| POST | `/api/firms/update/info` | ApiFirmsUpdateInfo | `[firm:write]` |

## `organizations`  (19 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/organizations/address` | Получение адресов по поисковому запросу | `Параметры для запроса https://dadata.ru/api/suggest/address/
 [resources:external]` |
| GET | `/api/organizations/data/acts` | ApiOrganizationsDataActs | `[resources:external]` |
| GET | `/api/organizations/data/acts/stats` | ApiOrganizationsDataActsStats | `[resources:external]` |
| POST | `/api/organizations/data/autocomplete` | ApiOrganizationsDataAutocomplete | `[resources:external]` |
| GET | `/api/organizations/data/bankguarantees` | ApiOrganizationsDataBankguarantees | `[resources:external]` |
| GET | `/api/organizations/data/egrul` | ApiOrganizationsDataEgrul | `[resources:external]` |
| GET | `/api/organizations/data/rnp` | ApiOrganizationsDataRnp | `[resources:external]` |
| POST | `/api/organizations/decline` | Склонение фразы по падежам | `[resources:external]` |
| POST | `/api/organizations/deliveryplaces` | Получение адресов по поисковому запросу | `Параметры для запроса https://dadata.ru/api/suggest/address/
 [resources:external]` |
| GET | `/api/organizations/get` | ApiOrganizationsGet | `[resources:external]` |
| GET | `/api/organizations/getcontacts` | ApiOrganizationsGetcontacts | `[resources:external]` |
| GET | `/api/organizations/getmanyshort` | ApiOrganizationsGetmanyshort | `[resources:external]` |
| GET | `/api/organizations/getname` | ApiOrganizationsGetname | `[resources:external]` |
| GET | `/api/organizations/getshort` | ApiOrganizationsGetshort | `[resources:external]` |
| POST | `/api/organizations/graphics/customer` | ApiOrganizationsGraphicsCustomer | `[resources:external]` |
| POST | `/api/organizations/graphics/participant` | ApiOrganizationsGraphicsParticipant | `[resources:external]` |
| POST | `/api/organizations/requisites` | Получение реквизитов организации по поисковому запросу | `Параметры для запроса https://dadata.ru/api/suggest/party/
 [resources:external]` |
| GET | `/api/organizations/search` | ApiOrganizationsSearch | `[resources:external]` |
| GET | `/api/organizations/suggestions` | ApiOrganizationsSuggestions | `[resources:external]` |

## `products`  (4 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/products/analytics/base` | ApiProductsAnalyticsBase | `[resources:personal]` |
| POST | `/api/products/analytics/rest` | ApiProductsAnalyticsRest | `[resources:personal]` |
| POST | `/api/products/list` | ApiProductsList | `[resources:personal]` |
| GET | `/api/products/search` | ApiProductsSearch | `[resources:external]` |

## `users`  (19 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/users/count` | ApiUsersCount | `[users:read]` |
| POST | `/api/users/delete/photo` | Удаление аватарки пользователя | `[user:write]` |
| GET | `/api/users/getall` | ApiUsersGetall | `[users:read]` |
| GET | `/api/users/getinfo` | ApiUsersGetinfo | `[user:read, users:read, firm:read, invites:read]` |
| POST | `/api/users/keysorder` | ApiUsersKeysorder | `[user:write]` |
| POST | `/api/users/marksorder` | ApiUsersMarksorder | `[user:write]` |
| POST | `/api/users/mycompanymarks` | ApiUsersMycompanymarks | `[user:write]` |
| GET | `/api/users/online` | Получение времени в миллисекундах, проведенное каждым пользователем в системе за сегодня | `[users:read]` |
| POST | `/api/users/password/reset` | ApiUsersPasswordReset | `[private]` |
| POST | `/api/users/pat/create` | ApiUsersPatCreate | `[private]` |
| GET | `/api/users/pat/list` | ApiUsersPatList | `[private]` |
| POST | `/api/users/pat/revoke` | ApiUsersPatRevoke | `[private]` |
| POST | `/api/users/remove` | ApiUsersRemove | `[users:write]` |
| POST | `/api/users/restore` | ApiUsersRestore | `[users:write]` |
| POST | `/api/users/settimezone` | ApiUsersSettimezone | `[user:write]` |
| POST | `/api/users/update/info` | ApiUsersUpdateInfo | `[private]` |
| POST | `/api/users/update/photo` | ApiUsersUpdatePhoto | `[user:write]` |
| POST | `/api/users/update/settings` | ApiUsersUpdateSettings | `[user:write]` |
| POST | `/api/users/usersorder` | ApiUsersUsersorder | `[user:write]` |

## `invites`  (5 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/invites/add` | ApiInvitesAdd | `[invites:write]` |
| GET | `/api/invites/getall` | ApiInvitesGetall | `[invites:read]` |
| GET | `/api/invites/info` | ApiInvitesInfo | `NO` |
| POST | `/api/invites/remove` | ApiInvitesRemove | `[invites:write]` |
| POST | `/api/invites/resend` | ApiInvitesResend | `[invites:write]` |

## `partners`  (11 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/partners/analytics/base` | ApiPartnersAnalyticsBase | `[partners:read]` |
| POST | `/api/partners/analytics/rest` | ApiPartnersAnalyticsRest | `[partners:read]` |
| GET | `/api/partners/code/get` | ApiPartnersCodeGet | `[partners:read]` |
| GET | `/api/partners/code/getlist` | ApiPartnersCodeGetlist | `[partners:read]` |
| POST | `/api/partners/code/set` | ApiPartnersCodeSet | `[partners:write]` |
| POST | `/api/partners/list` | ApiPartnersList | `[partners:read]` |
| POST | `/api/partners/setrole` | ApiPartnersSetrole | `[users:write]` |
| POST | `/api/partners/users/add` | ApiPartnersUsersAdd | `[partners:write]` |
| POST | `/api/partners/users/remove` | ApiPartnersUsersRemove | `[partners:write]` |
| POST | `/api/partners/users/set` | ApiPartnersUsersSet | `[partners:write]` |
| POST | `/api/partners/withdraw` | ApiPartnersWithdraw | `[partners:write]` |

## `payers`  (5 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/payers/add` | Добавление плательщика | `[firm:write]` |
| GET | `/api/payers/get` | Получение одного плательщика | `[firm:read]` |
| GET | `/api/payers/getall` | Получение всех плательщиков | `[firm:read]` |
| GET | `/api/payers/link` | Получение информации о плательщике по токену | `NO` |
| POST | `/api/payers/update` | Апдейт плательщика | `[firm:write]` |

## `myfirms`  (4 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/myfirms/add` | Добавление моей компании | `[firm:write]` |
| GET | `/api/myfirms/get` | Получение одной моей компании | `[firm:read]` |
| GET | `/api/myfirms/list` | Получение всех моих компаний | `[firm:read]` |
| POST | `/api/myfirms/remove` | Удаление моей компании | `[firm:write]` |

## `info`  (8 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/info/firm` | ApiInfoFirm | `[firm:read]` |
| GET | `/api/info/prices` | ApiInfoPrices | `NO` |
| GET | `/api/info/provider` | ApiInfoProvider | `NO` |
| GET | `/api/info/roles` | ApiInfoRoles | `NO` |
| GET | `/api/info/status` | ApiInfoStatus | `NO` |
| GET | `/api/info/user` | ApiInfoUser | `[user:read]` |
| GET | `/api/info/v2/rights` | Получение списка прав доступа | `NO` |
| GET | `/api/info/v2/roles` | Получение списка ролей | `NO` |

## `calendar`  (11 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/calendar/data` | ApiCalendarData | `[calendar:read]` |
| POST | `/api/calendar/events` | ApiCalendarEvents | `[calendar:read]` |
| GET | `/api/calendar/v2/csv` | ApiCalendarV2Csv | `[calendar:read]` |
| GET | `/api/calendar/v2/events` | ApiCalendarV2Events | `[calendar:read]` |
| GET | `/api/calendar/v2/filter/get` | ApiCalendarV2FilterGet | `[calendar:read]` |
| POST | `/api/calendar/v2/filter/remove` | ApiCalendarV2FilterRemove | `[calendar:write]` |
| POST | `/api/calendar/v2/filter/update` | ApiCalendarV2FilterUpdate | `[calendar:write]` |
| GET | `/api/calendar/v2/ics` | ApiCalendarV2Ics | `[calendar:read]` |
| GET | `/api/calendar/v2/ics/{token}` | ApiCalendarV2Ics{token} | `NO` |
| GET | `/api/calendar/weekday` | ApiCalendarWeekday | `[private]` |
| GET | `/api/calendar/weekday/next` | ApiCalendarWeekdayNext | `[private]` |

## `business-calendar`  (1 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/business-calendar/weekends` | ApiBusiness-calendarWeekends | `NO` |

## `checklists`  (8 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/checklists/add` | Добавление чеклиста | `[tasks:write]` |
| POST | `/api/checklists/apply` | Применение чек-листов к тендеру | `[tasks:write]` |
| POST | `/api/checklists/applyMany` | Применение чек-листов к тендерам | `[tasks:write]` |
| GET | `/api/checklists/get` | Получить чек-листы к тендеру | `[tasks:read]` |
| GET | `/api/checklists/getall` | Получение списка чеклистов | `[tasks:read]` |
| POST | `/api/checklists/remove` | Удаление чеклиста | `[tasks:write]` |
| POST | `/api/checklists/setorder` | Обновление порядка чеклистов | `[tasks:write]` |
| POST | `/api/checklists/update` | Обновление чеклиста | `[tasks:write]` |

## `notes`  (3 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/notes/add` | Добавление заметки | `[notes:write]` |
| GET | `/api/notes/get` | Получение заметки | `[notes:read]` |
| POST | `/api/notes/getmany` | Получение заметок по организациям | `[notes:read]` |

## `objectTable`  (13 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/objectTable/exists` | Проверка существования таблицы расчета себестоимости | `[objectTable:read]` |
| GET | `/api/objectTable/get` | Получение таблицы расчета себестоимости | `[objectTable:read]` |
| POST | `/api/objectTable/share` | Настройки доступа к таблице расчета себестоимости | `[objectTable:write]` |
| POST | `/api/objectTable/template/add` | Добавить шаблон | `[objectTable:write]` |
| POST | `/api/objectTable/template/apply` | Применить шаблон к тендеру | `[objectTable:write]` |
| GET | `/api/objectTable/template/get` | Получение шаблона расчета себестоимости | `[objectTable:read]` |
| GET | `/api/objectTable/template/getall` | Получение списка чеклистов | `[objectTable:read]` |
| POST | `/api/objectTable/template/remove` | Удалить шаблон | `[objectTable:write]` |
| POST | `/api/objectTable/template/restore` | Восстановить шаблон | `[objectTable:write]` |
| POST | `/api/objectTable/template/setdefault` | Обновить шаблон по умолчанию | `[firm:write]` |
| POST | `/api/objectTable/template/setorder` | Обновить порядок шаблонов | `[objectTable:write]` |
| POST | `/api/objectTable/template/update` | Обновить шаблон | `[objectTable:write]` |
| POST | `/api/objectTable/upsert` | Апдейт таблицы расчета себестоимости | `[objectTable:write]` |

## `orders`  (6 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/orders/create` | Создание нового заказа | `[firm:read]` |
| POST | `/api/orders/event` | Отправка события, связанного с заказом | `[firm:read]` |
| GET | `/api/orders/get` | Получение заказа по id | `[firm:read]` |
| GET | `/api/orders/link` | Получение информации о заказе по токену | `NO` |
| GET | `/api/orders/payments` | Получение оплаченных заказов | `[firm:read]` |
| GET | `/api/orders/products` | Получение товаров/тарифов | `[firm:read]` |

## `invoice`  (2 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/invoice/download` | [DEPRICATED] Событие скачивания счета | `[firm:read]` |
| GET | `/api/invoice/get` | [DEPRICATED] Получение имени счета | `[firm:read]` |

## `share`  (1 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/share/order` | Создание токена общего доступа для заказа | `[firm:read]` |

## `integrations`  (3 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/integrations/authorize` | ApiIntegrationsAuthorize | `[private]` |
| GET | `/api/integrations/list` | ApiIntegrationsList | `[private]` |
| POST | `/api/integrations/revoke` | ApiIntegrationsRevoke | `[private]` |

## `telegram`  (4 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/telegram/check` | ApiTelegramCheck | `[resources:external]` |
| POST | `/api/telegram/deactivate` | ApiTelegramDeactivate | `[resources:external]` |
| POST | `/api/telegram/integrate` | ApiTelegramIntegrate | `[resources:external]` |
| POST | `/api/telegram/update` | ApiTelegramUpdate | `[resources:external]` |

## `rnp`  (5 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/rnp/get` | ApiRnpGet | `[resources:external]` |
| GET | `/api/rnp/getlist` | ApiRnpGetlist | `[resources:external]` |
| GET | `/api/rnp/v2/get` | ApiRnpV2Get | `[resources:external]` |
| GET | `/api/rnp/v2/getlist` | ApiRnpV2Getlist | `[resources:external]` |
| GET | `/api/rnp/v2/search` | ApiRnpV2Search | `[resources:external]` |

## `bankguarantees`  (2 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/bankguarantees/get` | ApiBankguaranteesGet | `[resources:external]` |
| GET | `/api/bankguarantees/getlist` | ApiBankguaranteesGetlist | `[resources:external]` |

## `banks`  (3 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/banks/accounts/get` | ApiBanksAccountsGet | `[private]` |
| GET | `/api/banks/arrests/get` | ApiBanksArrestsGet | `[private]` |
| GET | `/api/banks/fullinfo/get` | ApiBanksFullinfoGet | `[private]` |

## `acts`  (2 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/acts/get` | ApiActsGet | `[resources:external]` |
| GET | `/api/acts/getlist` | ApiActsGetlist | `[resources:external]` |

## `lawyers`  (25 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/lawyers/attachments/get` | ApiLawyersAttachmentsGet | `[private]` |
| POST | `/api/lawyers/bids/accept` | ApiLawyersBidsAccept | `[lawyers:write]` |
| POST | `/api/lawyers/bids/add` | ApiLawyersBidsAdd | `[lawyers:write]` |
| POST | `/api/lawyers/bids/consultation` | ApiLawyersBidsConsultation | `NO` |
| POST | `/api/lawyers/bids/evaluate` | ApiLawyersBidsEvaluate | `NO` |
| POST | `/api/lawyers/bids/executor` | ApiLawyersBidsExecutor | `[private]` |
| GET | `/api/lawyers/bids/get` | ApiLawyersBidsGet | `[private]` |
| GET | `/api/lawyers/bids/get/countfree` | ApiLawyersBidsGetCountfree | `[private]` |
| GET | `/api/lawyers/bids/get/info` | ApiLawyersBidsGetInfo | `[private]` |
| GET | `/api/lawyers/bids/get/short` | ApiLawyersBidsGetShort | `[private]` |
| GET | `/api/lawyers/bids/getlist` | ApiLawyersBidsGetlist | `[private]` |
| POST | `/api/lawyers/bids/request/accept` | ApiLawyersBidsRequestAccept | `[lawyers:write]` |
| GET | `/api/lawyers/bids/tender/evaluate` | ApiLawyersBidsTenderEvaluate | `NO` |
| GET | `/api/lawyers/bids/tender/get` | ApiLawyersBidsTenderGet | `[lawyers:read]` |
| POST | `/api/lawyers/bids/update` | ApiLawyersBidsUpdate | `[private]` |
| POST | `/api/lawyers/comments/add` | ApiLawyersCommentsAdd | `[private]` |
| GET | `/api/lawyers/comments/getlist` | ApiLawyersCommentsGetlist | `[private]` |
| POST | `/api/lawyers/comments/setread` | ApiLawyersCommentsSetread | `[private]` |
| GET | `/api/lawyers/info/tender/evaluate` | ApiLawyersInfoTenderEvaluate | `NO` |
| GET | `/api/lawyers/notifications/count` | ApiLawyersNotificationsCount | `[private]` |
| GET | `/api/lawyers/notifications/getlist` | ApiLawyersNotificationsGetlist | `[private]` |
| POST | `/api/lawyers/notifications/readall` | ApiLawyersNotificationsReadall | `[private]` |
| POST | `/api/lawyers/notifications/readone` | ApiLawyersNotificationsReadone | `[private]` |
| GET | `/api/lawyers/tenders/count` | ApiLawyersTendersCount | `[relations:read]` |
| GET | `/api/lawyers/tenders/getlist` | ApiLawyersTendersGetlist | `[relations:read]` |

## `releases`  (1 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/releases/latest` | ApiReleasesLatest | `NO` |

## `feedback`  (2 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/feedback/requestcallback` | ApiFeedbackRequestcallback | `[private]` |
| POST | `/api/feedback/sendfeedback` | ApiFeedbackSendfeedback | `[private]` |

## `export`  (10 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/export/customer` | ApiExportCustomer | `[private]` |
| POST | `/api/export/participant` | ApiExportParticipant | `[private]` |
| POST | `/api/export/search` | ApiExportSearch | `[private]` |
| POST | `/api/export/selection` | ApiExportSelection | `[private]` |
| POST | `/api/export/v2/customer` | ApiExportV2Customer | `[private]` |
| POST | `/api/export/v2/firm` | ApiExportV2Firm | `[private]` |
| POST | `/api/export/v2/marks` | ApiExportV2Marks | `[private]` |
| POST | `/api/export/v2/participant` | ApiExportV2Participant | `[private]` |
| POST | `/api/export/v2/relation` | ApiExportV2Relation | `[private]` |
| POST | `/api/export/v2/search` | ApiExportV2Search | `[private]` |

## `external`  (2 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| GET | `/api/external/objectTable` | Получение таблицы расчета себестоимости для внешнего просмотра | `NO` |
| POST | `/api/external/search` | ApiExternalSearch | `NO` |

## `delivery-places`  (1 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/delivery-places/internal` | Получение адресов по поисковому запросу | `Параметры для запроса https://dadata.ru/api/suggest/address/
 NO` |

## `cursors`  (1 ops)

| Method | Path | Description | Permission |
|---|---|---|---|
| POST | `/api/cursors/ack` | Метод подтверждения получения данных по курсору | `[resources:external]` |