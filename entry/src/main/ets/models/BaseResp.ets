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

/**
 * 分页结构
 */
export class PageInlineResp<T> {
  curPage: number = 1;
  datas: T[] = [];
  offset: number = 0;
  over: boolean = false; // 是否到底
  pageCount: number = 779;
  size: number = 20;
  total: number = 0;
}

export class ErroCode {
  static readonly OK = 0;
  static readonly LOGIN_FAILED = -1001;
}