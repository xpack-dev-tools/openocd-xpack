import React from 'react';
import CodeBlock from '@theme/CodeBlock';

export default function InstallWithCopy({ children }): JSX.Element {
    return (
        <CodeBlock>
            {children}
        </CodeBlock>
    );
}
