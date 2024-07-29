export default class BaseResp<T> {
  errorCode: number = 0;
  errorMsg: string = "";
  data?: T | undefined = undefined;

  constructor(errorCode: number, errorMsg: string, data: T | undefined) {
    this.errorCode = errorCode;
    this.errorMsg = errorMsg;
    this.data = data;
  }
}

export class ErroCode {
  static readonly OK = 0;
  static readonly LOGIN_FAILED = -1001;
}