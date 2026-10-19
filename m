Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801C60A380C
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EFdRKhSN;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FUqDl5vU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LkNUC+PMoXZDStaNEegSy7SLi35cqcuQZkVqC98j7D4=; b=EFdRKhSNf6RVh3SG1P5BHi2y7P
	wQioU04BJ+9akNR9nFKFumFaFWcMxzD6HRNmbyQ9tlP4XjX4PZRhE44HvcYzBnmOIkg6FA2MMPaKR
	IyByHU8HQvpN7T5Mx1pzjRj1aAXy8QjbK4tVd5BcTdKBrgw9AKdYwqFrdNnf+gZKLHWqlqUdG5eNn
	Gqjh7YlawhNZ0ktkCUjMi2SVu6iqvJBqVYB32QnHzm3AKQK2Z4GuQcoKo4sFrVFTyGp2C8zR9P4Ux
	12+byPS8i3Z4eQUlJKpp1bUOkLM715BDYU8dW1LTV71kSZH1OeHm0IgMedT7Ax2M1Icl3TxdoRK+r
	xVCHQHqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux6-00000008O3Q-2ZsE;
	Mon, 19 Oct 2026 21:31:28 +0000
Received: from mail-pl1-x645.google.com ([2607:f8b0:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIux0-00000008O0v-2UN0
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 21:31:23 +0000
Received: by mail-pl1-x645.google.com with SMTP id d9443c01a7336-2df375fb9b2so24633195ad.2
        for <kexec@lists.infradead.org>; Mon, 19 Oct 2026 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445481; x=1793050281; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LkNUC+PMoXZDStaNEegSy7SLi35cqcuQZkVqC98j7D4=;
        b=FUqDl5vUGgo7NeZnYLW3x7renmfqPU3GWqmS3XakqDWq6zW0G4sZ11gWiRivdMIT6n
         LS7U5ympeLshA6c5K7jPUFyfDScLPu+eKKNJIlRjp/Fk4LJij8X3VlwayRKSgC2KPLaF
         rokx29a6W/FnixYJCYXySw3HeXmksm05Zj3XenRyMybejfcJDIxyutp8T8GF8JBPFphK
         iZB5tBO4/vuhLCW2Iqoo+IWLgMddDFa5w+jQWWU0Sp6JRqpT8UPmaVPmY3z7lU7D2/ET
         1DvjRf0DyDn2MO1VOKoUvyy9NVogrj5alV3iWdHWZ9YGaCzmkZOUUDouFRm+VpFpcpag
         zDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445481; x=1793050281;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkNUC+PMoXZDStaNEegSy7SLi35cqcuQZkVqC98j7D4=;
        b=jrEvFwaCcEE4yhVeiexZvliGoUDnhzhcbbdZpGLLvPo7mzbM9MAf7wD95xyXFZ/MqO
         rCXbzfhCsPJx8foHuXZtN2bd/W91M945y/RZaPEgeBJW+o20zkFVaLknmfjfW2xL4HNS
         eShdKmPqjRXoorRGn+RoxVY7pi5GQAMHyxL+92lHxwez6XHCZ+Z7/NUYMGA4ILai5FJY
         vtcTT8msSacnLOxZmv7dsFVqG4kh3mD4DJUH8W74cZBlkf9PqYlezj8OLfkv9ocjKsuR
         a/kCEGi8ymFtzoQaPgOD5MKoahOeGX6gzrJQzYoWrBT13hWnfG25dgE9Jb0OrL2mxFcj
         3qCg==
X-Gm-Message-State: AFq9FYKFHLOYfMzFp3EvDBy8f8eRpV+aUervBkCfRTD61nTPzV4gyTAM
	iMzf8hoTtApK+1IHgEyLj4VrjUVmtSS4+aTKi7eJzjhkDmDrJY9zW5EXpkOTQs1BTROo64H7ThD
	SY/Q+XHV/dkFfebAmlLszzBJ5IvkpenyCfpSQNm5G4a00+hG3ZaKvF2QJ7Ur40xcqtJzjxWR1Hd
	D2polSfUEId6eVa2p5hiBmhsp3qosSHX8tyr5uvEPNpGISEVttb0Q=
X-Received: from plcn2.prod.google.com ([2002:a17:902:d2c2:b0:2e5:40ef:ff34])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2c6:b0:2e8:4f3f:60dd with SMTP id d9443c01a7336-2e9a69e9987mr69340785ad.37.1792445480207;
 Mon, 19 Oct 2026 14:31:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:44 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-1-dmatlack@google.com>
Subject: [PATCH 00/10] PCI: liveupdate: Keep preserved devices accessible
 across Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_143122_639337_ABC94DB5 
X-CRM114-Status: GOOD (  23.59  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/p2pdma/v1

This series builds on the PCI core support for Live Update [1] to allow
memory transactions targeting preserved PCI devices to proceed
uninterrupted across a Live Update. The base series allows preserved
devices to perform DMA to system memory across a Live Update, but the
next kernel still sizes, probes, and may reassign the BARs and bridge
windows of preserved devices during enumeration, which disables
decoding or moves address ranges out from under anything that is still
accessing them.

Use cases include:

  - P2PDMA between preserved devices, e.g. between devices assigned to
    the same VM via VFIO.

  - MMIO from Orphaned VMs [2], whose vCPUs keep running in guest mode
    on dedicated CPUs during kexec, and therefore keep accessing the
    BARs of devices assigned to them throughout the Live Update.

To support this, the BAR addresses and bridge windows of preserved
devices must not change across a Live Update, and the next kernel must
not disable decoding or forwarding on preserved devices or on the
bridges above them while enumerating them and assigning resources.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
[2] https://lore.kernel.org/kvm/20260920193650.3373435-1-pasha.tatashin@soleen.com/

Series Overview
---------------

This series implements the following:

  1. Avoid sizing the BARs of incoming preserved devices. Sizing a BAR
     requires disabling decoding. Instead, have the previous kernel
     pass the BAR masks (the values the BARs return when read after
     writing all 1s) and decode the BARs from those (patches 1-2).

  2. Avoid probing which windows incoming preserved bridges implement,
     which temporarily disables the prefetchable window. Instead, add a
     generic mechanism for passing the results of probes that require
     writing to the device, and use it to pass which windows each
     bridge implements (patches 3-4).

  3. Skip programming bridge windows that already contain the values
     being written, so that pci_setup_bridge() does not temporarily
     disable the windows of preserved bridges. This applies to all
     bridges, not only preserved ones (patch 5).

  4. Claim the BARs and bridge windows of incoming preserved devices,
     as programmed by the previous kernel, while scanning and before
     anything sizes or assigns resources, regardless of how the host
     bridge driver sets up resources. Panic if they cannot be claimed,
     since that means something else may be decoding the same address
     range (patch 6).

  5. Prevent the PCI core from assigning, releasing, or realigning the
     resources of incoming preserved devices (patches 7-9).

  6. Avoid enabling INTx on incoming preserved devices, both while
     probing whether INTx masking works and when the device is enabled
     (patch 10).

All new behavior applies only to incoming preserved devices, i.e. only
after a Live Update and only until pci_liveupdate_finish(), except for
patch 5, which avoids redundant writes for all bridges.

ABI Changes
-----------

This series uses the optional feature flags added to struct pci_ser in
v10 of the base series to append new fields to struct pci_dev_ser:

  - PCI_SER_OPTIONAL_BAR_MASKS: @bar_masks and @rom_mask.

  - PCI_SER_OPTIONAL_PROBED: @probed_supported and @probed, a bitmask
    of probe results (which windows a bridge implements, and whether
    INTx masking is broken).

The ABI only contains hardware state (register values and the results
of probing hardware), not kernel-internal state such as IORESOURCE_*
flags. If the previous kernel did not pass a field, the next kernel
falls back to sizing or probing the device as before.

Merge Plan
----------

This series applies on top of v10 of the PCI core support for Live
Update series [1], which is targeting Linux 7.5. This series is
targeting Linux 7.6, or 7.5 if feasible.

Both series will be merged through liveupdate.git, matching the
agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

Testing
-------

This series was tested in conjunction with v5 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/p2pdma/v1-with-vfio

Testing was performed using vfio_pci_liveupdate_kexec_test with the igb
selftest driver, which keeps the device performing DMA while kexec
happens. QEMU traced every PCI config write, and each run checked that
the next kernel did not write to the BAR, ROM, bridge window, or bus
number registers of the preserved device or any bridge upstream of it,
did not change their decode or Bus Master Enable bits, and did not
enable INTx on them, and that their BARs and windows had the same
values before and after kexec. The following configurations were
tested:

  - x86 (q35): igb behind a root port.

  - x86 (q35): igb behind a PCIe switch (root port, upstream port,
    downstream port), with a non-preserved device on another downstream
    port of the same switch.

  - arm64 (virt, SMMUv3, generic ECAM host bridge): igb behind a root
    port. This exercises the path where bridge windows are not read
    from hardware during scanning.

Future Work
-----------

Please see the PCI core Live Update Roadmap:

  https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/


David Matlack (10):
  PCI: Factor out BAR sizing from pci_read_bases()
  PCI: liveupdate: Avoid sizing BARs of incoming devices
  PCI: Factor out bridge window probing from pci_read_bridge_windows()
  PCI: liveupdate: Avoid probing windows of incoming bridges
  PCI: Skip programming bridge windows that are already programmed
  PCI: liveupdate: Claim resources of incoming devices during scanning
  PCI: liveupdate: Never assign resources of incoming devices
  PCI: liveupdate: Prevent releasing resource windows of incoming
    bridges
  PCI: liveupdate: Don't realign resources of incoming devices
  PCI: liveupdate: Avoid enabling INTx on incoming devices

 drivers/pci/liveupdate.c    | 363 +++++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h    |  26 +++
 drivers/pci/pci.c           |  18 ++
 drivers/pci/probe.c         | 110 ++++++++---
 drivers/pci/setup-bus.c     |  62 ++++--
 include/linux/kho/abi/pci.h |  52 +++++-
 6 files changed, 589 insertions(+), 42 deletions(-)


base-commit: 312200e9211ede3f9a03cc17d094805e06e4674e
-- 
2.56.0.212.g129ede20d9-goog


