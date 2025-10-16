Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406CFCCD183
	for <kexec@archiver.kernel.org>; Thu, 16 Oct 2025 20:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hZ7ypki6CuYeCryqFiqKvWXs+ZzivlIk6Wotvz3thCw=; b=YFaTCDgsCjJaRVyGEhyYaa+JZF
	zDyxfizN06pozLncCQLnLDB3jNnFg88f9HAXNAa0GIW4jQzl91bcFL68WhP5MNwCw0E9ZzcKy3e3X
	JqzaOJu/LkkidnzUNgb15DwKm1dV6enJb3PdCOW1IqkD3XMTQG0ctItcqa3mpIITNOID45FN23S5H
	lX1e7rxvUIuOheqwmIXn473LemjWMN3hChQJFZCDXgVqAUVXcTAqXEPzoI3Kv7IX5U3Ep0290mEu3
	1eEe21+hOW1SbgKotd65Rtz7guA6ySXorg00Q+dQ4r4LrcGUx+lCufBYztvyAyH81qxaXAK6k1s54
	69kRzArw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9UEN-00000005qxH-1yiJ;
	Thu, 16 Oct 2025 20:05:47 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9UEL-00000005qe5-0scp
	for kexec@lists.infradead.org;
	Thu, 16 Oct 2025 20:05:46 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760645015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZ7ypki6CuYeCryqFiqKvWXs+ZzivlIk6Wotvz3thCw=;
	b=flz0HAWN9ApGK0shi3gJ6lDvw6V/IDIeGbU0w236HwES7BzMdLM7w32ZObrecuORBGSmgQ
	FQQjch2XhrH5Qanf4V5CmEt38sbrZshz/ra8CGvuFgJxDEBHQ94ruiCClH7DkegUxbv5QO
	jlNAQ6l5GuPhcb/HZmLzIvK7x4NPHbA=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: kexec@lists.infradead.org,
	linux-mm@kvack.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	graf@amazon.com,
	rppt@kernel.org,
	changyuanl@google.com,
	akpm@linux-foundation.org,
	bhe@redhat.com
Subject: [PATCH 1/1] kexec: Use %pe format specifier for error pointer printing
Date: Thu, 16 Oct 2025 20:03:20 +0000
Message-ID: <20251016200320.4179702-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_130545_412734_031F0620 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
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

Make pr_xxx() call to use the %pe format specifier instead of %d.
The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
-EINVAL) when given an error pointer created with ERR_PTR(err).

This change enhances the clarity and diagnostic value of the error
message by showing a descriptive error name rather than a numeric
error code.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: graf@amazon.com
CC: rppt@kernel.org
CC: changyuanl@google.com
CC: akpm@linux-foundation.org
CC: bhe@redhat.com

---
 kernel/kexec_handover.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb485..77af377022b0 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1095,7 +1095,7 @@ static int kho_abort(void)
 	err = notifier_to_errno(err);
 
 	if (err)
-		pr_err("Failed to abort KHO finalization: %d\n", err);
+		pr_err("Failed to abort KHO finalization: %pe\n", ERR_PTR(err));
 
 	return err;
 }
@@ -1142,7 +1142,7 @@ static int kho_finalize(void)
 
 abort:
 	if (err) {
-		pr_err("Failed to convert KHO state tree: %d\n", err);
+		pr_err("Failed to convert KHO state tree: %pe\n", ERR_PTR(err));
 		kho_abort();
 	}
 
@@ -1355,8 +1355,8 @@ static __init int kho_in_debugfs_init(const void *fdt)
 		err = kho_debugfs_fdt_add(&kho_in.fdt_list, sub_fdt_dir, name,
 					  phys_to_virt(*fdt_phys));
 		if (err) {
-			pr_warn("failed to add fdt `%s` to debugfs: %d\n", name,
-				err);
+			pr_warn("failed to add fdt `%s` to debugfs: %pe\n", name,
+				ERR_PTR(err));
 			continue;
 		}
 	}
@@ -1400,8 +1400,8 @@ static __init int kho_init(void)
 		 * kexec.
 		 */
 		if (err)
-			pr_err("failed exposing handover FDT in debugfs: %d\n",
-			       err);
+			pr_err("failed exposing handover FDT in debugfs: %pe\n",
+			       ERR_PTR(err));
 
 		return 0;
 	}
@@ -1524,8 +1524,8 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		memblock_add(area->addr, size);
 		err = memblock_mark_kho_scratch(area->addr, size);
 		if (WARN_ON(err)) {
-			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %d",
-				&area->addr, &size, err);
+			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
+				&area->addr, &size, ERR_PTR(err));
 			goto out;
 		}
 		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
@@ -1553,7 +1553,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	if (scratch)
 		early_memunmap(scratch, scratch_len);
 	if (err)
-		pr_warn("disabling KHO revival: %d\n", err);
+		pr_warn("disabling KHO revival: %pe\n", ERR_PTR(err));
 }
 
 /* Helper functions for kexec_file_load */
-- 
2.51.0


