public with sharing class SetAccountRankBatchScheduler implements Schedulable {
  public void execute(SchedulableContext sc) {
    SetAccountRankBatch sarb = new SetAccountRankBatch();
    database.executeBatch(sarb);
  }
}
