public with sharing class AccountTriggerHandler {
  public static void beforeInsert(List<Account> accounts) {
    for (Account acc : accounts) {
      checkUrl(acc);
      replaceName(acc);
    }
    updateHasManagerBefore(null);
  }

  public static void beforeUpdate(
    Map<Id, Account> oldMap,
    List<Account> accounts
  ) {
    for (Account acc : accounts) {
      checkUrl(acc);
      replaceName(acc);
    }
    updateHasManagerBefore(oldMap);
  }

  public static void beforeDelete(Map<Id, Account> oldMap) {
    updateHasManagerBefore(oldMap);
  }

  public static void afterInsert(List<Account> accounts) {
    updateHasManagerAfter(accounts);
  }

  public static void afterUpdate(
    Map<Id, Account> oldMap,
    List<Account> accounts
  ) {
    updateHasManagerAfter(accounts);
  }

  public static void afterDelete(Map<Id, Account> oldMap) {
    updateHasManagerAfter(accounts);
  }

  private static final Pattern URL_PATTERN = Pattern.compile(
    'https?://[\\w!\\?/\\+\\-_~=;\\.,\\*&@#\\$%\\(\\)\'\\[\\]]+'
  );

  private static void checkUrl(Account acc) {
    if (String.isBlank(acc.Website))
      return;

    if (!(URL_PATTERN.matcher(acc.Website).matches())) {
      acc.Website.addError('URLの形式が間違っています。');
    }
  }

  private static void replaceName(Account acc) {
    if (String.isBlank(acc.Name))
      return;
    acc.Name = acc.Name.replace('(株)', '株式会社');
  }

  private static void updateHasManagerBefore(Map<Id, Account> oldMap) {
    if (oldMap == null)
      return;

    List<Contact> updList = new List<Contact>();
    for (Account acc : oldMap.values()) {
      if (acc.Manager__c != null) {
        Contact newManeger = new Contact(Id = acc.Manager__c);
        newManeger.HasManager__c = false;
        updList.add(newManeger);
      }
    }
    update updList;
  }

  private static void updateHasManagerAfter() {
    List<Account> accounts = [SELECT Id, Manager__c FROM Account];
    List<Contact> updList = new List<Contact>();
    for (Account acc : accounts) {
      if (acc.Manager__c != null) {
        Contact newManeger = new Contact(Id = acc.Manager__c);
        newManeger.HasManager__c = true;
        updList.add(newManeger);
      }
    }
    update updList;
  }

  // private static void updateHasManagerFalse(Map<Id,Account> oldMap,List<Account> accounts){
  //     Map<Id,Id> ids = new Map<Id,Id>();
  //     for (Account oldAcc : oldMap.values()){
  //         if (oldAcc.Manager__c != null){
  //             ids.put(oldAcc.Id,oldAcc.Manager__c);
  //         }
  //     }

  //     List<Account> accList = [SELECT Id,Manager__c FROM Account WHERE Manager__c IN :ids.values()];
  //     Map<Id,List<Account>> checkMap = new Map<Id,List<Account>>();
  //     for (Account acc : accList){
  //         if (!checkMap.containskey(acc.Manager__c)) {
  //             checkMap.put(acc.Manager__c,new List<Account>());
  //         }
  //         List<Account> checkList = checkMap.get(acc.Manager__c);
  //         checkList.add(acc);
  //     }

  //     List<Contact> updList = new List<Contact>();
  //     if (accounts != null){
  //         updList = getUpdListForUpdate(ids, checkMap, accounts);
  //     }else{
  //         updList = getUpdListForDelete(checkMap);
  //     }
  //     update updList;
  // }

  // private static List<Contact> getUpdListForUpdate(Map<Id,Id> ids,Map<Id,List<Account>> checkMap,List<Account> accounts){
  //     List<Contact> updList = new List<Contact>();
  //     for (Account acc : accounts){
  //         if (!ids.containsKey(acc.Id)) continue;

  //         Id managerId = ids.get(acc.Id);
  //         List<Account> checkList = checkMap.get(managerId);
  //         if (ids.get(acc.Id) != acc.Manager__c){
  //             checkList.remove(0);
  //         }

  //         if (checkList.size() == 0){
  //             Contact newManeger = new Contact(Id = ids.get(acc.Id));
  //             newManeger.HasManager__c = false;
  //             updList.add(newManeger);
  //         }
  //     }
  //     return updList;
  // }

  // private static List<Contact> getUpdListForDelete(Map<Id,List<Account>> checkMap){
  //     List<Contact> updList = new List<Contact>();
  //     for (List<Account> accList : checkMap.values()){
  //         if (accList.size() == 1){
  //             Account acc = accList.get(0);
  //             Contact newManeger = new Contact(Id = acc.Manager__c);
  //             newManeger.HasManager__c = false;
  //             updList.add(newManeger);
  //         }
  //     }
  //     return updList;
  // }
}
