---
title: The xPack OpenOCD Frequently Asked Questions

hide_table_of_contents: true

date: 2020-09-28 17:49:00 +0300

---

<details>
<summary>My JTAG probe XXX is not supported, can you add it?</summary>

Unfortunately not. The xPack OpenOCD is only a binary distribution of the standard source code OpenOCD, and does not intend to add new functionality. Please use the official OpenOCD [support channels](https://openocd.org/pages/discussion.html) to ask for new features.
</details>

<details>
<summary>I cannot find a connection script for my board XXX, can you add it?</summary>

Unfortunately not. The xPack OpenOCD is only a binary distribution of the standard source code OpenOCD, and does not intend to add new functionality. Please use the official OpenOCD [support channels](https://openocd.org/pages/discussion.html) to ask for new features.
</details>

<details>
  <summary>`libusb_open failed: LIBUSB_ERROR_ACCESS`</summary>

You are using GNU/Linux and your user has no permission to write to USB. Please review the [Install Guide](/docs/install/#drivers) page.
</details>
