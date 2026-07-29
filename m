Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7700BC54F55
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9FCJr3mhqy7Y7W9bUA1VftkSAFbZe4TwxjPNvtu3TI=; b=U+f9cD7gb0UdAcpGqGKTAY7l7U
	UsVXpl8jxyalcpHTafjeez1KeNjA3csKa29Ol4ickFml65nkwSbx0EE9sGh/wVqtOuOsmP0DEpL/k
	A7uO26Ee9gVJmVoSpwFPSThQQ7214CWqH+DpQy5iEFAslLjSczhx/L7/36Uw8EZvQ2IAaxsU2ZqQZ
	eTpiG+6K8Im3SpVp/HvS7e2Bs62x5xviR/54pUeZIcg2fI8fpTbq9LRtMKb8JAzLVuG+LaMEv5HpO
	qSj7xcgtKfc3r8i7CDi/Kg+TfNSBN16B1Fp6nu9vA9+uRfPh6klv6PfaVoLDww70RiL53J57125wv
	lJxXpTOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5hu-00000008IxJ-1juJ;
	Wed, 29 Jul 2026 14:56:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5hs-00000008Iwf-34Im
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 14:56:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 288316011F;
	Wed, 29 Jul 2026 14:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F841F00A3E;
	Wed, 29 Jul 2026 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336987;
	bh=j9FCJr3mhqy7Y7W9bUA1VftkSAFbZe4TwxjPNvtu3TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jij6GyNUgIBoePjK7TyXRoecmHjNEYU8lCjAbIoboz5oGa0Zph2QNL/SrKOekfXu4
	 +FER5VqJf1YShzxZLFiPiCQfm2JukZ5X1elnPZzC6P24k4G4NF4QqK/1ktJm+/nYwz
	 6e6UgGIEi74cCfX/4Zn6TkQIo9y+yz8pejf51chbgpXPtFIf6KYLY/H5um5cKhDfm7
	 qcSPqSRgCjgMml1C05+8OrUaqWrCOwM5y8+CnBkrR4LmoYvgPUW7u+Pvz14MIR5dl1
	 HuWpo2pL9UuJoU+a8Iy076T7UAowH0hYRCCslGOgItVDhbvRZj4ceWE0bg2v+fLVbB
	 IyvTrYiL64+6A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/22] kho: make radix max key width more obvious
Date: Wed, 29 Jul 2026 16:55:47 +0200
Message-ID: <20260729145610.2827231-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729145610.2827231-1-pratyush@kernel.org>
References: <20260729145610.2827231-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

The KHO radix tree constants are somewhat hard to understand. The tree
depth essentially comes from the max key width. The max key width comes
from the need to store a 52-bit PFN plus one more bit for the order.

All this is very obscure with the corrent code. The PFN width is defined
as KHO_ORDER_0_LOG2, which makes very little sense to a new reader not
already familiar with what the value means. Then the fact that an extra
bit is needed is hidden in the KHO_TREE_MAX_DEPTH calculation.

Simplify this by removing KHO_ORDER_0_LOG2 and replace it with
KHO_RADIX_KEY_WIDTH. Update the comment to explain why this value is
used. This moves the +1 from KHO_TREE_MAX_DEPTH to KHO_RADIX_KEY_WIDTH,
making things clearer.

Update kho_{encode,decode}_radix_key() to not use KHO_ORDER_0_LOG2.
Instead, refactor the code and comments to make it clearer how the
encoding and decoding is done.

In kho_encode_radix_key(), add a new variable for the shift for physical
address. Use that in calculating where the order bit goes and in
calculating the shifted PFN. Update comments to make this clearer.

In kho_radix_decode_key(), turn order_bit to 0-indexed to simplify the
eventual calculation for order. Touch up comments to make the
computation clearer.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho/abi/kexec_handover.h |  9 +++------
 kernel/liveupdate/kexec_handover.c     | 19 +++++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 5e2eb8519bda..2f4fb9c63942 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -257,11 +257,8 @@ struct kho_vmalloc {
  * memory. These constants govern the indexing, sizing, and depth of the tree.
  */
 enum kho_radix_consts {
-	/*
-	 * The bit position of the order bit (and also the length of the
-	 * shifted physical address) for an order-0 page.
-	 */
-	KHO_ORDER_0_LOG2 = 64 - PAGE_SHIFT,
+	/* Need to store the PFN, plus one bit for order. */
+	KHO_RADIX_KEY_WIDTH = 64 - PAGE_SHIFT + 1,
 
 	/* Size of the table in kho_radix_node, in log2 */
 	KHO_TABLE_SIZE_LOG2 = const_ilog2(PAGE_SIZE / sizeof(phys_addr_t)),
@@ -274,7 +271,7 @@ enum kho_radix_consts {
 	 * and 1 bitmap level.
 	 */
 	KHO_TREE_MAX_DEPTH =
-		DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2 + 1,
+		DIV_ROUND_UP(KHO_RADIX_KEY_WIDTH - KHO_BITMAP_SIZE_LOG2,
 			     KHO_TABLE_SIZE_LOG2) + 1,
 };
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7349cc82f6dc..ea24f23ce292 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -97,10 +97,12 @@ static struct kho_out kho_out = {
  */
 static unsigned long kho_encode_radix_key(phys_addr_t phys, unsigned int order)
 {
-	/* Order bits part */
-	unsigned long h = 1UL << (KHO_ORDER_0_LOG2 - order);
-	/* Shifted physical address part */
-	unsigned long l = phys >> (PAGE_SHIFT + order);
+	/* The physical address is encoded by shifting the PFN by its order. */
+	unsigned long shift = PAGE_SHIFT + order;
+	/* Order bit goes right before the shifted PFN. */
+	unsigned long h = 1UL << (64 - shift);
+	/* Shifted PFN. */
+	unsigned long l = phys >> shift;
 
 	return h | l;
 }
@@ -118,12 +120,13 @@ static unsigned long kho_encode_radix_key(phys_addr_t phys, unsigned int order)
  */
 static phys_addr_t kho_decode_radix_key(unsigned long key, unsigned int *order)
 {
-	unsigned int order_bit = fls64(key);
+	/* fls64() indexes starting from 1. */
+	unsigned int order_bit = fls64(key) - 1;
 	phys_addr_t phys;
 
-	/* order_bit is numbered starting at 1 from fls64 */
-	*order = KHO_ORDER_0_LOG2 - order_bit + 1;
-	/* The order is discarded by the shift */
+	/* order bit goes right before the shifted PFN. */
+	*order = 64 - (PAGE_SHIFT + order_bit);
+	/* The order bit is discarded by the shift */
 	phys = key << (PAGE_SHIFT + *order);
 
 	return phys;
-- 
2.55.0.508.g3f0d502094-goog


