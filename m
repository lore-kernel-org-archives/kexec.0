Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29CAC4451C
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ryAibA3UWy163Q6txvfKm94io1oYGbkfbCSFpMGxh9A=; b=eWU8FWeZaX1TQ7nztcN8BH8FQc
	nxi2gkh11G7bE1JyaAY7pDOpKT29JLf/Xqwv+GARVjxXCKEtQAj+FI09IpT4eAPO5Hs1VticVc0Lb
	pR3Kx5iUi5SbsHoKBze4KEAk0pSxhdAhglVhCHFE8Tjh9olRRJ5ItqZjDzfuc+Nbesey/gTsjVVFB
	X8BU94/Et01puHCCO/jvVkkQDcPYh0HbBwyNiSvAxjkJ3Zci5Fnzr2zDmrOLwCQIkSN80+UcgIpkU
	+26OZIGyGgsNm+ncpL2dbX5Rgk+uh+2zsxY8V0sRdQPV+uOEtfLInTghFrvgI2WiN7eMXNrZ5eOjB
	vIrktW8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkjAB-00000002SKC-2pBY;
	Fri, 17 Jul 2026 14:03:39 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkjA9-00000002SGt-0AJ3
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 14:03:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ryAibA3UWy163Q6txvfKm94io1oYGbkfbCSFpMGxh9A=; b=f76xJR+uGbWEAJkrNJKR/tsl//
	WYE8RZ/bdvihZPqQVALvdJXAXd0luydJM5tO3DcPuh6IcD0cWa+z1BNiQ1u5UucJOB5JRH0Othykv
	UMwkzmw0aBkECVJZfRTHUtfn80/1R1PfdL3DFMRDQgEpOZw8tlB+LnpCKdhvosEqqG4FFwMcPsFOB
	3RRCfu7tu2eejltF0LelTy8oynnvwXvWUeXvWCdeWNmJZdFwEx/06WKZatKYxIV9BFUwOoAocQ90U
	Wd5BgwDvNU8TmwmMn9WbWhI7TCQ177hcNIBcvW2KEBhP6ckDZ1vXLiJ9Adyj/cCK5/f+x+5r2vyyC
	CMcjQrBg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wkjA6-004eCN-2h;
	Fri, 17 Jul 2026 14:03:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 17 Jul 2026 07:03:05 -0700
Subject: [PATCH RFC 3/3] efi: reserve inherited poisoned frames before the
 allocator comes up
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-hwpoison-kho-v1-3-9c5eda551998@debian.org>
References: <20260717-hwpoison-kho-v1-0-9c5eda551998@debian.org>
In-Reply-To: <20260717-hwpoison-kho-v1-0-9c5eda551998@debian.org>
To: kas@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, rneu@meta.com, riel@surriel.com, caggio@meta.com, 
 anilagrawal@meta.com, rmikey@meta.com, linux-mm@kvack.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4040; i=leitao@debian.org;
 h=from:subject:message-id; bh=1B5wbOTz4R16KdCWBh2WpnOWjS/l3+Etg9EdeiHv4gY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqWjYjQRjUyRtH/XxcTVFxIPVxq7RYO+/+BCjcB
 Jpu4BhAffyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalo2IwAKCRA1o5Of/Hh3
 baKhD/46lld3B8rE2OEoWjHPbUAYkrTmb8nHu4KGL0VfoOm2qVA78qrlblfXHLVXi4FGdJwgXwU
 pGaKmoyrJxdTC2YysG7atzAwzcn7l4U0gXH47H88iuZmxUPtlKuABXB0ZRRXDytkLFhMe6Y5zfh
 jCiW3OMXaxthxI2oWzzhx4kQrOqc5QGakw65b0/QepAb7JEajcobdzMcpd4McKT1n7p6CGRUVhx
 uio4QoQGBmcJ1g5koob9oUv+xXhun08peIflK/Y+d7jTawKWR8P1WE/1XkIsvTXjKJDO+zI4AIQ
 KXR/5afyqeW1YFwT4TkzbtWkbi3IwIiYpXLevmnVaixbqtLgCZGb1wTBbt2B3oWOX/LzPoXkhd8
 URkg15PB9QcQrgP/5fo3TzwQkLWtveFxSLhehKQPJq6GR5glWV5UyZpNcoALX4aQU1bJUPklyPp
 7gr+xYYSuMkdyYPlKzJajkpmB/u+Jx2PnymK2a4TDs8HpWOyQyGHdYPrPT3bf8SDfGGc4Z3BZ42
 5Q4vfmaMpaYzVxEDDTYiaU6lCXUo74Auom/P4NHHto2fhaSMMMya1MC1uAoHTwVU6sZYXxlp6vr
 X8Yfcz1ocqDk7QjUnc+E4QGdEgfgy2wPa/uQziSv4jNQZMllHDi42D/c9xCua1/Fy+CNJf48stV
 +m9lt0Ib/FWg2qA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_070337_084482_357F7818 
