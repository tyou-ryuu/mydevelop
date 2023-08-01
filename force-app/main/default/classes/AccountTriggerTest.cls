@isTest
public with sharing class AccountTriggerTest {
  @istest
  static void isertTest_urlFalse() {
    Account acc = new Account(Name = 'test1', Website = 'ss');
    try {
      Test.startTest();
      insert acc;
      Test.stopTest();
      Assert.fail('例外未発生');
    } catch (Exception e) {
      Assert.areEqual('URLの形式が間違っています。', e.getDmlMessage(0));
    }
  }

  @istest
  static void insertTest_urlBlank() {
    Account acc = new Account(Name = 'test2');

    Test.startTest();
    insert acc;
    Test.stopTest();

    Account result = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];

    Assert.areEqual(acc.Name, result.Name);
  }

  @istest
  static void insertTest_nameHasKeyword() {
    Account acc = new Account(Name = '朝日側(株)');

    Test.startTest();
    insert acc;
    Test.stopTest();

    Account result = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];

    Assert.areEqual('朝日側株式会社', result.Name);
  }

  @istest
  static void insertTest_HasManager() {
    Contact con = new Contact(LastName = 'test3');
    Account acc = new Account(Name = 'test3');

    Test.startTest();
    insert con;
    acc.Manager__c = con.Id;
    insert acc;
    Test.stopTest();

    Contact result = [SELECT HasManager__c FROM Contact WHERE Id = :con.Id];

    Assert.isTrue(result.HasManager__c);
  }

  @istest
  static void updateTest_urlFalse() {
    Account acc = new Account(Name = 'test1');
    try {
      Test.startTest();
      insert acc;

      acc.Website = 'aa';
      update acc;
      Test.stopTest();
    } catch (Exception e) {
      Assert.areEqual('URLの形式が間違っています。', e.getDmlMessage(0));
    }
  }

  @istest
  static void updateTest_urlBlank() {
    Account acc = new Account(Name = 'test2');

    Test.startTest();
    insert acc;
    update acc;
    Test.stopTest();

    Account result = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];

    Assert.areEqual(acc, result);
  }

  @istest
  static void updateTest_nameHasKeyword() {
    Account acc = new Account(Name = '朝日側');

    Test.startTest();
    insert acc;

    acc.Name = '朝日側(株)';
    update acc;
    Test.stopTest();

    Account result = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];

    Assert.areEqual('朝日側株式会社', result.Name);
  }

  @istest
  static void updateTest_HasManager() {
    Contact con = new Contact(LastName = 'test3');
    Account acc = new Account(Name = 'test3');

    Test.startTest();
    insert con;
    insert acc;

    acc.Manager__c = con.Id;
    update acc;
    Test.stopTest();

    Contact result = [SELECT HasManager__c FROM Contact WHERE Id = :con.Id];

    Assert.areEqual(true, result.HasManager__c);
  }
}
