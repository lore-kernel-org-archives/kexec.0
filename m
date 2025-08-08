Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A88C87FCB
	for <kexec@archiver.kernel.org>; Fri,  8 Aug 2025 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VQqGKx8yCcMPM3OfBvB/9sDgA5FM7b1V6O0IxKuT2Ng=; b=0AQIiRX7J4b6JqRqkS6aoUOgTN
	TWeRwlHL7wkM7hkTimneoef/VlB6QBoGzoRRqv+SImT6KRtj9Eo3Q8keftKduHflDTpt0DhBeyNaj
	/jnu3UAtDZajZ+EInbWvZeq4ec3g/aOkwbm2ETr/hNfteOwTfGreNNAPro7lSzGP3dFPtgtmYNwQX
	gWJoG0ubMMh73CA4NP/RfWho1tRzvExH51UiIHsGxqaTo18MqF98DRuKQ4ewmj45GPO0eR10AqlWT
	1p5Fg7zmB24Jrlc99PNUsjnQd18YaBS5r3Q0gbvQvgLoiDxGf8EALzWNDsjC5Nkku5/syp+hAMMYj
	KrWcRCVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukQ5l-00000003KOG-2ZD0;
	Fri, 08 Aug 2025 16:37:17 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukQ5i-00000003KNq-2WyM
	for kexec@lists.infradead.org;
	Fri, 08 Aug 2025 16:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1754671035; x=1786207035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VQqGKx8yCcMPM3OfBvB/9sDgA5FM7b1V6O0IxKuT2Ng=;
  b=Wrhhi+i/rQBiKxNVj5YNxs3FPR2pxHmAauZa16hC/LSz/h1nyJtEe0Vf
   ttx85TlL0vrX8MJ4YCB6kbyVT09H8HLAWj1Ady21pqWE8IhPoNuXnlNAI
   8KFgh9ROzTh/woJ0cwAq+ZPgPwrqeTsOnyy8WVL/7AC+gueBvxMm2unvP
   Eyni47I+id9sIm6c20KDZHFsT+ZoaSkTEkLie3iYcdkCQFCzz14z/nG1t
   IKPQi2vSeW9x362G/gWak6rHN7Q4+g1yu7oUoerFfsdq/vsynW2c76uD+
   FdumUhwEtxWpCWD35VHDkyNgm0Wpy8uyltAlcZX2TxtFWI2UUjUD0T6fn
   w==;
X-IronPort-AV: E=Sophos;i="6.17,274,1747699200"; 
   d="scan'208";a="746124479"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 16:37:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:41049]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.11:2525] with esmtp (Farcaster)
 id d1a47885-9ae3-49af-a06a-0b2fb4acfb5c; Fri, 8 Aug 2025 16:37:09 +0000 (UTC)
X-Farcaster-Flow-ID: d1a47885-9ae3-49af-a06a-0b2fb4acfb5c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 8 Aug 2025 16:37:08 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Fri, 8 Aug 2025
 16:37:06 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: <ardb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu
	<changyuanl@google.com>, <kexec@lists.infradead.org>,
	<nh-open-source@amazon.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] efi: Support booting with kexec handover (KHO)
Date: Fri, 8 Aug 2025 16:36:51 +0000
Message-ID: <20250808163651.25279-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250808_093714_800801_492CAC38 
X-CRM114-Status: GOOD (  15.24  )
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
remove non-KHO ones. This preserves KHO scratch regions while still
allowing EFI to rebuild its memory map.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---

Reproduction/Verification Steps
The issue and the fix can be reproduced/verified by booting a VM with
EFI and attempting to perform a KHO enabled kexec. The fix
was developed/tested on arm64.

 drivers/firmware/efi/efi-init.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a00e07b853f22..2f08b1ab764f6 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -164,12 +164,35 @@ static __init void reserve_regions(void)
 		pr_info("Processing EFI memory map:\n");
 
 	/*
-	 * Discard memblocks discovered so far: if there are any at this
-	 * point, they originate from memory nodes in the DT, and UEFI
-	 * uses its own memory map instead.
+	 * Discard memblocks discovered so far except for KHO scratch regions.
+	 * Most memblocks at this point originate from memory nodes in the DT,
+	 * and UEFI uses its own memory map instead. However, if KHO is enabled,
+	 * scratch regions must be preserved.
 	 */
 	memblock_dump_all();
-	memblock_remove(0, PHYS_ADDR_MAX);
+
+	if (IS_ENABLED(CONFIG_MEMBLOCK_KHO_SCRATCH)) {
+		struct memblock_region *reg;
+		phys_addr_t start, size;
+		int i;
+
+		/* Remove all non-KHO regions */
+		for (i = memblock.memory.cnt - 1; i >= 0; i--) {
+			reg = &memblock.memory.regions[i];
+			if (!memblock_is_kho_scratch(reg)) {
+				start = reg->base;
+				size = reg->size;
+				memblock_remove(start, size);
+			}
+		}
+	} else {
+	/*
+	 * KHO is disabled. Discard memblocks discovered so far: if there
+	 * are any at this point, they originate from memory nodes in the
+	 * DT, and UEFI uses its own memory map instead.
+	 */
+		memblock_remove(0, PHYS_ADDR_MAX);
+	}
 
 	for_each_efi_memory_desc(md) {
 		paddr = md->phys_addr;
-- 
2.43.0




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


