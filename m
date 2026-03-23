Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C046EF532C1
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZJphTQtAwt37fyli6EqFM5TvIsP7A+bmY4QV1yw4cuY=; b=yY9+Yqeu9cO/tJn4Ks/9WuCq/d
	yCdp58yP1iTHIkc5W2PLpRgdKxyFpHILdBvGZ9w8Avx/NzZEXxnJW+dP/SrmBXhUcD2Wo6DpxyCgW
	e2GaIZveM32RXuMdrlzJn1HrCj3kPBrjaJl3SSndmnIwH0pCF8MYx3IFx+rJ3TmSpmOxWZ06dBRAW
	pE99JsegPCLw7mthFQOF/9Rlpbh28RD7HX4k3DHj2KiPhAn5kHlAOsneBDhjmWuZK578DGn/WLeUg
	L8AtYpiROaoXTpWBH9+GjOGWZLgVkkCWYzGl3Ts+t3Y02w4J/b6WYBtvJQEy9cc34jg4xZfTJ61jC
	rVDsy9LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAR-00000000BFi-1Z4m;
	Mon, 23 Mar 2026 23:58:43 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAN-00000000BEZ-2D74
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:42 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2b06c242a34so323199145ad.0
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310318; x=1774915118; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJphTQtAwt37fyli6EqFM5TvIsP7A+bmY4QV1yw4cuY=;
        b=Bm11aCzD3hSc0jn4b76keNQmmsyxHmNV8h3lz7l3CDutefh6DuH9jY/ysG9kPxZ8UP
         b982e4G4zU34Aragc0Edz+lixbt+3TEAidwpivhKOEQR7J3KTjDz5N0i0u1dsg/jbItx
         VHaNugUZWwr60TSFxVJINWQSedghpcF4qrw3LNVzA9V90qzmiC7YcjJRMyMyPft1Qiyr
         1dadZl45rL0Uhyix447D0tJ8wnmChF44Fh8rnoWo474f6qIcVC53JPxecIYqWcqgCXwn
         UcyYBXOkcjgcExM0LX/TqwdBFDNZQs1mhWJuSZ0SsgJnc+ysRj82ckItqAxFPurGEkg4
         vAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310318; x=1774915118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJphTQtAwt37fyli6EqFM5TvIsP7A+bmY4QV1yw4cuY=;
        b=LnFKBU4lMCP1lxnPIVWiwrHAbseDolsCG1r3OUd5aeBj289v+La91NyV4+CrouqqQh
         /IDiym2NmqeWe1wzK97XqaK792fYOztR3N49QRgRHKg+vU5SKcF42ymiASQ2o05hPci9
         OVXOVlkJYUyWUPZ7kMpCOfQQsqd2tUpIjp5N3NLa36iUJEW/8I6fvONvj86zdJdv8KzV
         Y/461o+WIz9VN1XtuDx5TB4cPucgFyTtG5QQLAVjIZ/Ztk7x9lFkXF/rCM5dvmkskIDD
         36bmfoQnbXfy/tGTb0aKMvJlR4RwXCUshdohGBzvGcE26QkLtx+e+G/HGw3oa03ws3C5
         SFqA==
X-Forwarded-Encrypted: i=1; AJvYcCX17ahH0WV2SmlMmGc7i3t6LxRoXsfDgUw/wMCcBdEc6DMYVceduzeBfA10it68fItFLrbEPQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0XS1fgRiEhrqC9PioGaqVA/FcdgkzvJ/Nn3Bdmh3ho3Mh2UJY
	8Fq+N74vJsL8cVciXaYxJXtcnV8rGY4+ANorkIJ15k1+QM486QJulFZQstGfNis1AVg1oOm3D5l
	1PpinsPfOYLeSCw==
