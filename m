Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5C0CA0EFA
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 23:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAejoY8V8yKY210FgQYVrnGosOJpV+P2BaPXX7POKoM=; b=Omsql9NfJWP4VoycwQx0sPYF7j
	Tyqdr3X0dWPSPuzTGctyY4ab4mLfo2aqrNwhNAUGkKECXMxEMYu/2XxofUGjxscL25kaJHLiuCuH3
	H65NRphCSa3+SMK5OcaQgcDpfk59K+DqXovrAY7uyiMomTrl1dY+89j7pDbX+U9ZzdkQcjcpkG590
	vWoq6dyuxEmn8QZsP+/cXE8Rgpsirg4FVckdPB6oQe9t5esz3NtUWEgn5J5uqf0s1cqMgKYXGb/KR
	ky4Ut9WzZYoKQGUwQO0gyYVv0Vo4hWqcIDcPYzGwoqa5G8YBxVymRye1CjZFoZlHGPnb3h5osp8Zi
	9nuoBH3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upEWK-00000000uiV-0OzO;
	Thu, 21 Aug 2025 23:16:36 +0000
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com ([34.218.115.239])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up9Zx-0000000084n-2DA7
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 18:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755799201; x=1787335201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAejoY8V8yKY210FgQYVrnGosOJpV+P2BaPXX7POKoM=;
  b=DP5KGxCBPvnQDYJi3CkCewQYpwrixZqqlG3J6MYAknsfSm1LnFc1+Lec
   IgpCGEBX2FWRy8E9h+JDBxXW3IkCkgCBjw5ow3GYDCwRfrbL0A4F1jUGo
   7e3lztk2a5AOkQxxG4WQDQSUjGw4vNqaE/c2ZOJdB5vTp3K8mhJ8DXalf
   Uj0PKNbTE3uXD0X/SCPE+XQJhomXnewKaafZQRoyPQus5ShiG1U4KJv4g
   CZktRE80o0cr56lh8t+2Nz70EptABJkzimJGb6U/nE4o5C7STXLW0d3wN
   Me7mZUokagSkL8gqSSUYMWbj1Flz5i0YntuhkjNlWVFAe+tepTvKvlDk1
   w==;
X-CSE-ConnectionGUID: YrrezCWoR5CjuQvlqk0NUg==
X-CSE-MsgGUID: vpO2okg8Q9eLRPjnNyfjuA==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1451197"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 17:59:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:61839]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.67:2525] with esmtp (Farcaster)
 id 107f8fd8-d666-4959-a00a-c9bafbb3e9e6; Thu, 21 Aug 2025 17:59:57 +0000 (UTC)
X-Farcaster-Flow-ID: 107f8fd8-d666-4959-a00a-c9bafbb3e9e6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 21 Aug 2025 17:59:56 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Thu, 21 Aug 2025
 17:59:54 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
Date: Thu, 21 Aug 2025 17:59:00 +0000
Message-ID: <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_110001_618657_6AC8AC06 
X-CRM114-Status: GOOD (  18.05  )
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

When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
early during device tree scanning. After kexec, the new kernel
exclusively uses this region for memory allocations during boot up to
the initialization of the page allocator

However, when booting with EFI, EFI's reserve_regions() uses
memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
rebuilding them from EFI data. This destroys KHO scratch regions and
their flags, thus causing a kernel panic, as there are no scratch
memory regions.

Instead of wholesale removal, iterate through memory regions and only
remove non-KHO ones. This preserves KHO scratch regions, which are
good known memory, while still allowing EFI to rebuild its memory map.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
Changes in v3:
	- Improve the code comments, by stating that the scratch regions are
	good known memory

Changes in v2:
	- Replace the for loop with for_each_mem_region
	- Fix comment indentation
	- Amend commit message to specify that scratch regions
	are known good regions

 drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a00e07b853f2..a65c2d5b9e7b 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/fwnode.h>
 #include <linux/init.h>
+#include <linux/kexec_handover.h>
 #include <linux/memblock.h>
 #include <linux/mm_types.h>
 #include <linux/of.h>
@@ -164,12 +165,32 @@ static __init void reserve_regions(void)
 		pr_info("Processing EFI memory map:\n");
 
 	/*
-	 * Discard memblocks discovered so far: if there are any at this
-	 * point, they originate from memory nodes in the DT, and UEFI
-	 * uses its own memory map instead.
+	 * Discard memblocks discovered so far except for KHO scratch
+	 * regions. Most memblocks at this point originate from memory nodes
+	 * in the DT and UEFI uses its own memory map instead. However, if
+	 * KHO is enabled, scratch regions, which are good known memory
+	 * must be preserved.
 	 */
 	memblock_dump_all();
-	memblock_remove(0, PHYS_ADDR_MAX);
+
+	if (is_kho_boot()) {
+		struct memblock_region *r;
+
+		/* Remove all non-KHO regions */
+		for_each_mem_region(r) {
+			if (!memblock_is_kho_scratch(r)) {
+				memblock_remove(r->base, r->size);
+				r--;
+			}
+		}
+	} else {
+		/*
+		 * KHO is disabled. Discard memblocks discovered so far:
+		 * if there are any at this point, they originate from memory
+		 * nodes in the DT, and UEFI uses its own memory map instead.
+		 */
+		memblock_remove(0, PHYS_ADDR_MAX);
+	}
 
 	for_each_efi_memory_desc(md) {
 		paddr = md->phys_addr;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


