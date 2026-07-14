Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721F2C4450A
	for <kexec@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=14GlidItFhGsteVDeFZQr0b0Q8bnxkhoEthNZJCEcqI=; b=iczXeu5Eqa0SuqNOfs2c130ssy
	xnptkLOvfEUF298RnsWllEOdPpsTj5FO+CNDmWgCqPFLRdLTF12xiy0yRtb2thffYzQtQ+LshrW5W
	MQu4nkn5IUEdEBdoK9NE9MZ2CSty1+KrfGHMuP77wGx7kOda0HC8ODInsou89flDUppTeCI/3ebqT
	qjk4qUDld5bhhMhQMk9lGTm6tD/hY45B8ntnyTXzxgHEuxl6AS1caywH2zmVJiKvs5LINmkcYxlAR
	osBJkp9u4owP6tcuZ6sz7jWXQXZjodt2rngwwclHxIOBLE97L9u/KxfIeXCavnQCeJwsg7SCLqH9Z
	8oBjKARQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjer2-0000000CUKf-2rsi;
	Tue, 14 Jul 2026 15:15:28 +0000
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjeqx-0000000CUDB-38YB
	for kexec@lists.infradead.org;
	Tue, 14 Jul 2026 15:15:25 +0000
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8482b95574dso5639373b3a.1
        for <kexec@lists.infradead.org>; Tue, 14 Jul 2026 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042123; x=1784646923; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14GlidItFhGsteVDeFZQr0b0Q8bnxkhoEthNZJCEcqI=;
        b=Gqj4kHkN2BkpC9ehl0d/wFpUw2wYcdK64IQb14Pt6paaiwW1O0LYNjq/2SgRXfabyA
         xF6ygqAKztRB4+RIq+Al09nOA3pfcFT2J7TPUlpaDcxyNZsg51akAx6RAlgTnZRcbhAT
         5h8IUwD6GUd84OL4OakQNQ7/DSlzu3a8vtC2O7FAx8lzK/VJawbquyrorzIWrkbgeUGp
         Zpi5AB+gVgMyDXQxOSi4TSqMz12s/o4rANA4WaZaS0RqxcXDR5NlXxq3rs1LITTNnYR5
         XekjubRUO1cmlWMNaLT4ElIgKJ6Gd+/3SLCehWb01B3d8P0odTxX7+KGpdOoGumAP4q/
         +EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042123; x=1784646923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14GlidItFhGsteVDeFZQr0b0Q8bnxkhoEthNZJCEcqI=;
        b=f4+GCx3QX1pMym4tG8YmEPi6CxgHHetHxugtDFZpI2kWb336Xh3W+m1kFaJpCCTNxX
         DaKwRwTQuB7gxorfvzCNIgJcHCk7iUQxuo1G7YFUtCqXE43vvaPzw7JTYIltokqu4I4X
         b+M+Pa0jIQHdfLPYjCWOBuWs2ejvtGEgtdaAH12daxcOf0JyuAFWWVlRcbKVt0Zajq+O
         bbb28yH0NFwkj9qhc2alv4Ezy2z6J1oFz9ppUeBAmSyQGGumfu8DVZWSk8RknqEVhJ2A
         BUuyHS4MWU79BoG6VEPG64pnuBJkWLynikjBNx7qHyfWMKsqGvaEoubrGPFmenZl2SS4
         O9gg==
X-Gm-Message-State: AOJu0Yyfu47CB7B8DMbjtdoXmJwZMj0HVd8MnG+dKNX1rAEGWQLhLJCd
	CuoDyV+dCo+03q7kCf7b2wvPWLYscdJAFYfXKApiFFYIg0ukEv2um0GNq98Hy7f9pg38H+3mAWf
	lObLA/EfG3Dtn/3ShN9vqNjcRzcx3fIIRkDy1k+66VDYcmF6BcdxmrqUwf9q14zmSOkCk9jJD+S
	57m/Mlogos+vhKh79hrZKrexya+vCoz+iqVom30bYgqAhYwA==
X-Received: from pfoa23.prod.google.com ([2002:aa7:8657:0:b0:847:99d5:ef10])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca3:b0:845:d286:1fbe
 with SMTP id d2e1a72fcca58-848897aa414mr11307298b3a.60.1784042122068; Tue, 14
 Jul 2026 08:15:22 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:57 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-13-vipinsh@google.com>
Subject: [PATCH v5 12/20] docs: liveupdate: Add documentation for VFIO PCI
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
X-CRM114-CacheID: sfid-20260714_081523_849990_61CA8451 
X-CRM114-Status: GOOD (  12.99  )
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

From: David Matlack <dmatlack@google.com>

Add documentation for preserving VFIO device files across a Live Update,
generated from the kernel-doc comments in the code.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 Documentation/core-api/liveupdate.rst         |  1 +
 .../driver-api/vfio_pci_liveupdate.rst        | 23 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 25 insertions(+)
 create mode 100644 Documentation/driver-api/vfio_pci_liveupdate.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 2bce2644eba2..20f1d2e20508 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -38,6 +38,7 @@ The following types of file descriptors can be preserved
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
index 77a35742de0a..43b3165d1c68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28328,6 +28328,7 @@ T:	git https://github.com/awilliam/linux-vfio.git
 F:	Documentation/ABI/testing/debugfs-vfio
 F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
 F:	Documentation/driver-api/vfio.rst
+F:	Documentation/driver-api/vfio_pci_liveupdate.rst
 F:	drivers/vfio/
 F:	include/linux/kho/abi/vfio_pci.h
 F:	include/linux/vfio.h
-- 
2.55.0.795.g602f6c329a-goog


