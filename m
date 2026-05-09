Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE8CCD3447
	for <kexec@archiver.kernel.org>; Sat,  9 May 2026 02:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BSqgWkTmMoRLkACDGwlR4gKjDv1T//Aj7QnUSlLg2Eo=; b=dOyQ+W5KUNZJsK2GWccXT4dTPR
	/Zm96wpqZhfU+bjMV2ffzBoXMCAJD2DeAXKGlF6wX0sbtZLjrWHKvLy2kW8CL4vymFfMARKgc8AQH
	iM1PqiIT4VUIB8VuuD2eTIJ3Ms/x4+0vx3cZSRnYLtNzeN+ZxaLrZa4u7QHqC9TwGFuSaxWdKb9Jl
	4SFgShlMkNBLcl6NGKm0zUL5gPK/4NzZPWCrW/8S8Zt+89LR0SJvghBV9BGTy58IsqG4zRrwGHEUW
	steTaDk/3wf/K1pLzvNf72PzA+RO6WIeofZjPLppjfMMEOxc8+hTlONlPtqpdaaMd1xcWepv72kQ/
	PMPx/24w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLXgF-000000082Z7-1ndl;
	Sat, 09 May 2026 02:44:39 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLXg9-000000082Y2-0y3V
	for kexec@lists.infradead.org;
	Sat, 09 May 2026 02:44:35 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778294666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BSqgWkTmMoRLkACDGwlR4gKjDv1T//Aj7QnUSlLg2Eo=;
	b=xUy4vFAbixh6ccBvc6N06p7dohIqY2K7iV+vh3HUhAT2hWxpCgRlv4Iy47g55bZFi9epqe
	C7hA+6vCLgFacE91u3oytN6xvrON8TEUclrnHMdMZazOYPWPsFqgyh3PsxtC9KirihkLMI
	CIphWMPNKh2s0gvqu8N8BsoCzUR8pu8=
From: George Guo <dongtai.guo@linux.dev>
To: pasha.tatashin@soleen.com,
	rppt@kernel.org,
	pratyush@kernel.org
Cc: graf@amazon.com,
	jasonmiu@google.com,
	ran.xiaokai@zte.com.cn,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>
Subject: [PATCH 1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
Date: Sat,  9 May 2026 10:44:15 +0800
Message-Id: <20260509024415.33190-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_194433_492623_B93F948A 
X-CRM114-Status: GOOD (  11.59  )
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

From: George Guo <guodongtai@kylinos.cn>

KHO_TREE_MAX_DEPTH is calculated as:

  DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
               KHO_TABLE_SIZE_LOG2) + 1

For systems with 16KB pages (e.g. LoongArch), this gives a depth of 4,
with the top-level shift at bit 39.  The order-0 bit sits at bit 50
(KHO_ORDER_0_LOG2 = 64 - PAGE_SHIFT = 50).  When inserting or reading
a key, the index extracted at the top level is:

  (1 << 50) >> 39 = 2048

2048 is exactly the table size (PAGE_SIZE / sizeof(phys_addr_t) = 2048
for 16KB pages), so it wraps to 0, aliasing the order bit to index 0
and losing it silently.

On the second kernel, kho_radix_decode_key() sees a key without the
order bit, calls fls64() on the wrong bit, computes a wrong order and
thus a garbage physical address. phys_to_page() of that address faults
in kho_preserved_memory_reserve(), causing a kernel panic early in boot.

Fix by adding +1 to the DIV_ROUND_UP numerator so the formula accounts
for the order bit itself, giving depth 5 for 16KB pages. The top-level
shift becomes 50, and (1 << 50) >> 50 = 1, which is nonzero and
unambiguous. For 4KB and 64KB page sizes the depth is unchanged.

Fixes: 3f2ad90060f6 ("kho: adopt radix tree for preserved memory tracking")

Tested-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/linux/kho/abi/kexec_handover.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
index 7e847a2339b0..db9bda6dd310 100644
--- a/include/linux/kho/abi/kexec_handover.h
+++ b/include/linux/kho/abi/kexec_handover.h
@@ -274,7 +274,7 @@ enum kho_radix_consts {
 	 * and 1 bitmap level.
 	 */
 	KHO_TREE_MAX_DEPTH =
-		DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
+		DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2 + 1,
 			     KHO_TABLE_SIZE_LOG2) + 1,
 };
 
-- 
2.25.1


