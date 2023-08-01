import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getAccountDatas from "@salesforce/apex/dao.getAccountDatas";
import searchAccountDatas from "@salesforce/apex/dao.searchAccountDatas";

export default class AllPageComponent extends LightningElement {
  account;
  accountList;

  async connectedCallback() {
    this.accountList = await getAccountDatas();
  }

  handleSelect(newEvent) {
    this.account = newEvent.detail;
  }

  async handleSearch(searchEvent) {
    this.accountList = await searchAccountDatas({ name: searchEvent.detail });
  }

  async handleSuccess() {
    this.accountList = await getAccountDatas();
    const evt = new ShowToastEvent({
      title: "保存が完了致しました。",
      variant: "success"
    });
    this.dispatchEvent(evt);
  }
}
