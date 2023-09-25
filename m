Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347AFCE79A5
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2R6lLkmRrfuIyltPAHvk7YY9LvAza6U/+Xc5CZRhDNo=; b=qGFCKrKzUACIT4
	jk5PBw1xIMP7xBC0x0t0rfWEP51UWlg4XCqzi21LstNpeqfe4ox7TRyb7pHileNHyGUoabQasK8iD
	Ix7WgwJC2fuLKZZlInnbwYYYmR+WMBcgizQdS2OdWIKsD5xFXx5d2cJx6223hlPCad9cmnNwVE7Or
	n1sb+ufrKWS9wTZwhpuOJUeLTNIu3pjcWc09eUwgm0+ZWMCVDpwtkZgiadPYqIXXsDDzFA/wECmHH
	TMEK3eyKuRtBzmml01VtzKjltnwz32u3t39BGTDMgG6VBUhW/x7QiV8Sg642X43igYKpi6sUwTTpv
	VdHxaxG5rMbK+opJSlyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7z-00F3Y2-1p;
	Mon, 25 Sep 2023 21:28:27 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7w-00F3Vr-0U
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:28:25 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 874BA212C81C;
	Mon, 25 Sep 2023 14:28:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 874BA212C81C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677303;
	bh=JfnfRf/8Z1j91lE6hWWpyKLJ8dXQ6U0FUQpoylAZ8tA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=dWbNHl0rs/Szzl5OmMYUUNSVUH665li3UCcaxU37P8vzb09CFwp0HrmaCMsLneC+Z
	 8Fu0yKAok1W6TAZoSnLmhtoenEBITTdDJE8ihS2PFKq8oikP7fEL+cShCODKI6iKgC
	 PrYgG7tRVKKfqrnvXyTfcMuCYeMCcAkaqfR04VHI=
Subject: [RFC PATCH v2 6/7] pmpool: Restore state from device tree post-kexec
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:28:22 -0700
Message-ID: <169567730206.19708.13228262570187347469.stgit@skinsburskii.>
In-Reply-To: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
References: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142824_216742_2DBE1A26 
X-CRM114-Status: GOOD (  10.11  )
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

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

Retrieve the pmpool bitmap from metadata in the fdt passed over kexec,
bypassing the need for reinitialization. This ensures the seamless transfer
of the pmpool state across kexec.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 mm/pmpool.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/mm/pmpool.c b/mm/pmpool.c
index f2173db782d6..6c1a28fd3493 100644
--- a/mm/pmpool.c
+++ b/mm/pmpool.c
@@ -9,6 +9,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
+#include <linux/of.h>
 #include <linux/pmpool.h>
 
 #include "cma.h"
@@ -49,11 +50,56 @@ static void pmpool_fixup_cma(struct cma *cma)
 	pr_info("CMA bitmap moved to %#llx\n", virt_to_phys(cma->bitmap));
 }
 
+static int pmpool_fdt_restore(struct cma *cma)
+{
+	struct device_node *dn;
+	u64 val;
+
+	dn = of_find_compatible_node(NULL, NULL, "pmpool");
+	if (!dn)
+		return -ENOENT;
+
+	if (of_property_read_u64(dn, "base", &val)) {
+		pr_err("invalid fdt: no base\n");
+		return -EINVAL;
+	}
+	if (val != PFN_PHYS(cma->base_pfn)) {
+		pr_err("fdt base doesn't match: %#llx != %#llx\n",
+			val, PFN_PHYS(cma->base_pfn));
+		return -EINVAL;
+	}
+
+	if (of_property_read_u64(dn, "size", &val)) {
+		pr_err("invalid fdt: no size\n");
+		return -EINVAL;
+	}
+	if (val != (cma->count << PAGE_SHIFT)) {
+		pr_err("fdt size doesn't match: %#llx != %#lx\n",
+			val, cma->count << PAGE_SHIFT);
+		return -EINVAL;
+	}
+
+	if (of_property_read_u64(dn, "bitmap", &val)) {
+		pr_err("invalid fdt: no bitmap\n");
+		return -EINVAL;
+	}
+
+	pr_info("CMA bitmap restored to %#llx\n", val);
+
+	bitmap_free(cma->bitmap);
+	cma->bitmap = phys_to_virt(val);
+
+	return 0;
+}
+
 static int __init default_pmpool_fixup_cma(void)
 {
 	if (!default_pmpool)
 		return 0;
 
+	if (!pmpool_fdt_restore(default_pmpool->cma))
+		return 0;
+
 	pmpool_fixup_cma(default_pmpool->cma);
 	return 0;
 }



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
