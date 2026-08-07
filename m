Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EA5C5AC82
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 07:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ju9jVDtUROVT4vprabE7GarFhrUjpoWcikAa8ZbwGRo=; b=1b+HNqcb5+B5ARRqWcmcwp0jaQ
	zgRjdDqK2Nilxs2vYqGtF5sJDbRKeYPlJAiIEkeHgMslcaI8cLobuiwWeytzr60I8M6J6P7AaTdI6
	lJk6eAz2jLs4UULmAprjwK1Ev+vf+mphy/GDKQLIRY69FDSP8ImC+2kl3Di59EnZmmXtSaQKCVaSs
	1EtcMna3c/fRS/oFLIizLrDYHt7wz78ZKAzPBY/tvoWj4OLvHCyuN4AF+03blIq7WEjSK78cJomfW
	TQGtuTfMWO/aKLGdN90o4BfvyxmG+QrNVM5WwAgqcUYODdX+NWk8xEEZaSt2cWa+MI5oWm9NnqAYW
	2KLJehsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFN3-00000007Ity-2qfH;
	Fri, 07 Aug 2026 07:52:01 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsFMs-00000007Irc-2QAW
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 07:51:57 +0000
X-UUID: d0fce1aa923411f1aa26b74ffac11d73-20260807
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9cbef195-252b-4aa5-8b05-af006c4c3798,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:9cbef195-252b-4aa5-8b05-af006c4c3798,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:c8296ac799a20adaa64dd19fac0165fc,BulkI
	D:260807155139A72UEW7B,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d0fce1aa923411f1aa26b74ffac11d73-20260807
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.104.44.99)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 303652395; Fri, 07 Aug 2026 15:51:36 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org,
	graf@amazon.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn
Subject: [PATCH v1 2/2] kho: unwind restored pages on kho_restore_vmalloc error
Date: Fri,  7 Aug 2026 15:51:28 +0800
Message-Id: <20260807075128.542806-3-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807075128.542806-1-duanchenghao@kylinos.cn>
References: <20260807075128.542806-1-duanchenghao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_005150_907655_616370C1 
X-CRM114-Status: GOOD (  10.13  )
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

In kho_restore_vmalloc(), when kho_restore_pages() succeeds, the
recovered pages are handed to the buddy allocator (via
adjust_managed_page_count()). If any later step (e.g.
__get_vm_area_node() or vmap_pages_range()) fails, the original error
path only called kvfree(pages), leaking those folio pages.

Fix by tracking how many folio groups have been restored with
restored_idx. On any failure, use err_unwind_restored to walk
restored_idx backwards and return each folio group to the buddy via
__free_pages() before freeing the pages array.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ba03ff5baa9e..ed35405f59ab 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1161,6 +1161,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 	struct vm_struct *area;
 	struct page **pages;
 	unsigned int idx = 0;
+	unsigned int restored_idx = 0;
 	int err;
 
 	vm_flags = kho_flags_to_vmalloc(preservation->flags);
@@ -1183,11 +1184,11 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 			phys_addr_t phys = chunk->phys[i];
 
 			if (idx + contig_pages > total_pages)
-				goto err_free_pages_array;
+				goto err_unwind_restored;
 
 			page = kho_restore_pages(phys, contig_pages);
 			if (!page)
-				goto err_free_pages_array;
+				goto err_unwind_restored;
 
 			for (int j = 0; j < contig_pages; j++)
 				pages[idx++] = page + j;
@@ -1195,13 +1196,14 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 
 		page = kho_restore_pages(virt_to_phys(chunk), 1);
 		if (!page)
-			goto err_free_pages_array;
+			goto err_unwind_restored;
+		restored_idx = idx;
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
 		__free_page(page);
 	}
 
 	if (idx != total_pages)
-		goto err_free_pages_array;
+		goto err_unwind_restored;
 
 	area = __get_vm_area_node(total_pages * PAGE_SIZE, align, shift,
 				  vm_flags | VM_UNINITIALIZED,
@@ -1209,7 +1211,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 				  NUMA_NO_NODE, GFP_KERNEL,
 				  __builtin_return_address(0));
 	if (!area)
-		goto err_free_pages_array;
+		goto err_unwind_restored;
 
 	addr = (unsigned long)area->addr;
 	size = get_vm_area_size(area);
@@ -1231,7 +1233,16 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 
 err_free_vm_area:
 	free_vm_area(area);
-err_free_pages_array:
+err_unwind_restored:
+	/*
+	 * Pages already restored via kho_restore_pages() have been given to
+	 * the buddy allocator (via adjust_managed_page_count()). Return them
+	 * to the buddy so that failure leaves the system in a clean state.
+	 */
+	while (restored_idx > 0) {
+		restored_idx -= contig_pages;
+		__free_pages(pages[restored_idx], order);
+	}
 	kvfree(pages);
 	return NULL;
 }
-- 
2.25.1


