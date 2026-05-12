Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DB6CD343F
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EyguY5SyRRz30bfysN8DgGpUMffGCDjWMOlfWBdfAYk=; b=N9tPNSXbgRJ3LOfFVlvBUUvRdq
	5yCc83wlx/djH+MDCtaflciNIJYBT2E4GD7va/oY21saaNz9bIWxTHLj7WMlNUQX4nZB6AlY1nEle
	pkwtbcGm6De1qyy3PiPYIA1wMX0bHWMOPf9/qhQcN82YH2oUR8TYiDLIiA8XBE0Cd7EB0LBIz2Mi7
	azDlbnVDV8VZ7lommFlOlHr47wNnxKAhSjuStu60+6udZ4xFZnu/v2R9SviuRCAqdGx9z71x7sbzj
	LLH9KTJqmOQ3mV7OMW2uOlVNdP52Vb8f0qWjqvGpL/WT5GWpNEGQS4UZQBkdLCHQab7Emo89fYRFr
	9E0CiANQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA2-000000008bX-3e3r;
	Tue, 12 May 2026 18:48:54 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMsA0-000000008ap-41gq
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 18:48:54 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-83eefe4867eso635411b3a.1
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611731; x=1779216531; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EyguY5SyRRz30bfysN8DgGpUMffGCDjWMOlfWBdfAYk=;
        b=cYFEwVksNQnzkgBHpU/Bv2SUi+dzzisPH64DRS8dQMAe4sbfD83zCZoRxiaFlL0oK8
         96Yn2AU1giZ7Rdl6fcEn4rjprjlUJ1yhZdsd3hQIxZvoS3jfmQG0AXkiJ2TLuA0hljZ/
         xuoCtvyK6kJ1p2J/a9mzoVOX/qrwAXyW2EpG/r7MGIel3SYWmqqqGNBYdHq9pZfrp5mV
         GMTKZQcLsKMzK6u4KLS8qfN1BPjZvsMGlLwj9qVmw+gYBsx8xJrE78wHOT7lE3yP+AcN
         WLtqYCN+Eh30YQb2stbjHodPV8O8Wsuj4J11ere1/5b//T4wMkzQG4OCE/CI7GjwHq/I
         jjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611731; x=1779216531;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyguY5SyRRz30bfysN8DgGpUMffGCDjWMOlfWBdfAYk=;
        b=TOwcUk8EzZ4EX008VzsOHKKmNjyZwYHMQ2EO97N3dohw5K0OXKN2P0zDtwv5i4DT6e
         Ik2ABD1GRJ4y6gW+7LLlgGkpcReIDAJ5vGHOiGplpR5LRupICKkntZUac0eOGeq1Kop/
         jcF6hl3fnuwndZs8uvhEI2cL63jm8PCt4lZaf33/kdBwr/xA9GXIsvoNnlzFs9nLMZV/
         QlxGthtxRea9BNtQcNnx3a40MOcp2LAugIjIsBUUh1goU/0UnsGUCbH/o1VjI+r4NmZG
         4Kf2GcMegz+tOz3DZXpgHmcg5AgYtQJpGn55T2UYKPWB5p9wdEGdNFuYD0f1pmtQE5b1
         bjkw==
X-Gm-Message-State: AOJu0Yw8HjKHQa9Btgr/Xb7SWl8aV/7gLXVLOxXuDobbaHGp81mXv18S
	rG3g34Yyt1Pms4tlVHnndIkpkwLBvxAOxKkEBafYrSTpw7lIGrXBMzEdPpwSVdpGiwNpnxxcHiN
	+IcG//oqzJMCiptSXUmKiYcgi/eZgYqvG1b20XOu7pX8DCFN0qlu0V0TLQtl+03LezRvpNtBNqJ
	dgI7U4O9fq9yEcluZEB6muXU5evZVaANkDNomzQCudRkXfJ2E55IY=
X-Received: from pfblu4.prod.google.com ([2002:a05:6a00:7484:b0:82f:7d56:a149])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1784:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-83eeb85bbafmr4618299b3a.0.1778611731139;
 Tue, 12 May 2026 11:48:51 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-1-dmatlack@google.com>
