Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D363F532C2
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aeeFxLRNeEzMbfk8m3pX/GNMnylfMV1s3l1hGn54HBA=; b=S0cx5gCG2k1vjdwTGDoX9pWhb8
	nHscCTWzyg1DcRQLp/9ceeI21HQZQ1qNBAaq6SSRpChjJ8UY2T2StR7FjOj7TbUEIwW1cvcOblHHN
	sQijP2TSTaeKFaUlx4TZX28Z+pZejOdZ/gIY/ZJvkn4YrESyEfVHqWphDPKw9rfD2aWIfbCPr8QYj
	gb4yB+ldhKK4Tp8bd04ryt/JLFz3ujYa0Gqk3soJR/URykE97zejHBWK+aJEyK4TVPcEs9nYwn+Cn
	OTxEV0c+eoVN+Wp8clqv0zNB9L46r2tfWUGqjs8TVtlFJhm6Edcy5SiBz75nuT2FmyGcKaW3lCbSC
	4dh9uMsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAp-00000000Bhg-32ZL;
	Mon, 23 Mar 2026 23:59:07 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAj-00000000BZU-3Xbi
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:05 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso4153839a91.2
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310340; x=1774915140; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeeFxLRNeEzMbfk8m3pX/GNMnylfMV1s3l1hGn54HBA=;
        b=lxHvVO75Kr37yv2B5+jUe5mgaLkwbSDqrtvgMHgO/3LUk94S5fGOvq8vYv00aVSMDi
         LgnbYMy9aIMPf20rC4EFl++wW3IRoWUS4HYsi1XSYHNSBEqqGGWTaAMM7zvXZQoOdZ02
         a464tzCXMDPunnOwEmHDgKQCCw+WzwIdrha4DU87Hb3acAFTpkPVbhQJkPRoOU+Glr33
         UxCZOX1XhpEOhFXnxewPRlWZwuV1a5WOoHXzNmmTysh4LNywj+ElxskvDyxiDgW3noUM
         hSqdvVfE4ux2b3FxbKYMk4OGNIoarJMG9OhXjpYD3Ctr4cSscT2NZh7FlSKXHmp91RqU
         Q9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310340; x=1774915140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeeFxLRNeEzMbfk8m3pX/GNMnylfMV1s3l1hGn54HBA=;
        b=oR+vwQ7LKMndNsydwEUuUh139ueNdzv1qjbam4syH6RyC2mhq4G8pv0o1qRyVb1X8F
         xzko24C0i03FdbpG9E0UMQhVeG/YeZjXw8UMWfh4n/TFTBgt58Z80ZyCYH0bGKlYAyct
         H1f293Kz0RIByq4CW1kg5D5lhbUe9+NehmskucQant2M6N1d2qMKZ1zr6DHTTSWQRXXT
         swNQYbFw4Xvq6pVe6m3DUYfX6qmd+CrVKFDxzjRgtxYdM+DnNpfF559ebpdfKX8A4vQG
         Q21uNWh6aCAbJY7N7fD6yIBDb6hKl6VgrBGR3E6LwJQn4BcWULRx60otlLZqFoZa6Wfr
         NMIg==
X-Forwarded-Encrypted: i=1; AJvYcCUeCED7o/oELimgzyXyfjYqCDHZbWA4XchRi8K0jzxwi2zITZCrmlEgLRJ1HXUK4PiyzNzftA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwpkM4MqKddg+QiqbpBIg41Hj0v4fdPHzIONocWD59NPWBJS0gE
	rME0uznSU7fBDennAj948EHP0jB0IFG3eQ5RHjuarhnmaqIs9NoV7LPXjXvQ9T9+aPtaeT/IjFt
	IDEwuf2vpzeZyEQ==
X-Received: from pgbcl21.prod.google.com ([2002:a05:6a02:995:b0:c73:90cf:9638])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3286:b0:398:7ca0:43a9 with SMTP id adf61e73a8af0-39bceb46904mr12137508637.36.1774310340303;
 Mon, 23 Mar 2026 16:59:00 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:05 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-14-dmatlack@google.com>
Subject: [PATCH v3 13/24] docs: liveupdate: Add documentation for VFIO PCI
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
X-CRM114-CacheID: sfid-20260323_165901_999445_44F04669 
X-CRM114-Status: GOOD (  14.98  )
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

Add documentation for preserving VFIO device files across a Live Update,
generated from the kernel-doc comments in the code.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/core-api/liveupdate.rst         |  1 +
 .../driver-api/vfio_pci_liveupdate.rst        | 23 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 25 insertions(+)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index d56a7760978a..c55d0d9d1d3b 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -34,6 +34,7 @@ The following types of file descriptors can be preserved
    :maxdepth: 1
 
    ../mm/memfd_preservation
+   ../driver-api/vfio_pci_liveupdate
 
 Public API
 ==========
diff --git a/Documentation/driver-api/vfio_pci_liveupdate.rst b/Documentation/driver-api/vfio_pci_liveupdate.rst
new file mode 100644
index 000000000000..1098b84e5ecd
--- /dev/null
+++ b/Documentation/driver-api/vfio_pci_liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================================
+VFIO PCI Device Preservation via LUO
+====================================
+
+.. kernel-doc:: drivers/vfio/pci/vfio_pci_liveupdate.c
+   :doc: VFIO PCI Preservation via LUO
+
+VFIO PCI Preservation ABI
+=========================
+
+.. kernel-doc:: include/linux/kho/abi/vfio_pci.h
+   :doc: VFIO PCI Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/vfio_pci.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/core-api/kho/index`
diff --git a/MAINTAINERS b/MAINTAINERS
index a16a7ecc67a4..a6a31b94a4e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27684,6 +27684,7 @@ T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
+F:	Documentation/driver-api/vfio_pci_liveupdate.rst
 F:	drivers/vfio/
 F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
-- 
2.53.0.983.g0bb29b3bc5-goog


