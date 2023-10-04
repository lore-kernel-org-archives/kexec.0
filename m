Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C850FE936EB
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 22:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uBbxLk9TUneShsiY7xAOrEoIgBkMy9w28+Uo9TznF4I=; b=RIivaKjbizJ3zb
	oY09CZCRoSiDru5chs1jhJPLguecYw21cvqPBXgzg5c0QCfLGTZuJT459DgrvxkwC2Y3+jF3FzlyY
	l33SRWqKi7Lt6LTpLFovsK3N0crHmWpn/4GhVgzkalu32puOpCiM6uxHrCjwDwzhC//pK5PoxTqHV
	l9DtppsKawrRo+57VDSlGvBWOpERO6TkPaUoOrQ3g8ZMU3IsYXdxt56kFX0IajbgYq6Nx1A/TWr5H
	egyIkKUlwSfpjzt++I/CI4KysBbRCii4m5Y5XebeKUksagQ+BVIXdm+rKPpregoKc0xijI8OKuu5i
	+vj9r7hp9UtHGO+HI4Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAHE-0010Of-0v;
	Wed, 04 Oct 2023 22:23:32 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAHB-0010NA-0G
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 22:23:31 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5BE9120B74C2;
	Wed,  4 Oct 2023 15:23:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BE9120B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696458208;
	bh=GwlOK8b41ZMX6FlX17PSaZUjynXX2Y2dfZVQs+XIzFQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=axnzA+IECu/ui4Tf2+4LzIpRwRNobJZ7f/opucsDIpIfIY5FHNrKIswtqpqXETsE8
	 tnvkKFLIw9xy27zm/T2uFcTCyWA7egEgshtkPXI9nGz8ibpV2r0nkd901pNXF1ehLo
	 +NYpWXf+TF4LlsQY2gfr02aV2b5lYXcuLvXId7g8=
Subject: [RFC PATCH v3 3/3] pmpool: Mark reserved range as "kernel reserved"
 in kexec e820 table
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
 bhe@redhat.com, dave.hansen@intel.com, kirill.shutemov@intel.com
Date: Wed, 04 Oct 2023 15:23:27 -0700
Message-ID: <169645820784.11424.922048380402402210.stgit@skinsburskii.>
In-Reply-To: <169645773092.11424.7258549771090599226.stgit@skinsburskii.>
References: <169645773092.11424.7258549771090599226.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_152329_208498_B73306D4 
X-CRM114-Status: GOOD (  13.76  )
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

Update the logic to classify the persistent memory pool in the kexec e820
table as "kernel reserved" when its corresponding e820 region type is
"System RAM". Restore the pool when its type is "kernel reserved". This
ensures the persistence of the memory pool across kexec operations.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 mm/pmpool.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/mm/pmpool.c b/mm/pmpool.c
index c74f09b99283..1e3a2dffc5d3 100644
--- a/mm/pmpool.c
+++ b/mm/pmpool.c
@@ -11,11 +11,14 @@
 #include <linux/mm.h>
 #include <linux/pmpool.h>
 
+#include <asm/e820/api.h>
+
 #include "cma.h"
 
 struct pmpool {
 	struct resource resource;
 	struct cma *cma;
+	bool exists;
 };
 
 static struct pmpool *default_pmpool;
@@ -50,6 +53,18 @@ static void pmpool_cma_accomodate_bitmap(struct cma *cma)
 	pr_info("CMA bitmap moved to %#llx\n", virt_to_phys(cma->bitmap));
 }
 
+static void pmpool_cma_restore_bitmap(struct cma *cma)
+{
+	u64 base;
+
+	base = PFN_PHYS(cma->base_pfn);
+
+	bitmap_free(cma->bitmap);
+	cma->bitmap = phys_to_virt(base);
+
+	pr_info("CMA bitmap restored to %#llx\n", base);
+}
+
 static int __init default_pmpool_fixup(void)
 {
 	if (!default_pmpool)
@@ -58,7 +73,11 @@ static int __init default_pmpool_fixup(void)
 	if (insert_resource(&iomem_resource, &default_pmpool->resource))
 		pr_err("failed to insert resource\n");
 
-	pmpool_cma_accomodate_bitmap(default_pmpool->cma);
+	if (default_pmpool->exists)
+		pmpool_cma_restore_bitmap(default_pmpool->cma);
+	else
+		pmpool_cma_accomodate_bitmap(default_pmpool->cma);
+
 	return 0;
 }
 postcore_initcall(default_pmpool_fixup);
@@ -73,7 +92,7 @@ static int __init parse_pmpool_opt(char *str)
 		}
 	};
 	phys_addr_t base, size, end;
-	int err;
+	int err, e820_type;
 
 	/* Format is pmpool=<base>,<size> */
 	base = memparse(str, &str);
@@ -92,10 +111,33 @@ static int __init parse_pmpool_opt(char *str)
 		return 0;
 	}
 
+	e820_type = e820__get_entry_type(base, end);
+	switch (e820_type) {
+	case E820_TYPE_RAM:
+		e820__range_update_kexec(base, size, E820_TYPE_RAM,
+					 E820_TYPE_RESERVED_KERN);
+		e820__update_table_kexec();
+		break;
+	case E820_TYPE_RESERVED_KERN:
+		/*
+		 * TODO: there are several assumptions here:
+		 *   1. That the kernel reserved region represents pmpool,
+		 *   2. That the region had the same base and size and
+		 *   3. That the region was properly initialized.
+		 * All these assumptions aren't valid in general case and this
+		 * should be addressed.
+		 */
+		pmpool.exists = true;
+		break;
+	default:
+		pr_err("unsupported e820 type: %d\n", e820_type);
+		goto free_memblock;
+	}
+
 	err = cma_init_reserved_mem(base, size, 0, "pmpool", &pmpool.cma);
 	if (err) {
 		pr_err("failed to initialize CMA: %d\n", err);
-		goto free_memblock;
+		goto remove_e820_kexec_range;
 	}
 
 	pmpool.resource.start = base;
@@ -108,6 +150,8 @@ static int __init parse_pmpool_opt(char *str)
 
 	return 0;
 
+remove_e820_kexec_range:
+	e820__range_remove_kexec(base, size, E820_TYPE_RESERVED_KERN, 1);
 free_memblock:
 	memblock_phys_free(base, size);
 	return 0;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
