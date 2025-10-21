declare module 'better-sqlite3' {
  import type { EventEmitter } from 'node:events';

  interface Statement<BindParameters extends any[] = any[], Result = unknown> {
    run(...params: BindParameters): { changes: number; lastInsertRowid: bigint | number };
    get(...params: BindParameters): Result;
    all(...params: BindParameters): Result[];
    iterate(...params: BindParameters): IterableIterator<Result>;
  }

  interface Transaction {
    (...params: any[]): any;
  }

  interface DatabaseOptions {
    readonly memory?: boolean;
    readonly readonly?: boolean;
    readonly fileMustExist?: boolean;
    readonly timeout?: number;
    readonly verbose?: ((message?: any, ...additional: any[]) => void) | null;
  }

  class Database extends EventEmitter {
    constructor(filename?: string, options?: DatabaseOptions);
    readonly name: string;
    close(): void;
    prepare<BindParameters extends any[] = any[], Result = unknown>(sql: string): Statement<
      BindParameters,
      Result
    >;
    pragma(pragma: string, options?: { simple?: boolean }): unknown;
    transaction(fn: (...params: any[]) => any): Transaction;
    exec(sql: string): void;
  }

  export = Database;
}
