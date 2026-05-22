Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C933CD5BB0
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lAtyCPo6ylTfae9lzbtctQSa6ySROp5Ur4512Ppcl24=; b=k+faooqZgILjBtP4GpCEWy7o21
	A/h/WnJSt8pHa08KNl+/zPlfF512Hnlscolhni4fS+CCocN+veXKOWXq6jp0dBnzYuZ4sLqmuIGDC
	iy7CA1BLgGIwMFyFpsglD0fF2Oh0cd4b/NOgND+H0MoROxv6UMV10iyu0LT3YRbTgtxo09RxtbpDF
	WXxQ4GU2mmysa8pRa+4iUaSF3BvvM2QX2SgMVBLLqZAq2yCXUnOvYp2f7uMBPwDc72NGT+kjJS7Q7
	6yJMmrLfNG/xVjDHXp5Fer5TG9gBJvwT2z7kSlMH3/y2sN108BdpPG7OZE4XIdVPdJYfl65NzRE5/
	nNMhYJLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPq-0000000Brpc-0BXf;
	Fri, 22 May 2026 20:24:18 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQWPm-0000000Brni-2Sc6
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 20:24:16 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c8510f91ce8so1482396a12.2
        for <kexec@lists.infradead.org>; Fri, 22 May 2026 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779481452; x=1780086252; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lAtyCPo6ylTfae9lzbtctQSa6ySROp5Ur4512Ppcl24=;
        b=Xcddhy5fzhJhAEk9Y8Ln62d3lFO1vhsPKCICAYuvB6OAFGNOWAX08oVFgaBQr18jih
         GdaBhL65Qfp3dHqXJ5ulgkBZpB9Zcb7+tOPN+v+KCLbMqOSPwVbdhy1CiVtjYKzhqXpA
         a4zDSqTdwhWtmRW/tHVrFq88npx3ef8lbBlEs0XdJnismTMZwHgwVn1uLHIpPHQXSY8I
         eFYsJzPVj3rtJZH0F2Vc7i3ysJgwC+r6XIr4Hdie1+KTZ5My6yhqfikmJ7ztA3e0l30B
         f0BtHGDv5DU67Gcn8mQ+hY3q7Mu073n/XvpFM5KwAcXxqzvjHQiCAU1y/YBFW8hMRG7V
         HRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481452; x=1780086252;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAtyCPo6ylTfae9lzbtctQSa6ySROp5Ur4512Ppcl24=;
        b=O7AKP/6s/7DWdTgdVwEmQy6xp//xELbBUYoSrkR1LyrayfPOWuK5jvUVdqmFkwMuvY
         r4euFCROQFihSrv/95ch9LGDevFCuC/Hltjv+qZtqJ4vMSJ580kv7Gzl5yEV4sj6e5ic
         tXVj5XLKceQlM1GyXJT6m6hSSkF64MkYAzMEBVHLvrFkE6BjeP0AXteB9zwWdk6Z6fBT
         Jx/qQ+X8QAyPJFbM0+VDAxmQo6+SSdG+lEQUkYPR2IVarnqkX5QBTpmABcsbIwShcP0w
         azCRgG/TYY7jgsVLdrTjw5Rf94hwlxE4f9eJ1gz+ueae1F4ISrk0yHh3XNA9vt713MVa
         26FA==
X-Gm-Message-State: AOJu0Ywc9R332pwr6qtnbiaP8A7ow/EMSOOLieJknBRFruQ5TQBoPB4T
	MR1HvTFIvz9K1P8RP4W9jJRP/Muf8t5b1tPC+2q+z3EZjWnqK+UtvFi3t0GF9ZGxLtPmpBBbhnz
	6BGc7K6ReNK00DO5VCwQKAeF/OFwkii6ZrrXMdFcnhaVYFi3jGoBWWrCJOatNkTwaytkWhsS66Q
	GbucgfVYHQlNbX5r/EvOIgFArUWDSsNenhKW8TGUjSZqNTOEc43MQ=
X-Received: from pggh19.prod.google.com ([2002:a63:c013:0:b0:c74:1130:c2ea])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918a:b0:3aa:c93b:6266 with SMTP id adf61e73a8af0-3b328c98e37mr5376986637.19.1779481452060;
 Fri, 22 May 2026 13:24:12 -0700 (PDT)
Date: Fri, 22 May 2026 20:23:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522202410.3104264-1-dmatlack@google.com>
Subject: [PATCH v6 00/12] PCI: liveupdate: PCI core support for Live Update
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
X-CRM114-CacheID: sfid-20260522_132414_663166_4DE74C9D 
X-CRM114-Status: GOOD (  23.15  )
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

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v6

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

  2. Add APIs for drivers to register outgoing-preserved devices for
     preservation and for the PCI core to identify incoming-preserved
     devices during enumeration.

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
tree, which includes two commits to enable refcounting the incoming FLB:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

Testing
-------

This series was tested in conjunction with v4 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v6-with-vfio

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

v6:
 - Fix truncated domain during bit shift in pci_ser_xa_key() (Sashiko)
 - Replace complex and buggy per-device locks and outgoing mutex with a
   single rwsem (me)
 - Use a loop instead of recursion to walk upstream bridges (Sashiko)
 - Correctly account for all devices that need quirks to enable ACS
   instead of relying on PCI_DEV_FLAGS_ACS_ENABLED_QUIRK. This required
   adding a patch to refactor pci_dev_acs_ops in quirks.c (Sashiko)
 - Fix circular locking dependency between pci_rescan_remove_lock and
   pci_liveupdate_flb.private->incoming.lock (me)
 - Convert several functions to return 0/error instead of true/false.
 - Bump PCI_LUO_FLB_COMPATIBLE in the patch that changes the semantics
   of pci_dev_ser.refcount (me)
 - Convert was_prepared and frozen from bitfields to bools to avoid
   KCSAN warnings (Sashiko)
 - Drop experimental verbiage from Kconfig and Documentation (me)
 - Ensure that bridges inherit bus numbers during scanning if their
   parent bridge also inherits bus numbers. Otherwise, a race between a
   scan and pci_liveupdate_finish() could result in a bridge assigning a
   bus window larger than its parent while its parent is forced to
   inherit bus numbers (i.e., cannot expand) (me)
 - Free struct pci_ser if an error occurs during pci_flb_retrieve()
   (Sashiko)
 - Detect duplicate entries in incoming FLB when constructing xarray and
   return an error instead of silently ignoring (me)
 - Add a wrapper function for fetching from the outgoing FLB (me)
 - Grammatical and spelling fixes (Bjorn)
 - Don't bother forcing bus inheritance when only outgoing devices are
   preserved. If a scan causes a bus number conflict, that is a general
   PCI core bug; it is not specific to Live Update (me)
 - Convert bitfields in struct pci_liveupdate to bools to avoid data
   races (me)

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
 Documentation/core-api/liveupdate.rst         |   1 +
 MAINTAINERS                                   |  12 +
 drivers/pci/Kconfig                           |  15 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 850 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  68 ++
 drivers/pci/pci-driver.c                      |   9 +-
 drivers/pci/pci.c                             |  13 +-
 drivers/pci/pci.h                             |   5 +
 drivers/pci/probe.c                           |  22 +-
 drivers/pci/quirks.c                          |  57 +-
 include/linux/kho/abi/pci.h                   |  65 ++
 include/linux/pci.h                           |   4 +
 include/linux/pci_liveupdate.h                |  77 ++
 17 files changed, 1197 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
-- 
2.54.0.746.g67dd491aae-goog