X-Received: from plfu18.prod.google.com ([2002:a17:902:e5d2:b0:2b0:6cdd:87e2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e850:b0:2ae:7fbd:3dcd with SMTP id d9443c01a7336-2b0827e30f8mr133238585ad.52.1774310317408;
 Mon, 23 Mar 2026 16:58:37 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-1-dmatlack@google.com>
Subject: [PATCH v3 00/24] vfio/pci: Base Live Update support for VFIO device files
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_165839_577748_D7C82759 
X-CRM114-Status: GOOD (  26.10  )
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

  https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v3

This series adds the base support to preserve a VFIO device file across
a Live Update. "Base support" means that this allows userspace to
safely preserve a VFIO device file with LIVEUPDATE_SESSION_PRESERVE_FD
and retrieve it with  LIVEUPDATE_SESSION_RETRIEVE_FD, but the device
itself is not preserved in a fully running state across Live Update.

This series aims to provide a foundation on which to build the rest of
the device preservation infrastructure, including:

 1. Preservation of iommufd files [1]
 2. Preservation of IOMMU driver state
 3. Preservation of PCI state (BAR resources, device state, bridge state, ...)
 4. Preservation of vfio-pci driver state

Steps 1 and 2 are already in-progress on the mailing list. We are
working on a detailed roadmap for steps 3 and 4.

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

Dependencies
------------

This series is built on top of v7.0-rc4 plus a series from Pasha
Tatashin to fix the module refcounting in FLB:

  https://lore.kernel.org/lkml/20260318141637.1870220-10-pasha.tatashin@soleen.com/

Changelog
---------

v3:
 - Add logging & documentation for pci=assign-busses overrides (Pranjal)
 - Use 2026 in drivers/pci/liveupdate.c (Pranjal)
 - Use 2026 in drivers/vfio/pci/vfio_pci_liveupdate.c (Pranjal)
 - Drop incoming/outgoing from PCI APIs (Sami)
 - Eliminate duplicate extern declarations for vfio_device_fops
   (Pranjal)
 - Keep struct vfio_device_file private (Pranjal)
 - Add comment about not supporting hot-plug (Pranjal)
 - Add comment about not supporting VFs (Sami)
 - Better error handling for liveupdate_flb_get_incoming() (Pranjal)
 - Remove liveupdate_enabled() checks (Zhu)
 - Remove liveupdate_enabled() checks in vfio_pci_liveupdate_init() (Pranjal)
 - Drop IOMMU reference from bus number commit message (Bjorn)
 - Add fabric rationale to commit message (Jason)
 - Swap incoming ... outgoing ordering in commit message (Bjorn)
 - Use vfio_device_cdev_opened() instead of df->group (Alex)
 - Add comments for CONFIG_VFIO_PCI_ZDEV_KVM (Alex)
 - Add comments for vfio_pci_is_intel_display() (Alex)
 - Use pci_dev_try_lock() in freeze (Alex)
 - Fix device reset locking in freeze() (me)
 - Use u32 for domain in PCI (Bjorn)
 - Use u32 for domain in VFIO (Bjorn)
 - Make pci_liveupdate_incoming_nr_devices() private to drivers/pci/ (Bjorn)
 - Fix dev->liveupdate_incoming readability (Bjorn)
 - Take pci_ser_delete() out of WARN_ON_ONCE() (Bjorn)
 - Drop reference to userspace & files from PCI commit message (Bjorn)
 - Rename __vfio_device_fops_cdev_open() to vfio_device_cdev_open_file() (Alex)
 - Fix NULL pointer dereference in release() (Alex)
 - Handle return value of pci_liveupdate_outgoing_preserve() (Alex)
 - Make pci_liveupdate_unregister_fh() unabe to fail. (Alex)
 - Move vfio_liveupdate_incoming_is_preserved() to drivers/vfio/vfio.h (Alex)
 - Add vfio_pci_core_probe_reset() (Alex)
 - Forward declare ser struct in include/linux/vfio_pci_core.h (Alex)
 - Bump compatibility string when adding reset_works (Alex)
 - How will userspace detect partial preservation? (Alex)
 - Require single device per iommu_group (Jason)
 - Rename pci_liveupdate_register_fh() to pci_liveupdate_register_flb() (Vipin)
 - Use ksft_exit_skip() and SKIP() (Vipin)
 - Move documentation to code (Vipin)
 - Use __u64 instead of int for token in Live Update selftest helpers (Gemini)
 - Add documentation for drivers/pci/liveupdate.c (me)

v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/

v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/

Cc: Pranjal Shrivastava <praan@google.com>
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

David Matlack (15):
  liveupdate: Export symbols needed by modules
  PCI: Add API to track PCI devices preserved across Live Update
  PCI: Require Live Update preserved devices are in singleton
    iommu_groups
  PCI: Inherit bus numbers from previous kernel during Live Update
  docs: liveupdate: Add documentation for PCI
  vfio/pci: Notify PCI subsystem about devices preserved across Live
    Update
  vfio: Enforce preserved devices are retrieved via
    LIVEUPDATE_SESSION_RETRIEVE_FD
  vfio/pci: Store incoming Live Update state in struct
    vfio_pci_core_device
  docs: liveupdate: Add documentation for VFIO PCI
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

 Documentation/PCI/liveupdate.rst              |  23 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   2 +
 .../driver-api/vfio_pci_liveupdate.rst        |  23 +
 MAINTAINERS                                   |   2 +
 drivers/pci/Kconfig                           |  11 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 415 ++++++++++++++++++
 drivers/pci/pci.h                             |  14 +
 drivers/pci/probe.c                           |  37 +-
 drivers/vfio/device_cdev.c                    |  63 ++-
 drivers/vfio/group.c                          |   9 +
 drivers/vfio/pci/Kconfig                      |  11 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |  14 +-
 drivers/vfio/pci/vfio_pci_core.c              |  90 ++--
 drivers/vfio/pci/vfio_pci_liveupdate.c        | 328 ++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  18 +
 drivers/vfio/vfio.h                           |  18 +
 drivers/vfio/vfio_main.c                      |  16 +-
 include/linux/kho/abi/pci.h                   |  62 +++
 include/linux/kho/abi/vfio_pci.h              |  45 ++
 include/linux/pci.h                           |  41 ++
 include/linux/vfio.h                          |  13 +
 include/linux/vfio_pci_core.h                 |   2 +
 kernel/liveupdate/luo_core.c                  |   1 +
 kernel/liveupdate/luo_file.c                  |   2 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |  14 +-
 .../include/libliveupdate.h}                  |  11 +-
 .../selftests/liveupdate/lib/libliveupdate.mk |  20 +
 .../{luo_test_utils.c => lib/liveupdate.c}    |  43 +-
 .../selftests/liveupdate/luo_kexec_simple.c   |   2 +-
 .../selftests/liveupdate/luo_multi_session.c  |   2 +-
 tools/testing/selftests/vfio/Makefile         |  23 +-
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   8 +
 tools/testing/selftests/vfio/lib/iommu.c      |   4 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  60 ++-
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 256 +++++++++++
 .../vfio/vfio_pci_liveupdate_uapi_test.c      |  93 ++++
 41 files changed, 1715 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/kho/abi/vfio_pci.h
 rename tools/testing/selftests/liveupdate/{luo_test_utils.h => lib/include/libliveupdate.h} (80%)
 create mode 100644 tools/testing/selftests/liveupdate/lib/libliveupdate.mk
 rename tools/testing/selftests/liveupdate/{luo_test_utils.c => lib/liveupdate.c} (89%)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c


base-commit: 3251ac3df4374e4e94e4fbecf49ad1573933018a
prerequisite-patch-id: 37ebd38e2247ccb02e6a6c7543a378534d69a038
prerequisite-patch-id: 19c8469a9ae5cd13618481dd75012444330f80f9
prerequisite-patch-id: 2ba04f598993e2c2d941c4cd3f2dc1e98905d68b
prerequisite-patch-id: fcab928f6ee32a145667822ceca5e4f1f567d530
prerequisite-patch-id: 6d11347278609426baa9eacc1726b32b48d09a25
prerequisite-patch-id: 94a9e8a8cb6004e12de90fcc0068e8a8b12652de
prerequisite-patch-id: d658019a7ac7c82ebe4a6c6086457e27460174d3
prerequisite-patch-id: 41e68c9fc8e8c5e493497e87ca13577b3167cf80
-- 
2.53.0.983.g0bb29b3bc5-goog


