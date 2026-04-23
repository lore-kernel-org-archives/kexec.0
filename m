Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CD4FDEE4E
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4E3v8P9Bgd+PvGMRS8uoO/TIv3RrWRtb2HfczKdNV9k=; b=LiFPaILsQzSzN4surbP4SRmXea
	qjqmE9BuM/1gwuPobt4xcwEIbXyztwScO0Lk6hYPVvpVqUHtjvYYDdiCuHyADPArVR6Ho/J7jCCej
	qGci3zs3pPkvYQb23Qr5LbT/MSHBTr75Y8AGJyUm7/mYdMwpV7psJPMJtrZzMFoli+mkenBEAXAFg
	Qo7elwHuLEVgnMkuK/qO7LFI7z46072qnCoJeSkgsxkOO2MaNNCyISKjMNPnBjgVWQMdTt1+3Mb+Y
	npOWEN416wdRbjjGQUKepZ5CPiiDBzCHvCZZy7f5mnMfamGdho0VJ7n/bkXxdK214KVzUpk8mRkPF
	6z7oApzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WR-0000000CLJU-2E9O;
	Thu, 23 Apr 2026 21:23:43 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG1WP-0000000CLFx-04fU
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 21:23:42 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2b242062308so131716825ad.2
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979420; x=1777584220; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4E3v8P9Bgd+PvGMRS8uoO/TIv3RrWRtb2HfczKdNV9k=;
        b=gz8diAexTLW1A5Utvk80zzP3r0Y/5UQ2K/j1BZmrnhIu2NhvncjcAOtrMjA6Th3opM
         PF2GBNIDiXz6s1Ig2NY5Zu4b5rFXDGksVxyOCyGa2oG+6BsoPnSGz0SjGpyBf7ihhLuZ
         w/+bYCyRYmKxJkxm3cDGfi6rnI07ktynSLV6/np5s0PHrigkB6dyThX2ONwdxWN2hc3H
         ecYbKK8++/4xARsKLgL8tVGc/8oDRgXpnDTDIG/Err13zRbM+cOfTv//XaUfNx5ojhrY
         sZtqE+n1KeHNaSt8c75kTCZ+WDCky+wH/NtnWWT/46FH0xtRr02PY5Q6gC/hNHU/kjNn
         /hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979420; x=1777584220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E3v8P9Bgd+PvGMRS8uoO/TIv3RrWRtb2HfczKdNV9k=;
        b=QfNgaoE2RAoD1Y7fAQCGFqRJXzaPL8WmEjnR6Yvhdpm338+dP7Nbu4m+OLUZa0WWw3
         atzz+iULsZZf+mgIaUOyKwqcjCfjsGVMxktcHuyj/QQBNjmp/aNbTDEt8+p7WofrJo09
         P+EY1aprCRU4NNur0CL4UIUjV5foebi/7mOI0m8hSU5ypEf7cPmo0RWLwX9vNlwwTd8t
         +7Jh1zplyw6H0XLU+Gs4ul8D0ApqxNZLEHr09/5Soznv2lr3Zc6nFNd4ZNVhWZ7aiqWf
         1SeFMSObyqpP0q97Sq+tQCpUzTwTCeh4aDEyzqyhCS6x4FBzEx+yaKciln2xIqhW5QzE
         Ti2g==
X-Forwarded-Encrypted: i=1; AFNElJ9MP9s9PfgTP13IP2cDiNVq6fqmcTiFE/kh3yDCPPElPdpRM0s7oulkM4CqCdICxr8m8Jgy5g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzyd71rs/im0nZfq1Ys9kuxVDSJUTTsKlcLUWrwsbKCT33MjkCM
	i2f6yU30GRJBenBsGIJnewHhTzI4dxkz8TemWDOsxdFrvQIrdXJ1X4zd1uMrBMcRKBN9NhdbJ7O
	R/hfZvHNDB4Pt9A==
X-Received: from plon6.prod.google.com ([2002:a17:903:1a86:b0:2b2:c9d2:11fd])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2984:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b5f9fd146amr301151585ad.37.1776979419527;
 Thu, 23 Apr 2026 14:23:39 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:15 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-12-dmatlack@google.com>
Subject: [PATCH v4 11/11] Documentation: PCI: Add documentation for Live Update
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
X-CRM114-CacheID: sfid-20260423_142341_067786_DF375A77 
X-CRM114-Status: GOOD (  14.32  )
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

Add documentation files for the PCI subsystem's participation in Live
Update.

These documentation files are generated from the kernel-doc comments
in the PCI Live Update source code. They describe the File-Lifecycle
Bound (FLB) API, the device tracking API, and the specific policies
applied to preserved devices (such as bus number inheritance and bus
mastering preservation).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/index.rst           |  1 +
 Documentation/PCI/liveupdate.rst      | 23 +++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 MAINTAINERS                           |  1 +
 4 files changed, 26 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..23fb737ac969 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -20,3 +20,4 @@ PCI Bus Subsystem
    controller/index
    boot-interrupts
    tph
+   liveupdate
diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
new file mode 100644
index 000000000000..04c9b675e8df
--- /dev/null
+++ b/Documentation/PCI/liveupdate.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+PCI Support for Live Update
+===========================
+
+.. kernel-doc:: drivers/pci/liveupdate.c
+   :doc: PCI Live Update
+
+PCI Preservation ABI
+====================
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/pci.h
+   :internal:
+
+See Also
+========
+
+ * :doc:`/core-api/liveupdate`
+ * :doc:`/core-api/kho/index`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..d56a7760978a 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -70,3 +70,4 @@ See Also
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
 - :doc:`/core-api/kho/index`
+- :doc:`PCI </PCI/liveupdate>`
diff --git a/MAINTAINERS b/MAINTAINERS
index 94af31837375..42dbac2c2ed3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20564,6 +20564,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
 B:	https://bugzilla.kernel.org
 C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/PCI/liveupdate.rst
 F:	drivers/pci/liveupdate.c
 F:	include/linux/kho/abi/pci.h
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


