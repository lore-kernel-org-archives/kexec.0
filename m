Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE43C44507
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 21:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=he4LlVclK6dw2y5zUcgVn+6YxGRxdITg+d/Le4uVaLE=; b=kjRxfi4JgNOyGAMOv/K7GWU1mc
	vcJZAS5dRKLvfuIU8vbpfXsLhYryPN4IHFCEOCpnL25p+rvN6AaX1UbJvHY9HLRBl4dWdyyRNYlFZ
	0djhl3IC4kelDA9yeBRQ7YkxsbgBNqqRFuApkOuwh9NTX6C9AfjzCOmdGA6fXwOJ/yhEsLQClae3B
	G79MjgFyzhFrAE/hCyxlnGArPVkwNRHBG9ZmBsVMMt32E41KlAbx7GwOH/eZ3DOBOZIS5AhVM9KpF
	6G+uJ9/z6Du4VNVMUI3WCSHp8GT6JAsKS1W3sF5Z2aqouwiMO7YrQdQrUty9S6Uyl7EJTnj8kqpDz
	kDJONnWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjr-00000005pMk-2TE7;
	Fri, 10 Jul 2026 21:26:27 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiIjp-00000005pLO-0ZF0
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 21:26:26 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-8484ba00601so1449665b3a.1
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718784; x=1784323584; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=he4LlVclK6dw2y5zUcgVn+6YxGRxdITg+d/Le4uVaLE=;
        b=JqT6TlCkkppEDpa6TmhgVhKdtFjvnHH9YHJcbDbtB4eMHtg6h4o/NvIAyx30A0Hy4u
         4l9oU/Mfw3SdY5La19Vd3Q9zgz01AFusjx5UBB+KZlBC4p9FOK6ly8b01uN9ZtuGQDSL
         C7XbWFEvzvy+i2HrcZtmB87p6eFRA2lSvcvl0UP/f1GPTw84i8dJyA4DYyB0By0XoaSB
         ozDsT06Rb8PokuZ1jY/UOJmDgB26Rhtu6bqAqd6x7FeWFJ89DFI9GmKqOtfkqBrAK3Dt
         /adEmNuQD2z6zH6L2jPr8KSYlf/5y6+bKgQgG5CYL/FMh5LElq1D7wWk3m+6U+QcOHf3
         jtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718784; x=1784323584;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=he4LlVclK6dw2y5zUcgVn+6YxGRxdITg+d/Le4uVaLE=;
        b=j8PgYKkqEJaxe+eqdyEkpAJ/QHgqE0OT8fgqDWdyP7blw0l+R8mQd+G7JVpEsRxuRr
         jlz8VWMGMHHswh/aFQglMeDlQj9bNZJWUaJDcfqx4xeQuAXUfeLe5F/f7qgysL760oxV
         2MSm4VQSEzYOgpwomAHR3shsyva1x7U5cDXJXc6kNGor9gyKA7dt/IcvYRL0rxVVhDgQ
         aApI8Fp52f5wX9K6GTZWred2BzDVyysCAXF+AuO9FB8gNuIOMXEQRNUGE7EbcRIG9+fE
         stU5KLEd7rQvyaJPHeBIr2iZo0v+kq8Zw7yASoSPzBGjHmZt/GkcyoqdB5RoaERzy99/
         1zBA==
X-Gm-Message-State: AOJu0YwihT8ntyng0qwxeIxLb8kzn1CybZj2A0H/YSPKWNKUsRvAzoHr
	lGEeJmebl1HHHP6f0gfwwsmJfGYDFh4mGSf84bzD2LChQcLjvbSNWonVvzKFgL+ifCxZsPn4LB7
	nvoxioKvJmxYX/eMU5mq8/TBJBrZQR3Pz+BBunjtRSQ3Bzp/GJizRSDp1fPngO4lVHG89XSe2S/
	gfj2sMDXT2DE5KzgnG9Sx8C+V8WDHgmkOaNhf6c66VqSRz794RE6s=
