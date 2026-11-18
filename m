Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FD606A334
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 22:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2jsUF8AM;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JIlrdET1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=pk/I3wSfbne6vIr6Mw8kkpXlHwTn38hslTEt3tHnxeE=; b=2jsUF8AMsDR4ZtbVCOi8iabUzg
	iYez4glmERdNhq1wS5mGCWlKUOlqDVmpmgl+nJElLEYBCvbhan0DdXAVWJhjeyj2TPKlQJgaeX+dB
	cdjsiDc0vuv8h8jIyGKsIedElRykvK+e0ABoiwo40HFaC9S7+iXRMIlkCT8NpF3H0UYwY67jxWboC
	t8usFR3hXiF4T6SOvCNnhYbAUmk8qhtFp2NPCZNrrBSUfHl/k3WRUUlttfQmuv5afFzUVTxf7c/gg
	FX0WihL3MY6mvDFbCSsttnHx1nQ/FTc6nBws+J+jBQSV7RqMntlWIHCXF+giwOyUybE0FTFMOfuAO
	UipeRc1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToHA-0000000APqr-0tTt;
	Wed, 18 Nov 2026 22:37:12 +0000
Received: from mail-oa1-x46.google.com ([2001:4860:4864:20::46])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xToH7-0000000APqA-2YgO
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 22:37:11 +0000
Received: by mail-oa1-x46.google.com with SMTP id 586e51a60fabf-49dd26d6f07so1460935fac.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 14:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041428; x=1795646228; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pk/I3wSfbne6vIr6Mw8kkpXlHwTn38hslTEt3tHnxeE=;
        b=JIlrdET1osZ5Ly5uS0oVJm+XObthmhv8QnbsLpcEWLW8lG+yvlRh0rBdhdfY34KGCM
         whpQKZ5Vfyd+dnt+VZc+b5zPhimsGWO+OROXU5KM8Jwz5dz8FuyoWr0q3mWcGcgzzEmL
         G+wGRas+D5wk9Y2zFN+xqjYF8X+mOPSBjrDI0+orLEqH04fld6PbRD6KsMy6ioahjDsc
         R26mtfOZUuuU3Hi6PDlj6mRvBGx8B023WrT1rA5vXRgcFFarCV6XHYuY8hTh8W65sk90
         P6k+hewW3J4J1PKDDlNf3lKU+McUKrHGkwZQW8cIdrOlabk+SbXTP5h8OyqpEIa59Nub
         geFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041428; x=1795646228;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pk/I3wSfbne6vIr6Mw8kkpXlHwTn38hslTEt3tHnxeE=;
        b=CvFubFog4cjPslT+C8F7FOn+1ZO5cbfXSC5Nwaf9NN1oUNh0p15tQNuOHI6U9Ohu9A
         ppYW/U1fIOf2+uZsU1ulnEFXPdYyHBxHNZeoBskIZs1/TnMjynnH51dmimBbpRiDeUpM
         VbQ+S4n5v2Xuo6ehEvqvIVTJQ3p6OdCU/0ibpuMDtKsRE47/TXnlV3geDCwRKG2qMM6E
         0Z1YR00B2ogDXLBCBByzjm2b01/7wuiM/ucpGQwxCwDTp4vKk+B0cM5q3lAXMhiBtKEL
         udnRoYR9YTtxwj46RuHgDw88+Vzs2G0uSOxKRknJqdLq1eT6ajEW95iPWIR5i/UndbYK
         DXgw==
X-Gm-Message-State: APuU4Z+4bN4Bt+k2StkO+Glw64KJ+VR5zzeYOxwi/sjio2FPB3mvzwXt
	HP7Ws5DQJ9RpFcdjkQEmC4f257cRQIkjK+ezFU1oWGHYYKcgKdYfNHJeCKyjdKXQgA+mZlc3/EQ
	X3hdCkggXL3r6AojjkaaJHN5SCkcFV9hcfJJkxFekAgCOn2HibsChnymfN+lYUIjHQ/pMtshXPb
	5oHpNM2w88BN9iRC33CZ7fohsr5FO7I7KLX/U0qyCq6ITDM1f+gGY=
