import LightningModal from "lightning/modal";

export default class MyModal extends LightningModal {
  handleOK() {
    this.close("OK");
  }

  handleCancel() {
    this.close("Cancel");
  }
}
