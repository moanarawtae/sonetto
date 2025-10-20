declare module 'electron-log/main' {
  import type { Transport } from 'electron-log';

  interface Logger {
    scope(...keys: string[]): Logger;
    initialize(): void;
    debug(message: string, ...meta: unknown[]): void;
    info(message: string, ...meta: unknown[]): void;
    warn(message: string, ...meta: unknown[]): void;
    error(message: string | Error, ...meta: unknown[]): void;
    transports: Record<string, Transport>;
  }

  const logger: Logger;
  export default logger;
}
