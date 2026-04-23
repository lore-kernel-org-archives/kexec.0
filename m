Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED45FDEE4E
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Mime-Version:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=; b=ERw6STfl+Py0edYJB1DDoz9RaJ
	zO/2tJ1cJ6CmF4GxEs5iYm0dE3sMrIvUlfLV65oRklR3olqz7gJqBa7/m7yJ9eO/rOujKd1pEuHDe
	flOOJ05ZeQExjfwhRR/y916f99jKgjSwS/dEzIx4/jqry3ZXuGhpRm65X/BV6IIpVXuNFmZ4GLA+v
	o7dzRDrWOb1QraRE1Pua2bAubBBBbYB37qo8NN5kfS2QrYeSJpy8u5BhfZYoy+QRwTmX5FqA0GdBY
	odRWMu8GtY1FX7LTmJZ9CXD5p3vWpdy6bgH65RUkYG6b12iHFJ7eFCAi+KGXCy3fJioAuv9c7lG4L
	lSKLXOiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1VY-0000000CKym-47nN;
	Thu, 23 Apr 2026 21:22:48 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1VV-0000000CKyN-3UY1
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:22:47 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b24af7ca99so96466245ad.1
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979364; x=1777584164; darn=lists.infradead.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=ZX8Mwtc5FYqzcbTRFTOqMN3ThkL4apBJtzljeT4NNKQk+cm6Xv9FyMoGFgEjtfoDcR
         N3LDuvt5r2YEzgVDLtF+Ae4F81i3XIPhiVvVasbILeR4ppuBzeZH3ZxZWpJbYooyhl7X
         2pjI/L1V33INaOueWIres1ONIjvgQY7nZOzXvbFeHjBkRhQyQeCcg7claaFX4Pi4h67q
         cQFE00q5f9q5Y9rrhfxKXQYXRtG3BvyYgAu4lIdghNFn32UpFw2vRt+IS37j9yyaRhjd
         l2HnkHI+DtdYlBsLyZ3QU/1WXP8comyDnFmlAQOG7XuGGQlXq27VkcIPKvN6v4A5vFSj
         v72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979364; x=1777584164;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=EzyLvypoeOa7f6XRsZbTfq+fvuXZtjroLvSGFO3B62jOEmilWejLbrncD0Vf8WRr7j
         F/fZzohhBQtnbCECbvUBSZ5aAFR62BPLc5uJr+TB0KngPWdFjffAGCpV4TdS5YPqwM9m
         TpV8ORoBGuhIGmDKvnz/dFDwXkZ96QpHUZZv5nGPEEXId5BFD+sXjXChONsonKzvPoJl
         ZSn55kDijT1m9hX4zjw0J/EfpEG92H8prPIftmyXlroXx5c582Zn3lsbKirsTQstnHi3
         oxeFybFEDyxh06yYTUaVKp0hKCA+Mem2A3kP7JtgvE4Tu2YwIWiUjbU+/98lOZAy3tEE
         yf1A==
X-Forwarded-Encrypted: i=1; AFNElJ+YLUxWAEEEatJYVC/cOgzsA940uPeiljuka5kzV1WMg7cgX+w1Y1ev0wOX5pA6uIDcyBJU3Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5srZWDSnPTSUwp5/5qIm4XFb66yZiH3vRm0MvLjnMK1Lxc8G5
	S26FzpexdatJV0UEEk+qNMMg6468iD1fPmEiigCpPrPnAsUqDwHKq+7U8x8s0L9A9hn5Wquy2f9
	9gkQW3k0STJJqUQ==
X-Received: from plnx22.prod.google.com ([2002:a17:902:8216:b0:2ae:ce70:7c80])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:7d8c:b0:2b4:604c:ec6f with SMTP id d9443c01a7336-2b5f9f86840mr213628685ad.32.1776979363647;
 Thu, 23 Apr 2026 14:22:43 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:22:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212242.3431136-1-dmatlack@google.com>
