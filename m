Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBECC41535
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G6HJ1VA93THtlzPfeMGqSxKM/gni+mIYW8UVX12xdHE=; b=nwdTpyrfAn/a4H
	pyGeeJ2o5e/STKtkaoNI34G3wyoewdw1BnmDIk7iKjHRxphlpLaHPuwre441itk09YSndbK7mHPWr
	Yt1DY+1ODX6D/gWWvj43R+zWeu6/cD6CXlmNMqiUXRj1OtBH6mVQJUTbLgABGvmXOPymsBbJGAhRE
	9Us0Wlxldl6X8y1qJrYvgMx8lefDx78/4h2zJOd7sIUGskTWYPxCCcqQF9PoYsEQsO2Tg0jRK0zkE
	3JsGNc930la27I2phlTU8RSTH+GOse8BfzGeXJse5M/6pTXl0sBKj4Yhlb7NVQBSPgPPjBPX45+GI
	I1TpIDApwYQ6EFMTWMFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlK7-006hzO-1W;
	Fri, 22 Dec 2023 19:36:43 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlK3-006huk-08;
	Fri, 22 Dec 2023 19:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703273800; x=1734809800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6Ou6SwquM+raA1qs66DJzmcDcyVj924rceIRas5lS8=;
  b=maiu6hf+0qihJ9Uk7cRT73bnsL5W1bBb1k67iAqNNg26ged6wODzirLe
   Fu4Dmh/XXC4GqBHEyY/o9rVHm0DJxBcVkkZP9vOWHO5VmC10SLYr4HSH+
   xRsQcnINArYqvbhoiKQffTeZZKweODkOmxeYd9wqQg0bv+L3cuJDQfBX1
   c=;
X-IronPort-AV: E=Sophos;i="6.04,297,1695686400"; 
   d="scan'208";a="261444389"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:36:34 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 9FF3949A6D;
	Fri, 22 Dec 2023 19:36:22 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:35389]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.220:2525] with esmtp (Farcaster)
 id 9ed8fb9a-78f6-45ad-a602-e555218674d3; Fri, 22 Dec 2023 19:36:21 +0000 (UTC)
X-Farcaster-Flow-ID: 9ed8fb9a-78f6-45ad-a602-e555218674d3
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:21 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 22 Dec 2023 19:36:17 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH v2 02/17] memblock: Declare scratch memory as CMA
Date: Fri, 22 Dec 2023 19:35:52 +0000
Message-ID: <20231222193607.15474-3-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222193607.15474-1-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_113639_153958_27B8B988 
X-CRM114-Status: GOOD (  16.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When we finish populating our memory, we don't want to lose the scratch
region as memory we can use for useful data. Do do that, we mark it as
CMA memory. That means that any allocation within it only happens with
movable memory which we can then happily discard for the next kexec.

That way we don't lose the scratch region's memory anymore for
allocations after boot.

Signed-off-by: Alexander Graf <graf@amazon.com>

---

v1 -> v2:

  - test bot warning fix
---
 mm/memblock.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e89e6c8f9d75..3700c2c1a96d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -16,6 +16,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/page-isolation.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -1100,10 +1101,6 @@ static bool should_skip_region(struct memblock_type *type,
 	if ((flags & MEMBLOCK_SCRATCH) && !memblock_is_scratch(m))
 		return true;
 
-	/* Leave scratch memory alone after scratch-only phase */
-	if (!(flags & MEMBLOCK_SCRATCH) && memblock_is_scratch(m))
-		return true;
-
 	return false;
 }
 
@@ -2153,6 +2150,20 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	}
 }
 
+#ifdef CONFIG_MEMBLOCK_SCRATCH
+static void reserve_scratch_mem(phys_addr_t start, phys_addr_t end)
+{
+	ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
+	ulong end_pfn = pageblock_align(PFN_UP(end));
+	ulong pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
+		/* Mark as CMA to prevent kernel allocations in it */
+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);
+	}
+}
+#endif
+
 static unsigned long __init __free_memory_core(phys_addr_t start,
 				 phys_addr_t end)
 {
@@ -2214,6 +2225,17 @@ static unsigned long __init free_low_memory_core_early(void)
 
 	memmap_init_reserved_pages();
 
+#ifdef CONFIG_MEMBLOCK_SCRATCH
+	/*
+	 * Mark scratch mem as CMA before we return it. That way we ensure that
+	 * no kernel allocations happen on it. That means we can reuse it as
+	 * scratch memory again later.
+	 */
+	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+			     MEMBLOCK_SCRATCH, &start, &end, NULL)
+		reserve_scratch_mem(start, end);
+#endif
+
 	/*
 	 * We need to use NUMA_NO_NODE instead of NODE_DATA(0)->node_id
 	 *  because in some case like Node0 doesn't have RAM installed
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
