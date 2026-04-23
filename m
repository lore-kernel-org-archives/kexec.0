Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4B6FDEE4E
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=; b=3AnAYflFo9t1Socg8D4SMKnQ4U
	zjnsidov5hCbj/jKaCepdaTTqogc4CxAJPDi6jB1Lg+hBBkrjWwD8jkQHr0vulgkyXApsBXhVk2fL
	lQlm8BqvLzZUSavjfZ9lZhMEqeuVIwGXMvcJ+LR27kVNZe/WW1rsVghi4ELT0jRbTfUTXMK64KymW
	TMeKMxKwtJ/9kWcEYIvzo/8QrO2rRCZQ0hdwOyD8GgttgfsQSwkdPqg1TZMUmBvhqgafQ9dYwy6JR
	4HWh+4Dv07Q75yNRPGezo2QUJOXZDh7SbK5It5Mo8ukGj0doko0fZl65kWdfdB1qTAHiiAZrwIGNv
	OKImxK4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1W7-0000000CL1f-1CMW;
	Thu, 23 Apr 2026 21:23:23 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1W5-0000000CL0u-1Rl1
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:22 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82f70ae35c0so3661443b3a.2
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979400; x=1777584200; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=erS9T/412Vb9FFsocWsf4NrBwHGD6rTRlkkSWc/DQsGbS+typzFeGvZ/QcqevRj3pz
         TNKYnDHhoAJvapmHCs8CraLUwM4/MKquorfe9PivEzB8wuZAsFOUaoz90QoqhUH73ehF
         96JOVFGVdkGxXrGNay9zVpz+VENUFzrsmxwaShsQ6rmNoXmj+Bq6W3EMkNksNRNlw8Wt
         ohrMKs5+7QrVc6uHcdF+2j4UobUd9MT7EiclxE3L/KBxv8VythZiL0yKwWQiUFTKcoN2
         eXx1UF55hka/r2+OL6dbUzCUPsExCHAVylK574+rKAHD7vbBLVvpvQhNVlKPPJVEKjKv
         UCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979400; x=1777584200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kl+pv05082o4iUYPTAspfzDZexWtIImSBuw1JtCkgoE=;
        b=X2Zh7EGy6lnrMnhsgT4VGi0Ch1Ak24BaPL2w0JwRBfcKoYYptdY89bWkdMnwfI4Va0
         Vj4dmJc+KhXl4tfX2lTM6IiITmB9kPcN6DmdLIPxloa/APuU1siZrQeGb7zJbHmRXtg8
         B+GIKSbfrCK9du3q966oWESC/61Szrl3ylyzcjOu3BBrSn5tedqLnXR/Ci8b2mJM782P
         qfPcHGdKTP3D6NRwgc3veGN2WEQeuyJaDXx1rLqOO5BFPiUf9ggBNBSfKHeX+8zTTCMr
         ChCEt8su+cotKaWjZnNjF+QZQtCegvhR26WqYrlH2pskdXTLOdNzIjXOArkY6pPQ69aE
         MXIQ==
X-Forwarded-Encrypted: i=1; AFNElJ96pF8YopZO8FIS9oTFDCSVhxBRwrAfEgQz8Rr23pn4BAK+t0teBmWXc7PeyfoEotyUoC+c2w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyd3EIiaP7aRbn4Lpv9l5vOM71BuKUoNUxGRunp0Tv/GcmKuXJh
	zXO2g9chnP0X0Co/QIAuPBQN1BYZEHl+bdaRzltK3SJIq+mzfKTWvtkV0JZUm9FVC7zJWVI1E1S
	fJe2xX3jZj3MDNg==
X-Received: from pfhx15.prod.google.com ([2002:a05:6a00:188f:b0:82f:3c29:a283])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd0a:b0:82f:74b2:7fba with SMTP id d2e1a72fcca58-82f8c7dd0d9mr31341067b3a.4.1776979399901;
 Thu, 23 Apr 2026 14:23:19 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:04 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-1-dmatlack@google.com>
Subject: [PATCH v4 00/11] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_142321_392095_5AEF5B73 
X-CRM114-Status: GOOD (  25.09  )
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