Subject: [PATCH v5 00/11] PCI: liveupdate: PCI core support for Live Update
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
X-CRM114-CacheID: sfid-20260512_114853_012863_6C570501 
X-CRM114-Status: GOOD (  21.16  )
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

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v5

This patch series introduces the initial support in the PCI core for
Live Update, enabling drivers to preserve PCI devices across a
kexec-based kernel update without interrupting the device. This
functionality is critical for minimizing downtime in environments where
PCI devices (e.g., those assigned to VMs via VFIO) must continue
operating or maintain state across a host kernel upgrade.

Specifically, this patch series allows preserved PCI devices to perform
memory transactions to/from system memory (DMA) uninterrupted across a
Live Update. The devices can be behind a bridge, but must not be a VF.
Support for P2P and preserving VFs will come in future series.

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

  4. Guarantee that preserved devices can be identified by the same
     RequesterID (bus, device, function) for as long as they are
     preserved by always inheriting secondary and subordinate bus
     numbers and ARI Forwarding Enable on bridges with preserved
     downstream endpoints.

  5. Guarantee the memory transactions to/from preserved devices are
     routed the same way by inheriting Access Control Services (ACS)
     flags across a Live Update.

  6. Modify the PCI shutdown path to avoid disabling bus mastering on
     preserved devices and their upstream bridges, allowing memory
     transactions to continue uninterrupted.

  7. Provide comprehensive documentation for the FLB API, device
     tracking mechanisms, and the division of responsibilities between
     the PCI core, drivers, and userspace.

Dependencies
------------

This series is built on top of the next branch of liveupdate.git tree
which has 2 commits to enable refcounting the incoming FLB:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

Testing
-------

This series was tested in conjunction with v4 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

The full set of patches that I used for testing can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v5-with-vfio

The full set of patches was tested using the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were ran in ran in a QEMU-based VM environment, using a
single virtio-net PCIe device connected to a root port (to exercise the
bridge support in this series), and in a baremetal environment on an
Intel EMR server, using 8x Intel DSA PCIe devices (each on a host
bridge) and 1x NVMe device connected to a root port.

Future Work
-----------

After this series we expect to make further improvements to the PCI core
support for Live Update.

  - Allow P2P across Live Update by avoiding sizing or moving preserved
    device BARs and preserving all upstream bridge windows.

  - Support preserving Virtual Functions, by preserving SR-IOV
    configuration on PFs and enumerating VFs after Live Update.

Changelog
---------

v5:
 - Update PCI LIVE UPDATE entry in MAINTAINERS to use liveupdate.git,
   add kexec@ mailing list, and drop Bjorn (Pasha, Bjorn, Pratyush)
 - Create separate headers for Live Update definitions to avoid future
   patch conflicts (me)
 - Add kernel doc for public (Driver) API (me)
 - Rename reserved field to padding (Vipin)
 - Reorder checks outside of mutex where possible (Jacob)
 - Clarify refcount in struct pci_dev_ser in kernel-doc (Sami)
 - Require CONFIG_64BIT to avoid overflowing xarray key (Sashiko)
 - Various spelling and grammar fixes (Bjorn)
 - Ensure incoming and outgoing devices do not have their bus numbers
   changed during manual rescans via sysfs (Jacob)
 - Fix refcount dropping for upstream bridges during finish (Sashiko)
 - Disallow devices with PCI_DEV_FLAGS_ACS_ENABLED_QUIRK to simplify
   ACS inheritence across Live Update (Sashiko)
 - Fix ACS re-enablement via pci_restore_state() (Sashiko)
 - Drop commit that requires singleton iommu groups (me, Sami)
 - Add per-device lock to protect Live Update fields (Sami, Sashiko)

v4: https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (11):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Keep bus numbers constant during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
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
 drivers/pci/Kconfig                           |  14 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 807 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  66 ++
 drivers/pci/pci-driver.c                      |  33 +-
 drivers/pci/pci.c                             |  13 +-
 drivers/pci/probe.c                           |  29 +-
 include/linux/kho/abi/pci.h                   |  64 ++
 include/linux/pci.h                           |   4 +
 include/linux/pci_liveupdate.h                |  75 ++
 15 files changed, 1140 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
-- 
2.54.0.563.g4f69b47b94-goog


