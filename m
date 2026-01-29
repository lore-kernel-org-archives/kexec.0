Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAFCD73E8E
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F7w0g/nR8ml7KkZqbualmYDfY5KbOVPfKhgZAMsaNL0=; b=mEyOP8KZ9ETNzsjiF+l3b8ZrTr
	nExhyHcXcl3nN3NDmj8IcFGHvKbFsfFZoJfwLk3Y3VP3tHaLHltacImm8E+TQc75jIdlhHHIHpEbv
	isBzBh+5ZtGEoJuOfaXApgiIcpDNGJdNzOhBgqLPjIdh3UUelDMAt05IKsu4lteBtCSY4x4z7X2Y6
	2qMvGM2rNezqT361D419fsWO1cXJIcQfahbh6QHbZX0k/X/ZdJg240Fa3U0jNCCljlkzT/cYWgwzf
	Wz92E6sl6poGDWB7o7GVmN5+h4M6rurvricPX4CK4ZbPe0JW2xp/EzkvB3pmUs9/p0p1gYSsD8C9b
	Re9FULvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWL-00000000fBC-14Ja;
	Thu, 29 Jan 2026 21:25:45 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWF-00000000fAc-29KU
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:41 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso2888625a91.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721938; x=1770326738; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7w0g/nR8ml7KkZqbualmYDfY5KbOVPfKhgZAMsaNL0=;
        b=AyYf3ySTekew6/D4nOcyruUkeV1u9GiCHcoB3HzaT3BAgJGs2FOOxd4HXrA90q9EN6
         E0bqaSFPvEx0EiHWcT/JZwIeIsyqUpF9COoiJjNvZMm7mYLHM4ER5FFfys00Mt7gugJq
         Y8zK9/UgnnX4LB24ycIJrytbZo4XiyV9Qn1D6UILgCu70unrr2bj8eq2ZjGoWKyn5MA/
         0fR9iJcC8sRX+sd2cce7+DxeV8h8Vgnab/qqkdzCARw+x1kXNK+AwKy0e4yMO2WEQ64t
         jRsG6924dGxqcMOiTXHXuxReKcqkx1A1ilk24g/xbLeJffa/pM8oF9qoPWR9Mvex99k2
         7rpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721938; x=1770326738;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F7w0g/nR8ml7KkZqbualmYDfY5KbOVPfKhgZAMsaNL0=;
        b=ptRWD9ouslvRPWUcHceD3r2Zt1I2R6MfCNmqJ9HCupVYFfyHNqvRGcIlW7ev6ZsGen
         WvYWsZDr+Z06A9xZktrETsjtN01S8Zux7Pc5t8eirwn73EUX9jiVSPKPDFqmRb2ZmRG+
         Jc+/HpUlgs8O8ckBYUFVp7tTdU68P9mMeyWji9rZyvenVPq+BHV3lQpQ5fcChV+NVvFP
         fE5J7V1oqXDTHKPtYO/4TAWpvhr+aOJ4ih8abSf4sR42CsZe7YtJBFWvfcfYc1QhvLBr
         KyjaV4CpWys0/UteOO01iCSXCFf1BjDBqDu38PZS+lWNBIPsJMIs0NcdVlcIB+3QjDpn
         a/2g==
X-Forwarded-Encrypted: i=1; AJvYcCWyMTASHHZaVspx7b3PqLf9gHa1oY/AEdV+s3IbDpbxObE5spxjk+9gnuMfog47ghlg8NFLFA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyeT7zkcdIFc6yLhJExqgFwokjxfRQZR2nIlU/S9HRmj5CVa2l4
	QxuSXRNM2yxJaSubUWCRpXQMNkl88AJDRIUx7YGZoLMeMcxWeTdtNB4U1SAIgrKpYjiW/LX4jtn
	FXKr0dH6R35mb1g==
