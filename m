Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBEEC4450A
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AdMdxqs5Z8x509tTZKpL2bKGAMA2jSi8MmCd4hShlVQ=; b=z0ukN3Rv9/xkHN/dFTxWmKSdJn
	Xa4xUJYVcR7FneSAyDes5IwCWzNSWD2O52qhjG8Jqf+68UGOmpl/VqTq3n+HuenMUr1waioXCnQto
	eavUKOCNXwodEphIlGeOqZ7QM/ReitNjEh79PPmiWOvl8/B9XbErKaj1Pk68HxvvDv2QFzYKzQ/IB
	SJa9nav6jHj6g0ttYw5ry67aOnTsh1i38c25pKQs+cdzCkNYw3LELZ2InlbXJKGQlbX79KKv3FHRN
	YcVcqlFcUeob/wpTJmz+MmsxYspniAPlEKM0qfpzRdAH8ja0ZgtFMbPECzHWfXKjc3BSLktuWtQNX
	yvMAEFsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqn-0000000CU2v-4BEZ;
	Tue, 14 Jul 2026 15:15:14 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeql-0000000CU1n-2QSj
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:13 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-848568a6f62so7766077b3a.0
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042110; x=1784646910; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AdMdxqs5Z8x509tTZKpL2bKGAMA2jSi8MmCd4hShlVQ=;
        b=qEi1+IsCkQrJQpCBIOzXVej3AH6y2FLwb5uf6Jkl9rNdudPfOZjue+p8K20FStTTwR
         gw4OZtaJtSVzavocmHhgZNp8LF7iSloxucN97Ehuzmcfqj+72tztMEFSZToqgINjt5R9
         5LaOe+OWWu4hm9OyvPPd0OhHE7MUqKbiSQiHtMd3mss0xbQpV0OWIQyaR2uhAVU0aUUc
         N8KrTsGAumGul+mgtLUZHU8FM9IQvXDRlZV9XsLbGflidkviyVy2BF8mljC83UB6+aVZ
         Uk06vEG0yL5cytjiXq93vmTZHz/YcQ2GaF23nBqSuQkFrJ5YnEQLEyS2/TUXo2GgQzkm
         gNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042110; x=1784646910;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdMdxqs5Z8x509tTZKpL2bKGAMA2jSi8MmCd4hShlVQ=;
        b=TDp2k37SLZ7SQt1sKXwY11Mj4NGVOi5bx0miO4OlkSuq1UeIt3Ab+MK+5cz6LFyn3c
         qONhYSuqGAvwVcRKkGaVK6ibuc0V8WaDOlN0UNbXQ325D9YHLnXcAcqFbqsd2ynPOQYu
         uRyxSAUlFT2nrcC26Cu5Y+4RN4+CcykTM4pM0sgx0KNGEqrRv30Uo62aFytYfx2fV7WP
         Og4rlIg+BlAmTwg7FEr+l6GAYHXBEQ5Xy2FwrHabi7ODgeMuO0aR437Ch21KJdoPn/vm
         xubTtLQEYj/lxz8ci0x3RgkqOlldXirfm7T9N9Tcf5EwDFDSvqszBhflzn5I5biLCFQR
         2Mnw==
X-Gm-Message-State: AOJu0YxHvNv7VtE02Nay17I+EurxYtxhoxLv3U4zyyWS3vdogGJhWcLS
	7a+4P/KL+Tzno0wKpV7/5aP6ojaHMa4qEsA+wJx3kuiN3JIazSunsrNiAspxE2w5pfnn0tJ/u8i
	30KykXKVlZJeCUzMGaYRxltg8C8vpRFbfQhrIcITnGjETFAkFC0gEVEu4d589l5ejSRdEIeGz5R
	cYxWi5uRRDBUTgC+AvEmPW68ht2fowj7hLmKe7kfB0EMQJ6w==
X-Received: from pfbhh6.prod.google.com ([2002:a05:6a00:8686:b0:847:9199:e06])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:460e:b0:845:363e:12d9
 with SMTP id d2e1a72fcca58-84a554f93damr3265089b3a.3.1784042109576; Tue, 14
 Jul 2026 08:15:09 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-1-vipinsh@google.com>
Subject: [PATCH v5 00/20] vfio/pci: Base Live Update support for VFIO
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_081511_633759_8A38E561 
X-CRM114-Status: GOOD (  16.65  )
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

Hello,

This series can be found on Github:

  https://github.com/shvipin/linux vfio/liveupdate/v5

This series provides the base support to enable Live Update feature for
VFIO PCI devices using the Live Update Orchestrator (LUO) and Kexec
Handover (KHO).

Overview
--------

This series makes the following changes to support VFIO Live Update:

 - Puts VFIO Live Update support behind the CONFIG_VFIO_PCI_LIVEUPDATE
   config option (which requires CONFIG_VFIO_DEVICE_CDEV).
 - Preserves VFIO cdev device FDs across a kexec Live Update session via
   LUO/KHO.
 - Enforces that incoming preserved devices can only be retrieved via
   LIVEUPDATE_SESSION_RETRIEVE_FD post-kexec (preventing legacy
   group/cdev opens from accessing uninitialized state).
 - Quiesces the device prior to kexec in freeze() by resetting hardware,
   disabling bus mastering, and marking the device frozen to reject
   post-freeze IO/MMIO.
 - Includes VFIO selftests (uapi & kexec tests with continuous DMA
   checks) and kernel documentation.

VFIO PCI Live Update Roadmap
----------------------------

We are planning to add VFIO PCI Live Update support in phases. Since full
support of this feature will come in phase, VFIO PCI Liveupdate is
controlled by CONFIG_VFIO_PCI_LIVEUPDATE config option. 