X-Received: from ilbdx7-n2.prod.google.com ([2002:a05:6e02:4207:20b0:549:b431:8d75])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:16a8:b0:567:e971:200c with SMTP id 5614622812f47-57741228693mr4525440b6e.41.1795041427354;
 Wed, 18 Nov 2026 14:37:07 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:51 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-1-dmatlack@google.com>
Subject: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_143709_693248_89C52641 
X-CRM114-Status: GOOD (  23.65  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11

This series introduces support in the PCI core for Live Update, enabling
drivers to preserve PCI devices across a kexec-based kernel update
without interrupting the device. This lets devices, such as ones
assigned to VMs through VFIO, keep running across a host kernel upgrade.

Preserved devices can keep doing DMA to system memory throughout the
Live Update. Devices may be behind bridges, but VFs, devices that need
device-specific ACS quirks, and CardBus are not supported. Support for
P2P and VF preservation will be addressed in future series.

Series Overview
---------------

This series implements the following to support PCI device preservation
across Live Update:

  1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
     PCI-specific state (struct pci_ser) across Live Update using Kexec
     Handover (KHO).

  2. Add APIs for drivers to register devices for preservation
     (outgoing) and for the PCI core to identify preserved devices
     during enumeration (incoming).

  3. Automatically preserve all upstream bridges for any preserved
     endpoint. Use reference counting to ensure bridges remain preserved
     as long as any downstream device is preserved.

  4. Keep the Requester ID (bus, device, function) of preserved devices
     stable for the duration of their preservation by adopting the
     secondary bus numbers, subordinate bus numbers, and ARI Forwarding
     Enable of preserved bridges. After a Live Update, pci=assign-busses
     and pci=noari do not override this adopted state.

  5. Save and restore the ACS Control register and Egress Control Vector
     across resets for all devices (patch 8), so that adopted ACS
     controls survive a reset.

  6. Keep memory transactions to/from preserved devices routed
     consistently by adopting Access Control Services (ACS) controls
     across a Live Update, from the endpoint up to the root port.

  7. Freeze each device's preservation status when it is shut down, and
     avoid disabling bus mastering on preserved devices in the PCI
     shutdown path, so preserved devices can keep doing DMA during
     kexec.

  8. Add Documentation/PCI/liveupdate.rst, built from the kernel-doc in
     drivers/pci/liveupdate.c and include/linux/kho/abi/pci.h, describing
     the FLB API, device tracking, and the division of responsibilities
     between the PCI core, drivers, and userspace.

Merge Plan
----------

This series is intended to go through liveupdate.git, the tree listed in
the new PCI LIVE UPDATE MAINTAINERS entry.

v10 and a follow-up patch were applied to the lu-pci-preservation branch
of liveupdate.git. This version is meant to replace them, and applies on
v7.4-rc1, the base of that branch.

Testing
-------

VFIO
~~~~

This series was tested with v5 of the vfio-pci Live Update series,
rebased onto this series and the luo-internal-api branch of
liveupdate.git (which the VFIO series depends on):

  https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11-with-vfio

Testing was performed using the VFIO selftests, including the new Live
Update selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

The tests were run in a QEMU-based VM environment (using an emulated
Intel IGB device connected to a PCIe Root Port to exercise bridge
support) and on bare metal using an Intel Emerald Rapids server with 8x
Intel DSA PCIe devices and 1x NVMe device, all of which were preserved
across a Live Update by vfio_pci_liveupdate_kexec_test.

PCI Selftests
~~~~~~~~~~~~~

This series was also tested with a new set of PCI Live Update
selftests:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v11-with-selftests

Each test preserves a PCI device across a Live Update in a QEMU VM and
checks that the PCI core keeps the device, and every bridge above it,
running: same BDF and bus numbers, Bus Master Enable left set, ARI
Forwarding Enable and ACS controls adopted from the previous kernel, and
no PCI config writes that disrupt the device during the Live Update. The
tests cover endpoints on the root bus, below a Root Port, below a
switch, and below two levels of switches, as well as booting the next
kernel with command lines that would otherwise renumber buses or change
ARI and ACS. All tests pass on x86_64 (q35) and arm64 (virt), except
for the pci=assign-busses test, which is skipped on arm64 (the option is
x86-only).

Future Work
-----------

Please see the PCI core Live Update Roadmap:

  https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/

Changelog
---------

v11:
 - Rebase onto v7.4-rc1, the base of lu-pci-preservation in
   liveupdate.git
 - Fold in "PCI: liveupdate: Factor out pci_dev_ser allocation and
   release", which was posted and applied as a follow-up to v10 [1]:
   introduce the struct pci_dev_ser allocation and release helpers in
   "Track outgoing preserved PCI devices", and split
   pci_liveupdate_preserve_device() into separate paths for new and
   already-preserved devices in "Auto-preserve upstream bridges across
   Live Update" (suggested by Bjorn; the follow-up was reviewed and
   tested by Chris Down)
 - Don't allocate an ACS save buffer for devices that rely on
   device-specific ACS quirks (Alex)
 - Adopt the ACS controls of preserved devices even if they match a
   device-specific ACS quirk, logging a warning instead of programming
   ACS from scratch, and panic if a preserved device has no ACS save
   buffer (Alex)
 - Clean up commit messages, comments and documentation: fix
   inaccuracies, remove filler and duplicated text, document that
   pci=noari does not override adopted ARI Forwarding Enable, and note
   in the documentation that devices cannot be preserved or unpreserved
   once they are shut down
 - Panic if any outgoing device was never unpreserved when the outgoing
   FLB is freed, instead of leaving dangling dev->liveupdate.outgoing
   pointers, and share the check with the incoming side (Sashiko)

