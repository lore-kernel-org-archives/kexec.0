Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFEEEB595C
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 03:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Pofqhw8hhVYRB6tvSmJBYOSQQUpinLxB4MYSnGPSGU=; b=Nwi8Eh131dwVD77+zeu2Swunni
	hSR1LaTkoWA41gE1NS+H3a6jt+iWOToT53rHCQGXkpRkHihaj+gQZSx26s6Qv2tBMWP5u+RQYgTmH
	5zkCGGSNAdx22SJW3Da9QY+p4VhLkNs/cxXKUwpIdCiYBcQETpf4JRAbdhxgH4vHivq11p3rlKC0x
	2ZyPP/aNBMHwgNIxTuIknys0IFALcQ5+O5RZtgB/p1ByaKvaTVBBf1w56PEzppsQBZoNx6EfIUhqv
	LxyNeFuFfwHjlznHf0jHipGbg/z+9JdVVS+uG9T6y1ph7XcUqacFmv2yTTDV/l8V9hIAYhdrPUJ/P
	n/nYmewg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0vg-000000009h8-0EvL;
	Wed, 11 Feb 2026 03:30:16 +0000
Received: from m16.mail.163.com ([117.135.210.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0vY-000000009fq-38Cu
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 03:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2P
	ofqhw8hhVYRB6tvSmJBYOSQQUpinLxB4MYSnGPSGU=; b=HceFhu3nMRYyko5zy2
	oGVdYUY0A2rx3paMDWFBi9XZ9gwjiIg8O24PLF8VuWKOl55eHYKqAbOVAT3F4dbL
	pH55QEJ5DBwwZRUyml4unUKSe95YlbBuzIuqqldYwNKT9BijQfrNW9FRzHKNs9Fe
	cNcXtTlBJi9ctae7GjgsqBvmo=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3f96j94tpMZp0RA--.2981S3;
	Wed, 11 Feb 2026 11:29:41 +0800 (CST)
From: ranxiaokai627@163.com
To: graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH v2 1/2] kho: fix missing early_memunmap() call in kho_populate()
Date: Wed, 11 Feb 2026 03:29:36 +0000
Message-ID: <20260211032937.208353-2-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211032937.208353-1-ranxiaokai627@163.com>
References: <20260211032937.208353-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgC3f96j94tpMZp0RA--.2981S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4fAF1rGFWrJF13Zr1fWFg_yoW8AFWUpr
	yfGa4fAw40qayjqa17J3Wfu34rK3ykt3W3ta4UC34SyrnrXwn7A3yIq3Z2yF12qr9ag3W7
	tF4FyayrW3W8CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zErcTPUUUUU=
X-Originating-IP: [117.176.243.201]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbC7gZksGmL96afRQAA3V
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_193009_174440_38EB91C4 
X-CRM114-Status: UNSURE (   9.95  )
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

kho_populate() returns without calling early_memunmap() on success
path, this will cause early ioremap virtual address space leak.

Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/liveupdate/kexec_handover.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index fb3a7b67676e..3c705b08a489 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1463,13 +1463,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	struct kho_scratch *scratch = NULL;
 	phys_addr_t mem_map_phys;
 	void *fdt = NULL;
+	bool populated = false;
 	int err;
 
 	/* Validate the input FDT */
 	fdt = early_memremap(fdt_phys, fdt_len);
 	if (!fdt) {
 		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
-		goto err_report;
+		goto report;
 	}
 	err = fdt_check_header(fdt);
 	if (err) {
@@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.scratch_phys = scratch_phys;
 	kho_in.mem_map_phys = mem_map_phys;
 	kho_scratch_cnt = scratch_cnt;
-	pr_info("found kexec handover data.\n");
 
-	return;
+	populated = true;
+	pr_info("found kexec handover data.\n");
 
 err_unmap_scratch:
 	early_memunmap(scratch, scratch_len);
 err_unmap_fdt:
 	early_memunmap(fdt, fdt_len);
-err_report:
-	pr_warn("disabling KHO revival\n");
+report:
+	if (!populated)
+		pr_warn("disabling KHO revival\n");
 }
 
 /* Helper functions for kexec_file_load */
-- 
2.25.1



