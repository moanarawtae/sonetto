declare module 'react-virtualized-auto-sizer' {
  import * as React from 'react';

  interface AutoSizerProps {
    children: (size: { height: number; width: number }) => React.ReactNode;
    defaultHeight?: number;
    defaultWidth?: number;
    disableHeight?: boolean;
    disableWidth?: boolean;
    onResize?: (size: { height: number; width: number }) => void;
    style?: React.CSSProperties;
  }

  const AutoSizer: React.FC<AutoSizerProps>;
  export default AutoSizer;
}
