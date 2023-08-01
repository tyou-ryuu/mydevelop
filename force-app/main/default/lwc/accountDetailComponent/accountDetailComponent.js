import { LightningElement, api } from "lwc";
import MyModal from "c/myModal";

export default class AccountDetailComponent extends LightningElement {
  @api account = {};

  // @api
  // reset(){
  //     const inputFields = this.template.querySelectorAll('lightning-input-field');
  //     inputFields.forEach(field => {
  //         field.reset();
  //     });
  // }

  async handleClick(event) {
    event.preventDefault();
    const result = await MyModal.open();
    if (result === "OK") {
      const fields = event.detail.fields;
      this.refs.form.submit(fields);
    }
    // else{
    //     this.reset();
    // }
  }
}
