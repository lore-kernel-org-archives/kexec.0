Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B06FD5C0F2
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 08:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t9GVMSE5QYBAq5Na9iKzheEhYI2L9XOqJpGx0SGLtLw=; b=Aropj3ctVcRPmftQAV9LOKIN+B
	nkbl57mKW+6KrTtg9prLhqnqsSxMIT6ZxL5LFinaeLtozv7AuAmm8b/6Y4Mg6mrw6ItT7Sx3immul
	YF+R5NKaDliqGVSCCSvWM2DBSH+m1piJZiay94O1vfpsmVLqQrlhhvskQ3c78fzGNJPgJ+KUOC2PU
	rHrH6rc7tFdhBhoOtbPjCKedFVs3CJEwaBnWnPM7OkJI90mpQ+hL3CS77fiS6o9Yf4HcrMrSDJYKg
	IPgRJDJXo5ITyuGHJTu7U6zx1FAfEWh5ImuyYwiCFgMXvgm9S/8U6cm/9in3MRJSdVkD3NGYsBBvs
	mcujavUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVQkU-00000004wye-0IYZ;
	Tue, 16 Dec 2025 08:49:38 +0000
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.68.102])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVQkP-00000004wyH-00wh
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 08:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1765874973; x=1797410973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t9GVMSE5QYBAq5Na9iKzheEhYI2L9XOqJpGx0SGLtLw=;
  b=K2XYOvdqLUHj4+KLQ7OdpkpBWVMZ5NHyHK/4IwVpgm4ao1K3BIAA8Nw6
   a+milhV98qsRAt6Vw9AL+YDS8EO/xWxSR2A5CB+UJObIS6EIEdMEKxuta
   6+Tr3/al9M1LBjiiQbciXX0eAqo8ZGW3kRaO4d25RXvq3JUZcE0TIK9Vd
   Lm4CNQi0YdVTZqobYYw6zCVnIvwSnWEMItuiLRyK6JDrzjl/OSSGNvz2k
   CTmqE1jo2eDSvL1f6hfU9/RtdRdKmlzePyOXr6DIkQvMesw5nNksILU9K
   1smMoSAt7WFCtjLwpK0YfO1Vm3EAGd++Kyx93h9p2XH2K4PjGesxQi8kw
   w==;
X-CSE-ConnectionGUID: AB8P62TDTxCVBKRB7W9YBA==
X-CSE-MsgGUID: giJnBZetQTewkmJV4jC3yw==
X-IronPort-AV: E=Sophos;i="6.21,152,1763424000"; 
   d="scan'208";a="9165717"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 08:49:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:20952]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.145:2525] with esmtp (Farcaster)
 id e256b7ba-6e38-433a-93d4-84c8c1e4bf24; Tue, 16 Dec 2025 08:49:25 +0000 (UTC)
X-Farcaster-Flow-ID: e256b7ba-6e38-433a-93d4-84c8c1e4bf24
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 16 Dec 2025 08:49:25 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Tue, 16 Dec 2025
 08:49:23 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, Andrew Morton <akpm@linux-foundation.org>, Jason Miu
	<jasonmiu@google.com>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH] kho: add support for deferred struct page init
Date: Tue, 16 Dec 2025 08:49:12 +0000
Message-ID: <20251216084913.86342-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_004933_116179_729A7DBD 
X-CRM114-Status: GOOD (  18.28  )
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

When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
initialization is deferred to parallel kthreads that run later
in the boot process.

During KHO restoration, `deserialize_bitmap()` writes metadata for
each preserved memory region. However, if the struct page has not been
initialized, this write targets uninitialized memory, potentially
leading to errors like:
```
BUG: unable to handle page fault for address: ...
```

Fix this by introducing `kho_get_preserved_page()`,  which ensures
all struct pages in a preserved region are initialized by calling
`init_deferred_page()` which is a no-op when deferred init is disabled
or when the struct page is already initialized.

Fixes: 8b66ed2c3f42 ("kho: mm: don't allow deferred struct page with KHO")
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
### Notes
@Jason, this patch should act as a temporary fix to make KHO play nice
with deferred struct page init until you post your ideas about splitting
"Physical Reservation" from "Metadata Restoration".

### Testing
In order to test the fix, I modified the KHO selftest, to allocate more
memory and do so from higher memory to trigger the incompatibility. The
branch with those changes can be found in:
https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init

In future patches, we might want to enhance the selftest to cover
this case as well. However, properly adopting the test for this
is much more work than the actual fix, therefore it can be deferred to a
follow-up series.

In addition attempting to run the selftest for arm (without my changes)
fails with:
```
ERROR:target/arm/internals.h:767:regime_is_user: code should not be reached
Bail out! ERROR:target/arm/internals.h:767:regime_is_user: code should not be reached
./tools/testing/selftests/kho/vmtest.sh: line 113: 61609 Aborted
```
I have not looked it up further, but can also do so as part of a
selftest follow-up.

 kernel/liveupdate/Kconfig          |  2 --
 kernel/liveupdate/kexec_handover.c | 19 ++++++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index d2aeaf13c3ac..9394a608f939 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "Live Update and Kexec HandOver"
-	depends on !DEFERRED_STRUCT_PAGE_INIT
 
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	depends on !DEFERRED_STRUCT_PAGE_INIT
 	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select LIBFDT
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 9dc51fab604f..78cfe71e6107 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -439,6 +439,23 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 	return err;
 }
 
+/*
+ * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory
+ * regions may not be initialized yet at the time KHO deserializes preserved
+ * memory. This function ensures all struct pages in the region are initialized.
+ */
+static struct page *__init kho_get_preserved_page(phys_addr_t phys,
+						  unsigned int order)
+{
+	unsigned long pfn = PHYS_PFN(phys);
+	int nid = early_pfn_to_nid(pfn);
+
+	for (int i = 0; i < (1 << order); i++)
+		init_deferred_page(pfn + i, nid);
+
+	return pfn_to_page(pfn);
+}
+
 static void __init deserialize_bitmap(unsigned int order,
 				      struct khoser_mem_bitmap_ptr *elm)
 {
@@ -449,7 +466,7 @@ static void __init deserialize_bitmap(unsigned int order,
 		int sz = 1 << (order + PAGE_SHIFT);
 		phys_addr_t phys =
 			elm->phys_start + (bit << (order + PAGE_SHIFT));
-		struct page *page = phys_to_page(phys);
+		struct page *page = kho_get_preserved_page(phys, order);
 		union kho_page_info info;
 
 		memblock_reserve(phys, sz);
-- 
2.43.0




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


