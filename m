Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F8606D804
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IW3DEnuV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNeqyRn/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=RtmPL253ch29gIpiVq0xncUfpACHZ/Al//0T+QvAtTE=; b=IW3DEnuVacD1i3TSDPQWhNGcq7
	F1jaJfTiTTP5ZNgTnRoXaNsxAgxAjeOK8Eb4dFPKchPTM9UNO9dYoIKVqVIxiM4GzdC4JiVh0WFSJ
	vMYK76ghl7lTjjLRBTALLbpdUvXxLNr7eEUndyZ9hFlsg7EOCmcs3CkqWTXF/t3IUL3u3L6J94jCz
	Jp+x7RVBvGGml9Uohz+MMmYSQiA6BTaxtzRBo2YkrTx/BiMv15OAcGK6WhXoFP/omO4Jah9TvLsAg
	sqDwqnf67Xx2bsxRIsxbwsjkpRATMX2GEMz90g3WEDr1dsJFGXM8N4tIddpCoTjYJuCVVfrO/q2fO
	37+ju8Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdYu-00000005twt-2d6s;
	Wed, 04 Nov 2026 16:10:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdYs-00000005tw3-22ON
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:10:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 414F440408;
	Wed,  4 Nov 2026 16:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E891F000C1;
	Wed,  4 Nov 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793808606;
	bh=RtmPL253ch29gIpiVq0xncUfpACHZ/Al//0T+QvAtTE=;
	h=From:To:Cc:Subject:Date;
	b=RNeqyRn/+CAKNyHK1ZSpb5UjExecLIqj3fBVcdwXtDgwP3GD3K2oWn9O+BeR5f6iD
	 gGZm0g+KRIh1bAYuxnGOY7dka/dJSJwhjHuLo9AtAgtUQMB8+JzJC/vXfdcOgOXuV+
	 x8rM7hwQAAPtS3Uv3aDUO9tJqeRowSRCB3FUkfNs0xD75nb4gGYpepZQNYn0zO3/d6
	 cYqZOLjDi+J678FAqiQvZBY4gsD3kJYIPF3KVVYyO47J/cnVNVnWubmTePH9VfHsSA
	 COZG0AyNSJPa2/0DqmiVIPjBAKoInx1W+CZp2A9+plaaoM0ihnyQFKVr+eqDitlc2/
	 CzBSbSvni9abg==
From: Thorsten Blum <blum@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Changyuan Lyu <changyuanl@google.com>
Cc: Thorsten Blum <blum@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: Remove redundant 0x prefixes
Date: Wed,  4 Nov 2026 17:09:33 +0100
Message-ID: <20261104160931.137174-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=blum@kernel.org; h=from:subject; bh=oE3Ypxncsp4Y/KarKJNB8OKsSEs9/QmS2hxHg/unzIs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmvI3Zv1fppN+UXC/sW4+cuEwVuZ0kEFzycNW2lWOsqu 0Pbsz/d7ShlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJ9Lcw/GJerqB35l+QfSSr Wdwh7sD/8+cff3DT9HjaTcHL/yb9XnCckWHGcjeJtu83zJ+v0VZM1luzUJ5/3gkGga5Y+xarnes ZRHkA
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

Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3181..5f828eb44f75 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -2015,11 +2015,11 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
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

