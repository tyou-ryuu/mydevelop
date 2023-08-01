public with sharing class SetAccountRankBatch implements Database.Batchable<SObject>, Database.Stateful {
  public Database.QueryLocator start(Database.BatchableContext dbc) {
    String query = 'SELECT Id,(SELECT Amount FROM Opportunities) FROM Account ';

    return Database.getQueryLocator(query);
  }

  public void execute(Database.BatchableContext dbc, List<Account> accList) {
    for (Account acc : accList) {
      Decimal totalAmount = 0;
      for (Opportunity op : acc.Opportunities) {
        if (op.Amount == null)
          continue;
        totalAmount += op.Amount;
      }
      acc.Rank__c = getAccountRank(acc.Opportunities.size(), totalAmount);
    }
    update accList;
  }

  private static String getAccountRank(Integer count, Decimal totalAmount) {
    if (count == 0) {
      return 'D';
    } else if (count < 3 && totalAmount >= 50000000) {
      return 'S';
    } else if (count >= 3 && totalAmount >= 100000000) {
      return 'A';
    } else if (count >= 3 && totalAmount >= 50000000) {
      return 'B';
    } else {
      return 'C';
    }
  }

  public void finish(Database.BatchableContext dbc) {
    System.debug('Batch end');
  }
}
