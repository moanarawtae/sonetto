import type { RendererBridge } from '../common/types';

declare global {
  interface Window {
    sonetto: RendererBridge;
  }
}

export {};
