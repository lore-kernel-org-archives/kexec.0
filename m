Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D656606AAC8
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ozGGUGlL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n//9uE/L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=JRqUizjEpje7QENpLEZU+9mQGGXBD071wudl9Jtl/K4=; b=ozGGUGlLUuIsvgjgTvFgTMhzEn
	XWIxxkyR7YFVMwJ2Zjd0v8JerlfGEUqCMlKl608JZ2rHam+jHJxebJ7TNq509tXT2BWM3rBbF5HsJ
	4zjQ+cw+DAzjYQ3qn5uLoF3c91k79cFL+mmZqC/6DxkMV84ZWhJ+FxU5fFGIzUeigU8ntKZMuIy6A
	9hDcumxSbP400XM4UPCPtfIo4b45hSPY/RCHIor0quPsQg0cBdLCjQW1pIT9TV70GYpNICJ++1BWo
	iUa4BNe3zCKsjIujsVyZhmESPT/kPHt/lIF7c832nqP/swrWaFTImqaugLR6TXB4+4rqH8K3VaO3U
	k7nCVQ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdms-00000005xvp-0jMr;
	Wed, 04 Nov 2026 16:24:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdmq-00000005xv9-1xTe
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:24:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 181AA4050F;
	Wed,  4 Nov 2026 16:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4F21F00919;
	Wed,  4 Nov 2026 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809472;
	bh=JRqUizjEpje7QENpLEZU+9mQGGXBD071wudl9Jtl/K4=;
	h=From:To:Cc:Subject:Date;
	b=n//9uE/LLh/XK+fni480r6cjyWYb7TawE+lJ+nlMCdKpTyZVWsyzuyi9q4dJ3a0f+
	 FSaZK19iz7N2ZTdqnnALa3Tq8GzwmpV9o+woIneY+hEQsVTMmNuMl2XbnDVunPV/mu
	 QIX7XP6AKzt6uxXGaZ0+ScBNIRv6Hifni0Ty4DM3oCbzUAmipAMNoVnQ3BzgxP6YdT
	 58oBYpOvPGVfbMePIccUJSrQ0EiCN/HAsLCtbieDkI2qhKGDq6x/j3CXxjGD+ctDCI
	 LRMjNyXSzBceNF2jnZ5+4dPhi9kfcNpslVLBo6S9ls7wJ78JiXfzKUTZc+j/6wsKnU
	 IIGuOjvE9TVDQ==
From: Thorsten Blum <blum@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>
Cc: Thorsten Blum <blum@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kho: Remove redundant 0x prefixes
Date: Wed,  4 Nov 2026 17:23:53 +0100
Message-ID: <20261104162352.140836-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=blum@kernel.org; h=from:subject; bh=Qk9hkzySWCprpSeEAqGuirPu9rol4ZAWn2j8lvg6CwU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmvYyQeFTc565/p2DvLqztdPTfhf6XmBhsuwXN+6qsWT VPLiGXsKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgImYBTH8jykpKDcz62y7q3BS Wj1pjn5WxF+GH+VRpktiF+lWsH5rYfhf/K0qlZVxe+qeGbw7fOc++HkzOmnZlg6NvitTV4ooXd/ LDQA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The %pa format specifier already includes the 0x prefix. Remove the
redundant prefixes to avoid printing 0x0x.

Use phys_addr_t for size to match the expected type.

Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Use phys_addr_t for size as suggested by Arnd (thanks!)
- v1: https://lore.kernel.org/r/20261104160931.137174-3-blum@kernel.org/

 kernel/liveupdate/kexec_handover.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3181..6a7600a0a7d5 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -2010,16 +2010,16 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 	 */
 	for (int i = 0; i < bootmem_cnt; i++) {
 		struct kho_bootmem *area = &bootmem[i];
-		u64 size = area->size;
+		phys_addr_t size = area->size;
 
 		memblock_add(area->addr, size);
 		err = memblock_mark_kho_noprsrv(area->addr, size);
 		if (err) {
-			pr_warn("failed to mark the bootmem region 0x%pa+0x%pa: %pe",
+			pr_warn("failed to mark the bootmem region %pa+%pa: %pe",
 				&area->addr, &size, ERR_PTR(err));
 			goto unmap_bootmem;
 		}
-		pr_debug("Marked 0x%pa+0x%pa as bootmem", &area->addr, &size);
+		pr_debug("Marked %pa+%pa as bootmem", &area->addr, &size);
 	}
 
 	memblock_reserve(bootmem_phys, bootmem_len);

