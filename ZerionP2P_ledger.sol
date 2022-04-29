// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract ZerionP2P_ledger is Ownable{
    using SafeMath for uint256;

    mapping (address=>uint256)  public balances; // Балансы пользователей
    mapping (address=>uint256)  public exchange_course; // Курс обмена криптовалюты
    mapping (address=>bool)     public lock; // Временная блокировка вывода средств

    address [] public wallets ; // Для возврата в случае уничтожения
    address private _owner; // Адрес создателя и владельца контракта
    address public ZerionP2P_ledger_addr; // Адрес контракта

    // Защита от мошенничества с выводосм средсв во время транзакции
    modifier Unlock(){
        require(lock[msg.sender] != false, "Your wallet is lock");
        _;
    }

    modifier balanceIsNotNull(address addr){
        require(balances[addr]>0);
        _;
    }
    // Владелец - создавший контракт
    // Адресс контракта
    constructor() {
        _owner = msg.sender;
        ZerionP2P_ledger_addr = address(this);
    }

    // Установка курса для продажи владельцем
    function setCourse(uint256 _course, address _addr) public onlyOwner balanceIsNotNull(_addr){
        lock[msg.sender] = false;
        wallets.push(msg.sender);
        exchange_course[_addr] = _course;
    }

    // Просмотр баланса смарт контракта 
    function balanceOf() external view returns(uint256){
        return address(this).balance;
    }

    // Перевод средств со счёта на счёт
    function withdraw(address _from, address _to, uint256 amount) public onlyOwner{
        require(_owner == msg.sender && balances[_from] >= amount );
        require(exchange_course[_from]!=0);
        address payable receiver = payable(_to);
        receiver.transfer(amount);
        balances[_from] -= amount;
    }

    // Защита от мошенничества с выводосм средсв во время транзакции
    function lockWallet(address _addr, bool _lock) public onlyOwner{
        lock[_addr] = _lock;
    }

    // Функция возврата средств со счёта контракта их владельцу
    function returnWallet(uint256 amount) public Unlock{
        require(balances[msg.sender]>=amount);
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
    }

    // Уничтожение смарт контракта с возвратом средств их владельцам
    function destroyContract() external onlyOwner{
        for(uint i = 0; i < wallets.length; i++) {
            address payable reciever = payable(wallets[i]);
            reciever.transfer(balances[reciever]);
        }
        selfdestruct(payable(address(this)));
    }

    // Функция приёма средств
    receive() external payable {
        require(true);
        balances[msg.sender]+=msg.value;
    }
}