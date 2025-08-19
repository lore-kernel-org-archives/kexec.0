Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F1BCA0EEB
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 00:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cd20LjcxPOsEg21zYy/cmh2I9QA1AIBt6CLKTzRjH7g=; b=UxwOePuyMRN9C21sEhj85Ovlxd
	gyTDz1mK5kP4wdY2u2lWPRrk1lzh59UbdoBOcia/fouuUrnm1jWp7Zp3zeTuSnZWB4kaniEgQEBNw
	AfU6bPePrI6HyrOLnY6CFmzfgmF/f6/kMxEpkgEZXbsysmfi9FvnNV4LYPltoaE+yZCe7CnTfdJ0L
	j0LMQVrYhAF8Zu/iaQaoJlwJxCBgHsRNqDb0E6GYCAflLn7rX1GeSeY70qJ7QPHT8f1HJFpHLP9UV
	ngJtH/LjXrqAF2JnnMb+3UDPgamV0fT7Qit2NOaYi4TDIic8Zl8V9DJh7pg941nmKP7IWRluQsKB1
	f0J/+bSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoX4S-0000000Bzyj-0Rdm;
	Wed, 20 Aug 2025 00:52:56 +0000
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com ([44.246.77.92])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoViV-0000000Bqj2-1czR
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 23:26:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755645971; x=1787181971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cd20LjcxPOsEg21zYy/cmh2I9QA1AIBt6CLKTzRjH7g=;
  b=WhfvyJEFwLb12CMdl5C1X6yHfkeQaAFOagtieio668isX/fDoRC9ChTv
   cO9oTy4bB9vlojPd1n4Zq9a3cyZ0/+ROP5avxf/XXcdO5aDb2CPdKY+Rr
   f/grc/8iuTHpJW+WKZEJkcxOl5560IAgFMPMKjvG1TNEk2jlW7xPzz12p
   wB3B4fWEQzbJXXjkZ7v+gxqRegGZfPAq/E1PfO5rxkox0J8QZQMNnE5CC
   xEerFjAjD88Pbn6dkhhgh4YmjcpFnRDT1pfSFbIa2M8eO1SNBoRuYF79w
   zhKrpeVXPnl4clLKsK+9IcQKtqtcDvyscwogGEljchR/OSDV4yz8lT4CC
   w==;
X-CSE-ConnectionGUID: vgDJ3wGLRkyBdDWeMGCc+w==
X-CSE-MsgGUID: znqb36LARvCDQs2S0Xz73Q==
X-IronPort-AV: E=Sophos;i="6.17,302,1747699200"; 
   d="scan'208";a="1403455"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:26:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:8848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.170:2525] with esmtp (Farcaster)
 id 1f517b9c-a5d9-4ed2-9cc8-20113cac2a08; Tue, 19 Aug 2025 23:26:07 +0000 (UTC)
X-Farcaster-Flow-ID: 1f517b9c-a5d9-4ed2-9cc8-20113cac2a08
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 19 Aug 2025 23:26:07 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Tue, 19 Aug 2025
 23:26:05 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v2 2/2] efi: Support booting with kexec handover (KHO)
Date: Tue, 19 Aug 2025 23:22:46 +0000
Message-ID: <9e80381d4fafc71d6e0c64d69a8b3ac9c8949865.1755643201.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755643201.git.epetron@amazon.de>
References: <cover.1755643201.git.epetron@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_162611_478729_11C30608 
X-CRM114-Status: GOOD (  17.07  )
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

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
Changes in v2:
	- Replaced the for loop with for_each_mem_region
	- Fixed comment indentation
	- Amended commit message to specify that scratch regions
	are known good regions

 drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a00e07b853f2..99f7eecc320f 100644
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
@@ -164,12 +165,31 @@ static __init void reserve_regions(void)
 		pr_info("Processing EFI memory map:\n");
 
 	/*
-	 * Discard memblocks discovered so far: if there are any at this
-	 * point, they originate from memory nodes in the DT, and UEFI
-	 * uses its own memory map instead.
+	 * Discard memblocks discovered so far except for KHO scratch
+	 * regions. Most memblocks at this point originate from memory nodes
+	 * in the DT and UEFI uses its own memory map instead. However, if
+	 * KHO is enabled, scratch regions must be preserved.
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