X-Received: from pjd16.prod.google.com ([2002:a17:90b:54d0:b0:32e:ca6a:7ca9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4d06:b0:340:d81d:7874 with SMTP id 98e67ed59e1d1-3543b3b43f0mr808394a91.26.1769721937697;
 Thu, 29 Jan 2026 13:25:37 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-1-dmatlack@google.com>
Subject: [PATCH v2 00/22] vfio/pci: Base Live Update support for VFIO device files
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132539_562125_88F3B404 
X-CRM114-Status: GOOD (  19.99  )
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

  https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v2

This series adds the base support to preserve a VFIO device file across
a Live Update. "Base support" means that this allows userspace to
safely preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
and retrieve it with  LIVEUPDATE_SESSION_RETRIEVE_FD, but the device
itself is not preserved in a fully running state across Live Update.

This series aims to provide a foundation on which to build the rest of
the device preservation infrastructure, including:

 - Preservation of iommufd files [1]
 - Preservation of IOMMU driver state
 - Preservation of PCI state (BAR resources, device state, bridge state, ...)
 - Preservation of vfio-pci driver state

Testing
-------

The patches at the end of this series provide comprehensive selftests
for the new code added by this series. The selftests have been validated
in both a VM environment using a virtio-net PCIe device, and in a
baremetal environment on an Intel EMR server with an Intel DSA PCIe
device.

Here is an example of how to run the new selftests:

vfio_pci_liveupdate_uapi_test:

  $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test 0000:00:04.0
  $ tools/testing/selftests/vfio/scripts/cleanup.sh

vfio_pci_liveupdate_kexec_test:

  $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0
  $ kexec ...

  $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
  $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0
  $ tools/testing/selftests/vfio/scripts/cleanup.sh

It is also possible to run vfio_pci_liveupdate_kexec_test multiple times
to preserve multiple devices simultaneously across a Live Update. This
series has been tested with up to 8 devices concurrently preserved.

Changelog
---------

v2:
 - Rebase on top of linux-next (tag: next-20260115)
 - Add missing EXPORT_SYMBOL_GPLs in LUO (Zhu)
 - Add Missing EXPORT_SYMBOL_GPLs for vfio_device_fops (Zhu)
 - Fix circular dependency between vfio-pci-core and vfio-pci (Zhu)
 - Handle pci=assign-busses (Lukas)
 - Drop driver_override patch (Jason)
 - Use kho_alloc_preserve(), kho_unpreserve_free(), kho_restore_free() (Pasha)
 - Don't access PCI FLB after device initialization (Jason)
 - Fix folio leak in vfio_pci_liveupdate_retrieve() (Alex)
 - Add Documentation (Pasha)

v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: William Tu <witu@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Josh Hilke <jrhilke@google.com>
Cc: David Rientjes <rientjes@google.com>

[1] https://lore.kernel.org/linux-iommu/20251202230303.1017519-1-skhawaja@google.com/

David Matlack (13):
  liveupdate: Export symbols needed by modules
  PCI: Add API to track PCI devices preserved across Live Update
  PCI: Inherit bus numbers from previous kernel during Live Update
  vfio/pci: Notify PCI subsystem about devices preserved across Live
    Update
  vfio: Enforce preserved devices are retrieved via
    LIVEUPDATE_SESSION_RETRIEVE_FD
  vfio/pci: Store incoming Live Update state in struct
    vfio_pci_core_device
  docs: liveupdate: Document VFIO device file preservation
  vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
  vfio: selftests: Add vfio_pci_liveupdate_uapi_test
  vfio: selftests: Expose iommu_modes to tests
  vfio: selftests: Expose low-level helper routines for setting up
    struct vfio_pci_device
  vfio: selftests: Verify that opening VFIO device fails during Live
    Update
  vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

Vipin Sharma (9):
  vfio/pci: Register a file handler with Live Update Orchestrator
  vfio/pci: Preserve vfio-pci device files across Live Update
  vfio/pci: Retrieve preserved device files after Live Update
  vfio/pci: Skip reset of preserved device after Live Update
  selftests/liveupdate: Move luo_test_utils.* into a reusable library
  selftests/liveupdate: Add helpers to preserve/retrieve FDs
  vfio: selftests: Build liveupdate library in VFIO selftests
  vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
  vfio: selftests: Add vfio_pci_liveupdate_kexec_test

 Documentation/userspace-api/liveupdate.rst    | 144 ++++++++++
 MAINTAINERS                                   |   1 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 212 +++++++++++++++
 drivers/pci/probe.c                           |  23 +-
 drivers/vfio/device_cdev.c                    |  25 +-
 drivers/vfio/group.c                          |   9 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |  11 +-
 drivers/vfio/pci/vfio_pci_core.c              |  24 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c        | 246 +++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  16 ++
 drivers/vfio/vfio.h                           |  13 -
 drivers/vfio/vfio_main.c                      |  23 +-
 include/linux/kho/abi/pci.h                   |  55 ++++
 include/linux/kho/abi/vfio_pci.h              |  45 +++
 include/linux/pci.h                           |  47 ++++
 include/linux/vfio.h                          |  58 ++++
 include/linux/vfio_pci_core.h                 |   2 +
 kernel/liveupdate/luo_core.c                  |   1 +
 kernel/liveupdate/luo_file.c                  |   2 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |  14 +-
 .../include/libliveupdate.h}                  |  11 +-
 .../selftests/liveupdate/lib/libliveupdate.mk |  20 ++
 .../{luo_test_utils.c => lib/liveupdate.c}    |  43 ++-
 .../selftests/liveupdate/luo_kexec_simple.c   |   2 +-
 .../selftests/liveupdate/luo_multi_session.c  |   2 +-
 tools/testing/selftests/vfio/Makefile         |  23 +-
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   8 +
 tools/testing/selftests/vfio/lib/iommu.c      |   4 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  60 ++--
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 256 ++++++++++++++++++
 .../vfio/vfio_pci_liveupdate_uapi_test.c      |  93 +++++++
 35 files changed, 1410 insertions(+), 88 deletions(-)
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/kho/abi/vfio_pci.h
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (80%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/liveupdate.c} (89%)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c


base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
-- 
2.53.0.rc1.225.gd81095ad13-goog


