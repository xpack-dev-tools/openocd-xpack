/*
 * DO NOT EDIT!
 * Automatically generated from xbb-helper/templates/docusaurus/common.
 *
 * This file is part of the xPack project (http://xpack.github.io).
 * Copyright (c) 2024 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/MIT/.
 */

import customField from '@site/src/libs/customField';

export default function HistoryXpm({specifier}): JSX.Element {
    return (
        <>The xPack metadata has been added, and the package can now be more conveniently installed via <b>xpm</b>. It is  available from <code>npmjs.com</code> as <code>{specifier ? specifier : '@xpack-dev-tools/openocd'}</code></>
    );
}