X-CRM114-Status: GOOD (  17.97  )
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

On the next kernel, walk the LINUX_EFI_POISONED_MEMORY table during EFI init --
before memblock hands memory to the buddy allocator -- and memblock_reserve()
each recorded frame, so a frame poisoned under a previous kernel is never
handed back out across a kexec. Entries a later unpoison cleared are skipped.

This mirrors the memreserve consume loop and runs from the same place, early
enough to keep the frames out of memblock and the buddy allocator.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/efi.c    |  3 +++
 drivers/firmware/efi/poison.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/efi.h           |  2 ++
 3 files changed, 58 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index f3b799930be44..1db041dce61ec 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -808,6 +808,9 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
+	if (efi_reserve_poisoned_memory())
+		return -ENOMEM;
+
 	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
 		efi_rt_properties_table_t *tbl;
 
diff --git a/drivers/firmware/efi/poison.c b/drivers/firmware/efi/poison.c
index ed3b8cee21ba6..971f131e6c556 100644
--- a/drivers/firmware/efi/poison.c
+++ b/drivers/firmware/efi/poison.c
@@ -4,6 +4,10 @@
  * record and clear poisoned frames so the next kexec kernel can keep them out
  * of its allocator.
  *
+ * Handling for the LINUX_EFI_POISONED_MEMORY configuration table: record and
+ * clear poisoned frames at runtime, and reserve frames inherited across a kexec
+ * before the allocator comes up, so the next kernel keeps them out.
+ *
  * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
  */
@@ -12,7 +16,9 @@
 
 #include <linux/efi.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
 #include <linux/sizes.h>
 #include <linux/spinlock.h>
 
@@ -125,3 +131,50 @@ void efi_hwpoison_unrecord_pfn(unsigned long pfn)
 		memunmap(pm);
 	}
 }
+
+/*
+ * Reserve every frame recorded in the poisoned-memory table inherited across
+ * kexec, before the page allocator is up. Called from efi_config_parse_tables().
+ */
+int __init efi_reserve_poisoned_memory(void)
+{
+	unsigned long ppm = efi.poisoned_memory;
+	unsigned int nr_poison = 0;
+	int i;
+
+	if (ppm == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
+	while (ppm) {
+		struct linux_efi_poisoned_memory *pm;
+		u8 *p;
+
+		p = early_memremap(ALIGN_DOWN(ppm, PAGE_SIZE), PAGE_SIZE);
+		if (!p) {
+			pr_err("Could not map poisoned-memory entry!\n");
+			return -ENOMEM;
+		}
+
+		pm = (void *)(p + ppm % PAGE_SIZE);
+
+		/* reserve the list entry itself */
+		memblock_reserve(ppm, struct_size(pm, entry, pm->size));
+
+		for (i = 0; i < atomic_read(&pm->count); i++) {
+			/* skip entries cleared by a later unpoison */
+			if (pm->entry[i].size) {
+				memblock_reserve(pm->entry[i].base,
+						 pm->entry[i].size);
+				nr_poison++;
+			}
+		}
+
+		ppm = pm->next;
+		early_memunmap(p, PAGE_SIZE);
+	}
+
+	if (nr_poison)
+		pr_info("reserved %u hardware-poisoned frame(s) inherited across kexec\n",
+			nr_poison);
+	return 0;
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd1b0934881fb..3dcfce7f593fb 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1293,9 +1293,11 @@ struct linux_efi_poisoned_memory {
 	/ sizeof_field(struct linux_efi_poisoned_memory, entry[0]))
 
 #ifdef CONFIG_EFI_POISONED_MEMORY
+int efi_reserve_poisoned_memory(void);
 void efi_hwpoison_record_pfn(unsigned long pfn);
 void efi_hwpoison_unrecord_pfn(unsigned long pfn);
 #else
+static inline int efi_reserve_poisoned_memory(void) { return 0; }
 static inline void efi_hwpoison_record_pfn(unsigned long pfn) { }
 static inline void efi_hwpoison_unrecord_pfn(unsigned long pfn) { }
 #endif

-- 
2.53.0-Meta


