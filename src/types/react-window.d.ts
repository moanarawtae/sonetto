declare module 'react-window' {
  import * as React from 'react';

  export interface ListChildComponentProps<T> {
    index: number;
    style: React.CSSProperties;
    data: T;
  }

  export interface FixedSizeListProps<T> {
    height: number;
    width: number;
    itemCount: number;
    itemSize: number;
    itemData: T;
    className?: string;
    children: React.ComponentType<ListChildComponentProps<T>>;
  }

  export class FixedSizeList<T> extends React.Component<FixedSizeListProps<T>> {}
}