X-Received: from pfud15.prod.google.com ([2002:a05:6a00:10cf:b0:847:9be8:84d5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:228e:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-848896c39e2mr550236b3a.9.1783718783127;
 Fri, 10 Jul 2026 14:26:23 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-1-dmatlack@google.com>
Subject: [PATCH v7 00/12] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_142625_181286_10AB4DE1 
X-CRM114-Status: GOOD (  19.05  )
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

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v7

This series introduces initial support in the PCI core for Live Update,
enabling drivers to preserve PCI devices across a kexec-based kernel
update without interrupting the device. This functionality is critical
for minimizing downtime in environments where PCI devices (e.g., those
assigned to VMs via VFIO) must continue operating or maintain state
across a host kernel upgrade.

Specifically, this series allows preserved PCI devices to perform
uninterrupted memory transactions (DMA) to/from system memory across a
Live Update. These devices can be behind a bridge but must not be VFs.
Support for P2P and VF preservation will be addressed in future series.

Series Overview
---------------

This series implements the following to support PCI device preservation
across Live Update:

  1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
     PCI-specific state (struct pci_ser) across Live Update using Kexec
     Handover (KHO).

  2. Add APIs for drivers to register devices for preservation
     (outgoing) and for the PCI core to identify preserved devices
     during enumeration (incoming)

  3. Automatically preserve all upstream bridges for any preserved
     endpoint. Use reference counting to ensure bridges remain preserved
     as long as any downstream device is preserved.

  4. Guarantee that preserved devices retain the same RequesterID (bus,
     device, function) for the duration of their preservation by
     inheriting secondary bus numbers, subordinate bus numbers, and ARI
     Forwarding Enable on preserved bridges.

  5. Guarantee that memory transactions to/from preserved devices are
     routed consistently by inheriting Access Control Services (ACS)
     flags across a Live Update, from the endpoint up to the root port.

  6. Modify the PCI shutdown path to avoid disabling bus mastering on
     preserved devices, thereby allowing preserved devices to perform
     uninterrupted during kexec for Live Update.

  7. Provide comprehensive documentation for the FLB API, device
     tracking mechanisms, and the division of responsibilities between
     the PCI core, drivers, and userspace.

Dependencies
------------

This series is built on top of the next branch of the liveupdate.git
tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

Testing
-------

This series was tested in conjunction with v4 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub. Some
conflict resolution was required to rebase VFIO v4 patchs on top of the
7.2-rc1 base.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v7-with-vfio

Testing was performed using the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were run in a QEMU-based VM environment (using a single
virtio-net PCIe device connected to a root port to exercise bridge
support) and on bare metal using an Intel EMR server with 8x Intel DSA
PCIe devices and 1x NVMe device.

Future Work
-----------

Following this series, we expect to make further improvements to the PCI
core support for Live Update:

  - Allow P2P across Live Update by avoiding resizing or moving
    preserved device BARs and preserving all upstream bridge windows.

  - Support preserving Virtual Functions by preserving SR-IOV
    configuration on PFs and enumerating VFs after Live Update.

Changelog
---------

v7:
 - Use kho_block_set for dynamic device preservation, redefining ABI struct
   pci_ser to use a physical address instead of a fixed-size flexible array
   (Pasha Tatashin)
 - Add kernel-doc comments for pci_liveupdate_scan_bridge_begin() and
   pci_liveupdate_scan_bridge_end() (Pasha Tatashin)
 - Move refcount to patch 1 and adjust KHO ABI versioning progression
   accordingly (Pasha Tatashin)
 - Sphinx documentation improvements: add _luo and _flb labels and use
   acronyms with :ref: links (Pasha Tatashin)
 - Panic on failure to retrieve incoming PCI FLB data to avoid ongoing
   DMA from preserved devices causing memory corruption (Sashiko,
   Samiullah Khawaja)
 - Clarify comment about device-specific ACS quirks in incoming kernel
   (Pranjal Shrivastava)
 - Sort includes alphabetically in liveupdate.c (Pasha Tatashin)

v6: https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
v5: https://lore.kernel.org/linux-pci/20260512184846.119396-1-dmatlack@google.com/
v4: https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (12):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Keep bus numbers constant during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: Refactor matching logic for pci_dev_acs_ops
  PCI: liveupdate: Inherit ACS flags in incoming preserved devices
  PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Freeze preservation status during shutdown
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/liveupdate.rst              |  29 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   5 +
 MAINTAINERS                                   |  15 +
 drivers/pci/Kconfig                           |  15 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 910 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  68 ++
 drivers/pci/pci-driver.c                      |   9 +-
 drivers/pci/pci.c                             |  14 +-
 drivers/pci/pci.h                             |   5 +
 drivers/pci/probe.c                           |  22 +-
 drivers/pci/quirks.c                          |  58 +-
 include/linux/kho/abi/pci.h                   |  59 ++
 include/linux/pci.h                           |   4 +
 include/linux/pci_liveupdate.h                |  77 ++
 17 files changed, 1260 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 1354afac14579ad38279f12d660df961b5f20246
-- 
2.55.0.795.g602f6c329a-goog


