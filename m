Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488B8CF8861
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C21VWiTFnCtjKUC3lRTNib5t5KU/n8R+0YWZGg6WN4c=; b=W6JV+BVKanvAmPgG97kr2wJc/r
	XzzIvBL2ZAnxCE6NkJjj2ZLNL0HbZQaPgWOqnjim8HUyzVtk5e4NII29dxV+opjSXwCSPtap3PEXP
	AOz6LT+RCbfjE8G+gbBi/705vc0L/ov7voBaVfJmteyV1ZbrZGNGpYJqXcU1ohUd8vXRNbuw0Qzd5
	eADhXX71vV8sdeV7zcZx8E5e2n6tYoeub8WaaPACs3wCHTUG68ETLZUdUFHCpRtrbLnSvBkrWmaBZ
	tbAwvvishQpywM/rIGiW9pZsadub+akk2mEVGwi0PEjKa7MP+AsEQY6mzH3H3gq2PG3K/o1c3YT/p
	oRfmCtmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM5sE-00000006rf8-2nXN;
	Thu, 20 Nov 2025 14:43:02 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM5s9-00000006rc0-3O8B
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 14:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=C2
	1VWiTFnCtjKUC3lRTNib5t5KU/n8R+0YWZGg6WN4c=; b=YFhlBDO+wGNN1bMmpY
	2qb/OX6/Mho6hh50nJn0j4E+Yf5o2M/RCV8iDnbqUEQ4ys/Lc1AuUDKfwYQN792v
	zBkZRsZD938tJhpCzPqFBrylDLRy1XFGCUfoAqHFb1ywCa93l1kzzgzonMTKKQfO
	y/yg9YsUNLwblZTUiUr/Q2TUo=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wA3yJmuKB9pTEQrBQ--.727S3;
	Thu, 20 Nov 2025 22:41:53 +0800 (CST)
From: ranxiaokai627@163.com
To: catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	changyuanl@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH 1/2] mm: kmemleak: introduce kmemleak_no_scan_phys() helper
Date: Thu, 20 Nov 2025 14:41:46 +0000
Message-ID: <20251120144147.90508-2-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120144147.90508-1-ranxiaokai627@163.com>
References: <20251120144147.90508-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3yJmuKB9pTEQrBQ--.727S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry8XF4rKrW5Wry7tF43Wrg_yoW5Zr47pF
	Z7Cry7GFW7Xa4Uua9Fva48Zw4DJws7GF1aya42kwnxZF90vFn7Aw4fCrZFyFy5Jr97Gr4Y
	vrWxtFZ0kr48J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piXyCPUUUUU=
X-Originating-IP: [117.176.242.6]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbBEAcMTGkfJUZRigAAsZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_064258_232580_40902D82 
X-CRM114-Status: GOOD (  10.90  )
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

Introduce kmemleak_no_scan_phys(phys_addr_t), a physical-address
variant to kmemleak_no_scan(). This helper marks memory regions
as non-scanable using physical addresses directly.

It is specifically designed to prevent kmemleak from accessing pages
that have been unmapped by debug_pagealloc after being freed to
the buddy allocator. The kexec handover (KHO) subsystem will call
this helper to exclude the kho_scratch reservation region from scanning,
thereby avoiding fatal page faults during boot when debug_pagealloc=on.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/kmemleak.h |  4 ++++
 mm/kmemleak.c            | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index fbd424b2abb1..e955ad441b8a 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -31,6 +31,7 @@ extern void kmemleak_ignore(const void *ptr) __ref;
 extern void kmemleak_ignore_percpu(const void __percpu *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
+extern void kmemleak_no_scan_phys(phys_addr_t phys) __ref;
 extern void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
 				gfp_t gfp) __ref;
 extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
@@ -113,6 +114,9 @@ static inline void kmemleak_erase(void **ptr)
 static inline void kmemleak_no_scan(const void *ptr)
 {
 }
+static inline void kmemleak_no_scan_phys(phys_addr_t phys)
+{
+}
 static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
 				       gfp_t gfp)
 {
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1ac56ceb29b6..b2b8374e19c3 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1058,12 +1058,12 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
  * pointer. Such object will not be scanned by kmemleak but references to it
  * are searched.
  */
-static void object_no_scan(unsigned long ptr)
+static void object_no_scan_flags(unsigned long ptr, unsigned long objflags)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
 
-	object = find_and_get_object(ptr, 0);
+	object = __find_and_get_object(ptr, 0, objflags);
 	if (!object) {
 		kmemleak_warn("Not scanning unknown object at 0x%08lx\n", ptr);
 		return;
@@ -1328,10 +1328,19 @@ void __ref kmemleak_no_scan(const void *ptr)
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		object_no_scan((unsigned long)ptr);
+		object_no_scan_flags((unsigned long)ptr, 0);
 }
 EXPORT_SYMBOL(kmemleak_no_scan);
 
+void __ref kmemleak_no_scan_phys(phys_addr_t phys)
+{
+	pr_debug("%s(%pap)\n", __func__, &phys);
+
+	if (kmemleak_enabled)
+		object_no_scan_flags((unsigned long)phys, OBJECT_PHYS);
+}
+EXPORT_SYMBOL(kmemleak_no_scan_phys);
+
 /**
  * kmemleak_alloc_phys - similar to kmemleak_alloc but taking a physical
  *			 address argument
-- 
2.25.1



