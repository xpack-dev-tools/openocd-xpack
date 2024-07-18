/*
 * This file is part of the xPack project (http://xpack.github.io).
 * Copyright (c) 2024 Liviu Ionescu. All rights reserved.
 *
 * Permission to use, copy, modify, and/or distribute this software
 * for any purpose is hereby granted, under the terms of the MIT license.
 *
 * If a copy of the license was not distributed with this file, it can
 * be obtained from https://opensource.org/licenses/MIT/.
 */

import clsx from 'clsx';

export default function LinksVsForwarders({isWindows}): JSX.Element {
  if (isWindows)
    return (
        <>
          <code>.cmd</code> forwarders
        </>
      )
  else
    return (
      <>
        symbolic links
      </>
    )
}