[1] https://lore.kernel.org/linux-pci/20261109174009.735309-1-dmatlack@google.com/

v10: https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
v9: https://lore.kernel.org/linux-pci/20260918200640.887030-1-dmatlack@google.com/
v8: https://lore.kernel.org/linux-pci/20260728221007.2098560-1-dmatlack@google.com/
v7: https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/
v6: https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
v5: https://lore.kernel.org/linux-pci/20260512184846.119396-1-dmatlack@google.com/
v4: https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (13):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: liveupdate: Preserve bus numbers during Live Update
  PCI: Refactor matching logic for pci_dev_acs_ops
  PCI: Save and restore the ACS Control register and Egress Control
    Vector
  PCI: liveupdate: Adopt ACS controls in incoming preserved devices
  PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Freeze preservation status during shutdown
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |    1 +
 Documentation/PCI/liveupdate.rst              |   35 +
 .../admin-guide/kernel-parameters.txt         |   11 +-
 Documentation/core-api/liveupdate.rst         |    5 +
 MAINTAINERS                                   |   15 +
 drivers/pci/Kconfig                           |   14 +
 drivers/pci/Makefile                          |    1 +
 drivers/pci/liveupdate.c                      | 1011 +++++++++++++++++
 drivers/pci/liveupdate.h                      |   72 ++
 drivers/pci/pci-driver.c                      |    8 +-
 drivers/pci/pci.c                             |  169 ++-
 drivers/pci/pci.h                             |    5 +
 drivers/pci/probe.c                           |   16 +-
 drivers/pci/quirks.c                          |   58 +-
 include/linux/kho/abi/pci.h                   |   96 ++
 include/linux/pci.h                           |    7 +
 include/linux/pci_liveupdate.h                |   72 ++
 17 files changed, 1556 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.1.703.gf848ed807c-goog


