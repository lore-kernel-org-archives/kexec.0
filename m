Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BCDEB4901
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GgM6lCDjzNogkk3QpfIH7skqXJaQ5cQhN9X8oPB+HkM=; b=BKC2Y5T1k1mlrgBPD3Hz7AfUwf
	fCb5Tt4vNLLxnRYwqSmFk8pnm3clh7yyzukLov7cLCJUNwFmjsmYwbrHb7RW6xV4wRcS4Cnpxola7
	dFko4292QWnwBmiAG1lr6SAFbsNNcaTl3wCfff434khpGqd+6My4opdc7XCB1qALdKMxibs//qQCS
	7qx4Wlqp2tAm4Y1w0x6fMHQR8m9N3Qr1JYJ3WfbpaRWlKnNNJrTbfmkIFE2DuOf/KjDPUZ54vmmo+
	AJaBo37L9l6qJe0qVVuO4ZMpewrlqS7pCZiOCG1zgdDdEiODBJZz97dm3dIfkZo2ME4r/b+2P0uK0
	QeAhupWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUcp-00000001yZk-2Jea;
	Thu, 12 Feb 2026 11:12:47 +0000
Received: from m16.mail.163.com ([117.135.210.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUcj-00000001yYm-1fng
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 11:12:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gg
	M6lCDjzNogkk3QpfIH7skqXJaQ5cQhN9X8oPB+HkM=; b=dDM0Zc/JV5DqMGaARJ
	s4AMvreH8VlIclJkp0F0PTUdrrtyYuBa1ZerR5Kz5I9LjgzlHnFP5yGB2zqC1lpv
	QiKhLD4HjYd1fL41jcYcJJIgaDB0juEu4k+NOelOCCb+S1mzqmHn00MTZ3T70b17
	yJaRui2oIcOx+ue+4STSWHhDk=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHZLl0tY1ptkijLg--.48890S3;
	Thu, 12 Feb 2026 19:11:51 +0800 (CST)
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
Subject: [PATCH v3 1/2] kho: fix missing early_memunmap() call in kho_populate()
Date: Thu, 12 Feb 2026 11:11:45 +0000
Message-ID: <20260212111146.210086-2-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212111146.210086-1-ranxiaokai627@163.com>
References: <20260212111146.210086-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHZLl0tY1ptkijLg--.48890S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry8Gw4rWry8KF1rGr13CFg_yoW5Wr4fpF
	ySg3s3Cw48tayYq3y7Ja10g345trZ5t3W3tayUCryfJrnFvFnxA3yxt3Wvyr42qr9aqw1U
	KF40vayrWw1UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_NtxJUUUUU=
X-Originating-IP: [218.203.227.87]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxRdIlGmNtXeS8QAA3L
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_031242_672623_6D679B70 
X-CRM114-Status: UNSURE (   9.93  )
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
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/liveupdate/kexec_handover.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index fb3a7b67676e..af82d8862dd7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1463,36 +1463,37 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
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
 		pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
 			fdt_phys, err);
-		goto err_unmap_fdt;
+		goto unmap_fdt;
 	}
 	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
 	if (err) {
 		pr_warn("setup: handover FDT (0x%llx) is incompatible with '%s': %d\n",
 			fdt_phys, KHO_FDT_COMPATIBLE, err);
-		goto err_unmap_fdt;
+		goto unmap_fdt;
 	}
 
 	mem_map_phys = kho_get_mem_map_phys(fdt);
 	if (!mem_map_phys)
-		goto err_unmap_fdt;
+		goto unmap_fdt;
 
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {
 		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
 			scratch_phys, scratch_len);
-		goto err_unmap_fdt;
+		goto unmap_fdt;
 	}
 
 	/*
@@ -1509,7 +1510,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		if (WARN_ON(err)) {
 			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
 				&area->addr, &size, ERR_PTR(err));
-			goto err_unmap_scratch;
+			goto unmap_scratch;
 		}
 		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
 	}
@@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	kho_in.scratch_phys = scratch_phys;
 	kho_in.mem_map_phys = mem_map_phys;
 	kho_scratch_cnt = scratch_cnt;
-	pr_info("found kexec handover data.\n");
 
-	return;
+	populated = true;
+	pr_info("found kexec handover data.\n");
 
-err_unmap_scratch:
+unmap_scratch:
 	early_memunmap(scratch, scratch_len);
-err_unmap_fdt:
+unmap_fdt:
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



