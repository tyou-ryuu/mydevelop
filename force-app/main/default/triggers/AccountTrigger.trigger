trigger AccountTrigger on Account(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete
) {
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      AccountTriggerHandler.beforeInsert(Trigger.new);
    } else if (Trigger.isUpdate) {
      AccountTriggerHandler.beforeUpdate(Trigger.oldMap, Trigger.new);
    } else if (Trigger.isDelete) {
      AccountTriggerHandler.beforeDelete(Trigger.oldMap);
    }
  }

  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      AccountTriggerHandler.afterInsert(Trigger.new);
    } else if (Trigger.isUpdate) {
      AccountTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.new);
    } else if (Trigger.isDelete) {
      AccountTriggerHandler.afterDelete(Trigger.oldMap);
    }
  }
}