This series is phase 1 below:

 1. PCIe function (non-VF) preserved across Live Update without changing
    BDF
 2. PCIe function (non-VF) preserved across Live Update without resetting
 3. PCIe function (non-VF) preserved across Live Update with continuous
    DMA (noiommu)
 4. PCIe function (non-VF) preserved across Live Update with continuous
    DMA (iommufd)
 5. PCIe VF preserved across Live Update with continuous DMA (iommufd)

Dependencies
------------

This series has following dependencies as shown in the diagram

    |---------------------------|
    |         VFIO v5           |  <--- Sent in this series.
    |---------------------------|
    |  Liveupdate Selftests[1]  |
    |---------------------------|
    |        PCI v7 [2]         |
    |---------------------------|

[1] https://lore.kernel.org/all/20260511201155.1488670-1-vipinsh@google.com/
    These selftests changes are needed by other selftests also (iommu,
    kvm), so, I have sent them separately.

[2] https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/
    This is the PCI v7, which adds the live update support in PCI core.

Github branch I have mentioned at the top has all of these dependencies.

Testing
-------

Tested using VFIO Live Update selftests in both QEMU and bare-metal
environment (Intel DSA PCIe device).

  $ ./setup.sh 0000:00:04.0
  $ ./vfio_pci_liveupdate_kexec_test --stage 1 0000:6a:01.0
  $ kexec --reuse-cmdline -l -s /boot/vmlinuz
  $ kexec -e
  $ ./setup.sh 0000:00:04.0
  $ ./vfio_pci_liveupdate_kexec_test --stage 2 0000:6a:01.0

Kernel command line options used:
  - liveupdate=on
  - kho=on
  - vfio_iommu_type1.allow_unsafe_interrupts=Y
  - vfio_pci.enable_sriov=Y
  - vfio_pci.disable_denylist=Y
  - vfio.enable_unsafe_noiommu_mode=Y


Changelog
---------

v5:
 - Addressed Sashiko feedback.
 - Removed condition to disable CONFIG_VFIO_PCI_DMABUF.
 - Expanded vfio_find_device() helper to safely discover a registered
   vfio_device by matching criteria. Internal Sashiko instance found
   data race.
 - Updated selftests to latest changes in VFIO selftests.
 - Rebased on top of PCI Live Update series v7.

v4: https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/

v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/

v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/

rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (7):
  vfio: Enforce preserved devices are retrieved via
    LIVEUPDATE_SESSION_RETRIEVE_FD
  docs: liveupdate: Add documentation for VFIO PCI
  vfio: selftests: Add vfio_pci_liveupdate_uapi_test
  vfio: selftests: Add Makefile support for TEST_GEN_PROGS_EXTENDED
  vfio: selftests: Expose iommu_modes to tests
  vfio: selftests: Verify that opening VFIO device fails during Live
    Update
  vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

Vipin Sharma (13):
  vfio/pci: Factor out the reset logic in VFIO PCI device close path
  vfio: Export various helpers from VFIO
  vfio/pci: Export vfio_pci_dma_buf_move for vfio-pci module
  liveupdate: Export symbols needed by modules
  vfio/pci: Register a file handler with Live Update Orchestrator
  vfio/pci: Preserve vfio-pci device files across Live Update
  vfio: Introduce vfio_find_device() helper
  vfio: Refactor vfio_device_fops_cdev_open()
  vfio: Add API to open cdev device for Live Update restore
  vfio/pci: Retrieve preserved device files after Live Update
  vfio: selftests: Build liveupdate library in VFIO selftests
  vfio: selftests: Initialize vfio_pci_device using a VFIO cdev FD
  vfio: selftests: Add vfio_pci_liveupdate_kexec_test

 Documentation/core-api/liveupdate.rst         |   1 +
 .../driver-api/vfio_pci_liveupdate.rst        |  23 ++
 MAINTAINERS                                   |   2 +
 drivers/vfio/device_cdev.c                    |  67 +++-
 drivers/vfio/group.c                          |   9 +
 drivers/vfio/pci/Kconfig                      |  12 +
 drivers/vfio/pci/Makefile                     |   1 +
 drivers/vfio/pci/vfio_pci.c                   |  13 +-
 drivers/vfio/pci/vfio_pci_config.c            |   3 +
 drivers/vfio/pci/vfio_pci_core.c              | 119 +++---
 drivers/vfio/pci/vfio_pci_dmabuf.c            |   1 +
 drivers/vfio/pci/vfio_pci_liveupdate.c        | 340 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h              |  28 ++
 drivers/vfio/vfio.h                           |  18 +
 drivers/vfio/vfio_main.c                      |  67 +++-
 include/linux/kho/abi/vfio_pci.h              |  43 +++
 include/linux/vfio.h                          |  12 +
 include/linux/vfio_pci_core.h                 |   3 +
 kernel/liveupdate/luo_file.c                  |   2 +
 tools/testing/selftests/vfio/Makefile         |  23 +-
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   3 +
 tools/testing/selftests/vfio/lib/iommu.c      |   4 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  25 +-
 .../vfio/vfio_pci_liveupdate_kexec_test.c     | 256 +++++++++++++
 .../vfio/vfio_pci_liveupdate_uapi_test.c      |  97 +++++
 26 files changed, 1097 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst
 create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
 create mode 100644 include/linux/kho/abi/vfio_pci.h
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_uapi_test.c


base-commit: cbf37fff757e87376e80e11a8378393a8f25145f
prerequisite-patch-id: 85705fb54d3065efe1d87ab4b69e828a9f3404e7
prerequisite-patch-id: a33ae79b5fc0259bd013b430c18cc3d14a678599
-- 
2.55.0.795.g602f6c329a-goog


