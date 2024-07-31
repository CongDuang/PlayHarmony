import { hilog } from '@kit.PerformanceAnalysisKit';

const LOGGER_TAG: string = "Play Harmony";

class Logger {
  private domain: number;
  private tag: string;
  private format: string = '%{public}s   %{public}s';

  constructor(prefix: string = '', domain: number = 0xFF00) {
    this.domain = domain;
    this.tag = prefix;
  }

  debug(...args: string[]): void {
    hilog.debug(this.domain, this.tag, this.format, args)
  }

  error(...args: string[]): void {
    hilog.error(this.domain, this.tag, this.format, args);
  }
}

export default new Logger(LOGGER_TAG);