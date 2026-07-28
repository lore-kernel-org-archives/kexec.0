Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8115AC54F57
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=APTOBAxUiPao4l9S27Y+m2/wTZqMb3MMdg2HVgF0ixE=; b=TNvrPDJlwzgRswjIYycriTZhIj
	1ssv5sJnHTeBWEY4fCD16uJ34zWE3dSsvFqMVnazxIQamRFxuV54+xbDdnVm4ZMrXCYYHFTIKzU6c
	4iJ6/X5xBJXoR5zhvm1l0pLU3hIneYRd1TRU+qKoltxWitr1UbxPuz3Pks0gGFUq52iuNVrjlwa20
	WzUqRF/XCSS7e1fQvGO17rA9ZBG9pkH0QJF6isptfOFKMSUMcMh1yoiZafaDn64F5VDoF9hEiyI61
	JK4CvDRcChyuIHb1asuKgn3toGYO4qshq3XSE5svBNx4zQ+CC3SfjvTgbKmvKwtNnU91x42x3SFt6
	XnP7l1Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0H-00000006Npf-0KqR;
	Tue, 28 Jul 2026 22:10:25 +0000
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woq0E-00000006NoV-1foq
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 22:10:23 +0000
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-84a67b16217so494096b3a.3
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276621; x=1785881421; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=APTOBAxUiPao4l9S27Y+m2/wTZqMb3MMdg2HVgF0ixE=;
        b=fmgBckvS971F9muRqQWharz2rIy0E6bEA99OivoiCDuzyG0Z8rjLzacHVP36j8HbM2
         Cht0EDqXlh8dg/NFbLXZmcU5A9jmp/HQmqqnppxOmfri2Muud95G4Ba4ky1w4z/3jSAn
         VOxvooo5VMqXwXE2XQkbdcTNHYurW6fkNKQqpuc1wioBhlXzkUuAWsUMZvCrHt3LDCx1
         +8SrGWfQW6nV+RM3Gqfm0mfM20ujLLqdmjZHtNQCCJmtoAX56TqFouKsjv3iSPo0i11i
         +l16IVu7gbEnpPd104Altk2Fvkoka1aShfYjEQHCDx+CxoDIVTPd9E9vlXbSMUbdynVl
         AKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276621; x=1785881421;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APTOBAxUiPao4l9S27Y+m2/wTZqMb3MMdg2HVgF0ixE=;
        b=sxnPTFCdlJf/2468+MElcE4on7Tn4Ag83HSaE6AP/EfyLf1kdhZZi5wR13LwGyb1+c
         blHYcxZ8uEm2PFuymbvDPtehmU1qfkB/0w+XfMR0ZHjTkae2SMBNU/NREZjjtIFW0u71
         6QrhTZ9T7YZoLGCms7FkxqL6t0pIsYB+NBIkgzcCdN2CuiWPGs7B3DY+PdWisU5gThlz
         OJ6mT7YSURixj3dMNBnda2wxreXPh3a2wsu4G1HJL1d7MM3s8sEToxiJHk8KCKXAKz20
         6F36Rr2+64CfKfPhu3meJHngn17o4g0n8RNxHvjM9/XXKKnEdzpqFLxpxwOUQLhAdujG
         ZWtQ==
X-Gm-Message-State: AOJu0Yz/38JPPyJaB99e5yquX9sOu2X+EskcRIyqH+P2yi18uNqR0U+0
	OtzHU26oa0hOBumJ28IG8GU8c/wMc2K6HCZQRnhL5793IUCgSdUl1aVRJ6PtkLYP55L62C2w9Ol
	T92eFW5tu088O60gbIXkWORTXlMA0CTumZ2dS1q3mwurFDfEtDUN0CbZ+24Lqh3scKYvtUv1xeG
	YrREhSY+S4QgMkUu5tIsx9yaNSiqdBm6Sbnw59kA0tr1AzcF8xFMc=
