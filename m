Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2370ECE79A5
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0la8E0bO1A1zBCD6xvF0oQGi1XXtr4F3pRdaYeyRFQA=; b=RB8vdbvpKVAW+r
	IzmA5mKGA27jSi26hNL/bQEdEii4L/13hgEK+CYO04wWekx30Ulr3Mtd6FVJhZN/ddzZiSxm2Mu8g
	4z8eoATpXpVXqllFWzBc2GXwikNwqfA6OyMBZZFlG5Pgvaxykyx31TubgmXiR6m0c8aXTFQ+WqS8/
	AzRu99HAMwOBBggzC1wgy3ZroTwTbre/C9DtxbUbLMyWNk2zJEXOIiCsfZJa/R2omYNFSLIKN5AFW
	olLrQsdUHelNcYXO5YS0AmtjiDHqmR8TdFVuARCrKjiMf9J0ILU360OwBiepI/KJV+KkseUiNWp0O
	zKgeHUcYzstTphYpkY5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7s-00F3Tm-1Z;
	Mon, 25 Sep 2023 21:28:20 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7p-00F3S8-1Z
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:28:18 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id BAA54212C81A;
	Mon, 25 Sep 2023 14:28:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAA54212C81A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677297;
	bh=oG2PUbwyF0nuBD1C3aXahDUjw4ck7gfs8NgK91ItcqM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Fi/3N9OAw/nGt/uwjjhNLNgVqdjSu5ywBK7Yy8dfefOgTdcr/WjZzNrDbHg0WhJ55
	 Y25/hspsoEK6nJI/6xzI5raCpMqxrjwwOEcPl5ctm31eKl1pZN++J+F1xlrrFqVMmF
	 LTsPS7A3Wi0BG7kILvcMt7YSK0LUmYIm/6B2OlyI=
Subject: [RFC PATCH v2 5/7] pmpool: Update device tree on kexec
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:28:16 -0700
Message-ID: <169567729602.19708.7544090989330715724.stgit@skinsburskii.>
In-Reply-To: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
References: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142817_576354_4BE93235 
X-CRM114-Status: GOOD (  15.49  )
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

Introduce a pmpool kexec fdt notifier that enables pmpool to pass its
metadata, including the bitmap address, to the new kernel during kexec.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 mm/Kconfig  |    1 +
 mm/pmpool.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index e7c10094fb10..1eefdd4c82ba 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -925,6 +925,7 @@ config CMA_AREAS
 config PMPOOL
 	bool "Persistent memory pool support"
 	select CMA
+	select LIBFDT
 	help
 	  This option adds support for CMA-based persistent memory pool
 	  feature, which provides pages allocation and freeing from a set of
diff --git a/mm/pmpool.c b/mm/pmpool.c
index 12a8cac75558..f2173db782d6 100644
--- a/mm/pmpool.c
+++ b/mm/pmpool.c
@@ -6,6 +6,7 @@
 #include <linux/cma.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/pmpool.h>
@@ -58,6 +59,59 @@ static int __init default_pmpool_fixup_cma(void)
 }
 postcore_initcall(default_pmpool_fixup_cma);
 
+static int pmpool_fdt_update(struct notifier_block *nb, unsigned long val,
+			     void *data)
+{
+	void *fdt = data;
+	int node, status;
+
+	if (!fdt)
+		goto err;
+
+	node = fdt_subnode_offset(fdt, 0, "chosen");
+	if (node < 0) {
+		node = fdt_add_subnode(fdt, 0, "chosen");
+		if (node < 0)
+			goto err;
+	}
+
+	node = fdt_add_subnode(fdt, node, "default_pmpool");
+	if (node == -FDT_ERR_EXISTS)
+		return 0;
+	if (node < 0)
+		goto err;
+
+	status = fdt_setprop(fdt, node, "compatible",
+			     "pmpool", sizeof("pmpool"));
+	if (status)
+		goto err;
+
+	status = fdt_setprop_u64(fdt, node, "bitmap",
+				 virt_to_phys(default_pmpool->cma->bitmap));
+	if (status)
+		goto err;
+
+	status = fdt_setprop_u64(fdt, node, "size",
+				 default_pmpool->cma->count << PAGE_SHIFT);
+	if (status)
+		goto err;
+
+	status = fdt_setprop_u64(fdt, node, "base",
+				 default_pmpool->cma->base_pfn << PAGE_SHIFT);
+	if (status)
+		goto err;
+
+	return NOTIFY_DONE;
+
+err:
+	pr_err("failed to update fdt\n");
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pmpool_kexec_fdt_nb = {
+	.notifier_call  = pmpool_fdt_update,
+};
+
 static int __init parse_pmpool_opt(char *str)
 {
 	static struct pmpool pmpool;
@@ -80,10 +134,16 @@ static int __init parse_pmpool_opt(char *str)
 		return 0;
 	}
 
+	err = register_kexec_fdt_notifier(&pmpool_kexec_fdt_nb);
+	if (err) {
+		pr_err("failed to register kexec fdt notifier: %d\n", err);
+		goto free_memblock;
+	}
+
 	err = cma_init_reserved_mem(base, size, 0, "pmpool", &pmpool.cma);
 	if (err) {
 		pr_err("failed to initialize CMA: %d\n", err);
-		goto free_memblock;
+		goto notifier_unregister;
 	}
 
 	pr_info("default memory pool is created: %#llx-%#llx\n",
@@ -93,6 +153,8 @@ static int __init parse_pmpool_opt(char *str)
 
 	return 0;
 
+notifier_unregister:
+	unregister_kexec_fdt_notifier(&pmpool_kexec_fdt_nb);
 free_memblock:
 	memblock_phys_free(base, size);
 	return 0;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
