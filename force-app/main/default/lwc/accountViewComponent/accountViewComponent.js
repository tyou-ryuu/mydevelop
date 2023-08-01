import { LightningElement, api } from "lwc";

export default class AccountViewComponent extends LightningElement {
  @api accountList;

  handleSelect(event) {
    const selectedAccount = this.accountList[event.detail.name];
    const newEvent = new CustomEvent("selected", { detail: selectedAccount });
    this.dispatchEvent(newEvent);
  }

  inputKeyword;

  async searchForKeyword(event) {
    this.inputKeyword = event.target.value;
    const searchEvent = new CustomEvent("search", {
      detail: this.inputKeyword
    });
    this.dispatchEvent(searchEvent);
  }
}
