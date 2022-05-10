# ZerionHACK
Solution for Zerion P2P ledger 

## Разместить ордер
    1) Перевести средства на смарт контракт
    2) Написать владельцу (Zerion) [курс, адрес] для установки курса
    3) Владелец вызовет функцию setCourse(курс, адрес)

## Купить ордер
    1) Предоставить владельцу действительный перевод средств
    2) Написать откуда, куда, сколько переведено в фиатной валюте (sum)
    3) владелец вызовет функцию withdraw, переводящую (sum*курс) на адрес куда

## Вывести свои средства
    1) вызвать returnWallet с желаемым количеством средств для вывода

## Info
    Смарт контракт размещён в BSC Testnet
    Адрес контракта 0xF97b620814e18b0ee8Ddf857E7C73EfEc4652bAc
    abi контракта можно посмотреть в файле ZerionP2P_ledgerABI.json

## CLI_Interface
    Папка с изображениями интерфейса работы командной строки

*Чтобы запустить Backend.js необходимо обладать приватным ключом от кошелька владельца*

## Пример вызовов с использованием CLI

### Return wallet
[image](https://github.com/glebzverev/ZerionHACK/blob/main/CLI_interface/returnWallet.png)

### SetCourse
[image](https://github.com/glebzverev/ZerionHACK/blob/main/CLI_interface/setCourse.png)

### Withdraw
[image](https://github.com/glebzverev/ZerionHACK/blob/main/CLI_interface/withdraw.png)

### Транзакции
[image](https://github.com/glebzverev/ZerionHACK/blob/main/CLI_interface/%D0%A2%D1%80%D0%B0%D0%BD%D0%B0%D0%B7%D0%B0%D0%BA%D1%86%D0%B8%D0%B8%20BSC%20Testnet.png)
