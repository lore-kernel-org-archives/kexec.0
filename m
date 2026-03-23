Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8738F532C1
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z81MLxHKunKSpfd9G8Gazc1UStxzf4ZSRozQrfTx8r0=; b=W3SO89GtVBSpEeFrK/s4HB+nEh
	2b1Ryr4cNxrgUU73o9FeEnIxf1pcdtPq+X8TQSaY3V97E/EIp0HZSWZX32KN3Gw9RKodBbbtoMLLS
	PphcchQu7582Q9ooSHck1XiHqrE+sHuqbn3YfoCwCC9FjUd60NLAesZFTPBAzsI8/TVaq06gJvVq9
	4Ft7f/KU7PgE5/XbjsvOLmKHqeVV0FaGjWr3FAn4YAWnnbvHLtjr50LtwQ2UF2vkCfNUaMMbhAgpt
	OD4v0YiOTYRyD0t5mmHdN8ejDnSDtsas+BICwexdCz4MqXSvRul6neX0TzIO+vkh4woy4uC2H0jFl
	GDgTzj2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAY-00000000BM6-0Ntx;
	Mon, 23 Mar 2026 23:58:50 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAV-00000000BIF-1pWG
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:48 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-358f058973fso1103322a91.1
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310326; x=1774915126; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z81MLxHKunKSpfd9G8Gazc1UStxzf4ZSRozQrfTx8r0=;
        b=ZCx5WoDs5YueTOnFqQTrQye/dtNvhHPP9s6vYZqrucQxrK6IgwpBe3yXTpBF4I6iRJ
         JhseGVSKeXA0ksKdWWrGGPUiM5tmESEAes8BIhW8sgaumqk2YTehVx6VnGbrGugY7ibP
         tGQD269GHh2DxFezuVXLd9tb9I4ULP0AE3ONkdTFnchXnzr4r19KU0Bs0x4G5eAFeqjT
         3VTEGXc+CxRC/qeRPnNQBpY0mD+8Ifyy0LaJRT2PC4qjoGYlCAEcAk0cXL60l+nEix0D
         U3wr6+0HGEbukSa8uclhVhLeQxvmeUuU2WeZKzi5dv76zuEXHbnlZ7cRwZ9YJnQ9+S3n
         GwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310326; x=1774915126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z81MLxHKunKSpfd9G8Gazc1UStxzf4ZSRozQrfTx8r0=;
        b=h6m5xJDQUHwcgehYvWg7uV0VhfN+3stEwxjjFvKbWeE41E+FNOrUMxLnQDWyiBSBve
         Gh7tPmEWq775ZvbU0SR6vde6U+i7g0wt0vS0mltpRoRnwW94c+J8ZyDLLdPj69ut6LZ8
         H+Ju6gOtupgjkTKFqCYebAh0Dpzd+bWDHZGnUJowaRZF4F4GayA8ufvBTEAJbXCslNqj
         1NCJy0gcg1R37llI56qh84DlCz0ZGbxBngSBlyZV1OY5mR0vJNRSDx5G3AJcXf6aRRP3
         DFiHox28rij7ddw1zRPWG7Tiqpb3kIColMU7kqMpUEeNFaXIzcDdRW3Bz1vX86JtAHyh
         fkow==
X-Forwarded-Encrypted: i=1; AJvYcCUl3Q4Lo1AseCCxNOFtyYQmhtB/h2MThNzsfznyMvk3OjsYKJHjVtEpkFiUYxlBJ0FfARH+gQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyb5MBTUJ5ZVNsQVB+Xyz/ZAAakjdVz9RzridBpr8I8zUi11MAq
	xBucpvChfA/LQ1cBE+519uDRp9hXY+4xEw7spq3+hbblPp2LmfPHGjvQuqEz5LvK3+4saffXA2r
	f51q1EKdhAyVOsQ==
X-Received: from pjbfs13.prod.google.com ([2002:a17:90a:f28d:b0:359:979d:cee5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5390:b0:35a:275c:4c27 with SMTP id 98e67ed59e1d1-35bd2bba27cmr10391028a91.2.1774310325767;
 Mon, 23 Mar 2026 16:58:45 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:57 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-6-dmatlack@google.com>
Subject: [PATCH v3 05/24] docs: liveupdate: Add documentation for PCI
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
X-CRM114-CacheID: sfid-20260323_165847_482280_71B32C6D 
X-CRM114-Status: GOOD (  14.19  )
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
Update, generated from the kernel-doc comments the code.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 Documentation/PCI/liveupdate.rst      | 23 +++++++++++++++++++++++
 Documentation/core-api/liveupdate.rst |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/PCI/liveupdate.rst

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
-- 
2.53.0.983.g0bb29b3bc5-goog


