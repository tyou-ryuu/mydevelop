public with sharing class dao {
  @AuraEnabled
  public static List<Account> getAccountDatas() {
    return [
      SELECT Id, Name, AccountNumber, Industry, Ownership, Fax, Phone
      FROM Account
      LIMIT 100
    ];
  }

  @AuraEnabled
  public static List<Account> searchAccountDatas(String name) {
    String searchKeyword = '%' + name + '%';
    return [
      SELECT Id, Name, AccountNumber, Industry, Ownership, Fax, Phone
      FROM Account
      WHERE Name LIKE :searchKeyword
      LIMIT 100
    ];
  }
}
