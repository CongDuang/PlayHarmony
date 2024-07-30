import axios, { AxiosError, AxiosInstance, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import Logger from '../common/Logger';
import { JSON } from '@kit.ArkTS';
import BaseResp from '../models/BaseResp';

export default class HttpUtil {
  private static instance?: HttpUtil | null = null;
  private static axiosInstance?: AxiosInstance | null = null;

  private constructor() {
    if (!HttpUtil.instance) {
      HttpUtil.instance = null;
    }

    HttpUtil.axiosInstance = axios.create({
      baseURL: "https://www.wanandroid.com",
      timeout: 10_000,
      headers: {},
    })

    HttpUtil.axiosInstance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
      Logger.debug(`发送请求 ==================>`,
        `${'\n'} method：${config.method} ${config.baseURL} ${'\n'} url: ${config.url}`)
      Logger.debug('请求参数', config.data ?? "无");
      return config;
    }, (error: AxiosError) => {
      Logger.error('请求错误：', JSON.stringify(error));
      if (error.status === 400) {
        return Promise.resolve(new BaseResp(error.status, error.stack ?? "", null))
      }
      return Promise.reject(error);
    })

    HttpUtil.axiosInstance.interceptors.response.use((response: AxiosResponse) => {
      Logger.debug('响应结果==================> \n', JSON.stringify(response));
      return response;
    }, (error: AxiosError) => {
      Logger.error('请求错误：', JSON.stringify(error));
      return Promise.reject(error);
    })
  }

  static getInstance(): HttpUtil {
    if (!HttpUtil.instance) {
      HttpUtil.instance = new HttpUtil();
    }
    return HttpUtil.instance;
  }

  /**
   * post 请求
   * @param url
   * @param data
   * @returns
   */
  post<Resp, Data>(url: string, data: Data): Promise<AxiosResponse<BaseResp<Resp>, Data>> {
    return HttpUtil.axiosInstance!.post<Resp, AxiosResponse<BaseResp<Resp>, Data>, Data>(url, data)
  }

  async get<Resp, Data>(url: string, data?: Data): Promise<BaseResp<Resp>> {
    const resp: AxiosResponse<BaseResp<Resp>> = await HttpUtil.axiosInstance!.get(
      url,
      {
        data: data
      },
    );
    return Promise.resolve(resp.data);
  }
}