Subject: [PATCH v4 00/11] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: dmatlack@google.com, iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_142245_885507_241ADE13 
X-CRM114-Status: GOOD (  24.17  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v4

This patch series introduces support in the PCI core for Live Update,
enabling drivers to preserve PCI devices across a kexec-based kernel
update without interrupting the device. This functionality is critical
for minimizing downtime in environments where PCI devices (e.g., those
assigned to VMs via VFIO) must continue operating or maintain state
across a host kernel upgrade.

This series was split off from the the VFIO driver series [1] to enable
more rapid iteration on the PCI core changes, add breathing room to
split changes into smaller patches, and add some more functionality.

Series Overview
---------------

This series implements the following to support PCI device preservation
across Live Update:

  1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
     PCI-specific state (struct pci_ser) across Live Update using Kexec
     Handover (KHO).

  2. Add APIs for drivers to register "outgoing" devices for
     preservation and for the PCI core to identify "incoming" preserved
     devices during enumeration.

  3. Automatically preserve all upstream bridges for any preserved
     endpoint. Use reference counting to ensure bridges remain preserved
     as long as any downstream device is preserved.

  4. Inherit secondary/subordinate bus numbers, ARI Forwarding Enable,
     and Access Control Services (ACS) flags from the previous kernel to
     ensure a stable routing fabric and consistent IOMMU group
     assignments during Live Update.

  5. Restrict preservation to devices in immutable singleton IOMMU
     groups. Require that all upstream bridges have the necessary ACS
     features enabled to prevent IOMMU group changes across the update.

  6. Modify the PCI shutdown path to avoid disabling bus mastering on
     preserved devices and their upstream bridges, allowing memory
     transactions to continue uninterrupted.

  7. Provide comprehensive documentation for the FLB API, device
     tracking mechanisms, and the division of responsibilities between
     the PCI core, drivers, and userspace.

This series could be simplified down to fewer patches by limiting
preservation support to only devices on a root bus. Supporting devices
downstream of bridges could be split off into a follow-up series.
However since I got bridge preservation working and the series was less
than 15 patches I opted to include it for now.

Dependencies
------------

This series depends on 2 LUO patches to enable refcounting of the
incoming FLB so that it is safe for the PCI core to use
liveupdate_flb_get_incoming() during enumeration.

  https://lore.kernel.org/lkml/20260423174032.3140399-1-dmatlack@google.com/

VFIO support for PCI device preservation is built on top of this series.
The following branch on GitHub contains all the patches together to
enable testing (the LUO FLB changes, this series, and the VFIO patches):

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v4-with-vfio

Testing
-------

This series was tested in combination with the VFIO patches mentioned in
the previous section using the the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were ran in ran in a QEMU-based VM environment, using a
single virtio-net PCIe device behind a PCI-to-PCI bridge as the test
device, and in a baremetal environment on an Intel EMR server, using 8x
Intel DSA PCIe devices (each on a host bridge).

Future Work
-----------

After this series we expect to make further improvements to the PCI core
support for Live Update. Once these are done we plan to drop the
"experimental" verbiage from PCI_LIVEUPDATE Kconfig help message and
documentation.

  - Ensure bridges with downstream preserved devices stay in D0 across
    Live Update in case preserved endpoints are doing memory
    transactions.
  - Preserve BARs of all preserved devices to avoid disrupting P2P

Beyond that we also plan to add support for preserving Virtual Functions
since that is a major use-case for Cloud environments. This will require
keeping SR-IOV enabled on the partent PF across a Live Update.

Changelog
---------

v4:

 Enhancements on top of previous series:

 - Split "PCI: Add API to track PCI devices preserved across Live
   Update" from v3 into 4 separate commits to make reviewing easier (FLB
   setup, outgoing device tracking, incoming device tracking, and
   documentation for driver binding)
 - Use new incoming FLB refcounting to avoid use-after-free bugs during
   enumeration
 - Use an xarray to speed up looking up of incoming preserved devices
   during enumeration
 - Use a per-device bit to indicate when secondary and subordinate bus
   numbers should be inherited on bridges instead of global data to
   avoid races between the 2 passes
 - Inherit ARI enablement across Live Update
 - Automatically preserve bridges upstream of preserved endpoints so
   so that ACS flags, ARI enablement, and bus mastering can be kept
   constant on bridges across Live Update
 - Avoid clearing bus mastering during shutdown on outgoing preserved
   device to avoid disrupting memory transcations being performed by
   preserved devices
 - Add a MAINTAINERS entry for the new files to support Live Update in
   the PCI core
 - Add info and debug level logging for various events throughout device
   preservation

 Changes based on review feedback on v3:

 - Fix up typos, wording, documentation gaps, and code style (Bjorn)
 - Use pci_WARN_ONCE() where possible (Bjorn)
 - Require ACS flags to preserve devices behind bridges so that
   singleton IOMMU group topology is guaranteed to remain across Live
   Update (Yi)
 - Preserve ACS flags (Jason, Alex)

v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/

v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/

v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


[1] https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/

David Matlack (11):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Inherit bus numbers during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: liveupdate: Inherit ACS flags in incoming preserved devices
  PCI: liveupdate: Require preserved devices are in immutable singleton
    IOMMU groups
  PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/liveupdate.rst              |  23 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   1 +
 MAINTAINERS                                   |  13 +
 drivers/iommu/iommu.c                         |  35 ++
 drivers/pci/Kconfig                           |  14 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 562 ++++++++++++++++++
 drivers/pci/pci-driver.c                      |  31 +-
 drivers/pci/pci.c                             |  22 +-
 drivers/pci/pci.h                             |  13 +
 drivers/pci/probe.c                           |  25 +-
 include/linux/iommu.h                         |   7 +
 include/linux/kho/abi/pci.h                   |  62 ++
 include/linux/pci.h                           |  58 ++
 16 files changed, 858 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h


base-commit: a13f7eb5b2d5bef886659768680093bec1c0470d
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


