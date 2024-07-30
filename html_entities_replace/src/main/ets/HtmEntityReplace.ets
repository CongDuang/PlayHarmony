import decodeMap from '../resources/rawfile/decode-map.json';

export  class HtmlEntityReplace {
  private constructor() {
  }

  /**
   * 替换方法
   * @param str 原字符串
   * @returns 处理过的结果字符串
   */
  static replace(str?: string): string | undefined {
    if (!str) {
      return;
    }
    return str.replace(/&(\w+);/g, (match: string, entity: string) => {
      const res = decodeMap[entity] as string | undefined;
      return res || match;
    })
  }
}