X-Received: from pgbfm24.prod.google.com ([2002:a05:6a02:4998:b0:c8b:2706:11a7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2192:b0:848:2f84:f433 with SMTP id d2e1a72fcca58-84e93367cf5mr4264411b3a.76.1785276620540;
 Tue, 28 Jul 2026 15:10:20 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:09:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-1-dmatlack@google.com>
Subject: [PATCH v8 00/12] PCI: liveupdate: PCI core support for Live Update
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
X-CRM114-CacheID: sfid-20260728_151022_487716_8DF4BFC5 
X-CRM114-Status: GOOD (  26.18  )
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

NOTE: I am sending v8 out a little earlier than I normally would since I
will be AFK from July 29th (tomorrow) through August 6th and would like
to post the changes made in response to v7 feedback before then. I will
respond to any review feedback on v8 on August 7th or shortly after.

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8

This series introduces initial support in the PCI core for Live Update,
enabling drivers to preserve PCI devices across a kexec-based kernel
update without interrupting the device. This functionality is critical
for minimizing downtime in environments where PCI devices (e.g., those
assigned to VMs via VFIO) must continue operating or maintain state
across a host kernel upgrade.

Specifically, this series allows preserved PCI devices to perform
uninterrupted memory transactions (DMA) targeting system memory
(specifically, preserved memfds) across a Live Update. These devices can
be behind a bridge but must not be VFs. Support for P2P and VF
preservation will be addressed in future series.

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

Merge Plan
----------

I propose we merge this series through liveupdate.git for 2 reasons:

 1. There are some LUO core changes around how FLBs are refcounted in
    the next branch of liveupdate.git that this series depends on.

 2. We had previously agreed that the files covered by the PCI LIVE
    UPDATE maintainer entry would be merged through the liveupdate.git
    tree (which is the majority of this series), so this would be
    following that process.

This plan still needs to be Acked by Bjorn Helgaas as there are some PCI
core changes in this series.

Dependencies
------------

This series is built on top of the next branch of the liveupdate.git
tree for the incoming and outgoing FLB reference counting patches.

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

Testing
-------

This series was tested in conjunction with v5 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8-with-vfio

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

v8:
 - Use __free() and no_free_ptr() in pci_flb_preserve (Pasha)
 - Sort linux/kho_block.h include alphabetically (Pasha)
 - Fix reverse-fir-tree variable ordering (Pasha)
 - Eliminate unnecessary loops to allocate a new pci_dev_ser (me)
 - put() the outgoing FLB refcount now that get() takes a reference (me)
 - Document -ENODEV handling in pci_liveupdate_flb_get_incoming() (Alex)
 - Detect and panic on PCI FLB version mismatches instead of silently
   ignoring (Alex)
 - Panic if drivers violate contract to call pci_liveupdate_finish()
   before LUO drops its reference to the preserved device file (Sami,
   Pasha)
 - Use pci_upstream_bridge() instead of raw dev->bus->self (me)
 - Add a comment about ari_enabled bitfield safety (Sashiko, Pasha)
 - Add drivers/pci/liveupdate.c :internal: kernel-doc to
   Documentation/PCI/liveupdate.rst (Pasha)
 - Collected Reviewed-by tags (Pasha, Bjorn)
 - Remove use of KBUILD_BASENAME (Bjorn)
 - Make pr_debug()s more useful (Bjorn)
 - Refactor bus number preservation logic, variables, and function names
   (Bjorn)
 - Move for_each_pci_dev_in_path() to include/linux/pci.h and drop _end
   parameter (Bjorn) and _start parameter (me)
 - Rename and add kernel-doc comments to functions that adopt ARI
   enablement and ACS flags established by the previous kernel during
   enumeration to make the code more readable (Bjorn)

v7: https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/
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
  PCI: liveupdate: Preserve bus numbers during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: Refactor matching logic for pci_dev_acs_ops
  PCI: liveupdate: Adopt ACS controls in incoming preserved devices
  PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Freeze preservation status during shutdown
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/liveupdate.rst              |  35 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   5 +
 MAINTAINERS                                   |  15 +
 drivers/pci/Kconfig                           |  15 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 939 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  66 ++
 drivers/pci/pci-driver.c                      |   9 +-
 drivers/pci/pci.c                             |  14 +-
 drivers/pci/pci.h                             |   5 +
 drivers/pci/probe.c                           |  23 +-
 drivers/pci/quirks.c                          |  58 +-
 include/linux/kho/abi/pci.h                   |  64 ++
 include/linux/pci.h                           |   7 +
 include/linux/pci_liveupdate.h                |  77 ++
 17 files changed, 1302 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: cecfb90c5f2cc0622b363c2291b69d6cad272897
-- 
2.55.0.487.gaf234c4eb3-goog


