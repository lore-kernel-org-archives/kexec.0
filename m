Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9060A260C
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cU1l+msa;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HadoDkGA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=NBoEGBnT7tSwydHsRLRvuOQ+mNAaOzQ2uf7Uk5l8xaA=; b=cU1l+msaDY/RUzNo/IS9mUcp7o
	McBwBHUE+3IUhGG64HaiyyhmrWRAGKDU1tgumfzGpa8gyGQz8bgBe7gfNScPAy758ekY4VRlO57zh
	xC2h01rIV6UrF5gBDGhQaEtPRqTAGIZoDT51lutEQH9RXXJX87edtXc0om1APQ9GCkXz7VWNd1wqg
	A40n5TsCTRW4D189gcWHZDc+8x6F3DI7J8Z1qQLrXFpDifURrZs3W9eftwUQj0I0K3B4APXgooXOm
	gIFvTSlJc64VhExK6qDhN+USM7kq0givxXBFl89i6mY3teFDH9YLYrV17kJ9HPb18dyOqBuaLlg8/
	yRRWmIuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKbN-00000002aPI-3NRk;
	Mon, 26 Oct 2026 13:19:01 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLKbK-00000002aOf-3S8I
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 13:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793020736; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NBoEGBnT7tSwydHsRLRvuOQ+mNAaOzQ2uf7Uk5l8xaA=;
	b=HadoDkGAFmWAMLai2uUm3T7JlfLeQemCTwksRS6S+tn7tskHW63KrgjUOBt2EUk2dA5Au8PtX7yeKLqFKoGXTq8kmOcRzu+ET4iwyE5uuThC0Lyn8gJ5o+i5hG1lEbs/ghHY6Cie8dvC5tUSHo7W7Mu6vKBYY35SFF1YKVQ4ou0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XDYkXyw_1793020730;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XDYkXyw_1793020730 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 21:18:54 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	graf@amazon.com
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: Skip zero-sized bootmem areas
Date: Mon, 26 Oct 2026 21:18:51 +0800
Message-ID: <20261026131851.9942-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_061859_401759_692E17CB 
X-CRM114-Status: GOOD (  10.77  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The lowmem and the global bootmem area are reserved unconditionally,
while the per-node loop below already skips nodes whose size works out
to 0. Either can legitimately be 0: the global size is the scaled total
minus the lowmem one, so it is 0 whenever all measured reservations fit
below ARCH_LOW_ADDRESS_LIMIT.

Reserving 0 bytes still succeeds, so an area covering nothing gets
recorded with a valid address. That is not neutral:
kho_bootmem_overlap() reports an overlap for any request straddling
that address, and memblock_alloc_hugetlb() aligns a request to its page
size, so a 1G hugetlb allocation retries a free candidate on account of
an area that holds nothing.

A machine whose memory all starts at or above ARCH_LOW_ADDRESS_LIMIT
hits the other side of the same code: the lowmem size is 0, the range
below the limit is empty, the allocation fails and KHO is disabled
although no lowmem area was needed.

Skip a zero-sized area instead, as the per-node loop does. The
descriptor count stays consistent, as kho_populate() derives it from
the segment length that kho_fill_kimage() serialises.

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 kernel/liveupdate/kexec_handover.c | 38 +++++++++++++++++-------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 6f1f55fe3..c9c9fdfac 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -853,28 +853,32 @@ static void __init kho_reserve_bootmem(void)
 	 * next kernel
 	 */
 	size = bootmem_size_lowmem;
-	addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
-					 ARCH_LOW_ADDRESS_LIMIT);
-	if (!addr) {
-		pr_err("Failed to reserve lowmem bootmem\n");
-		goto err_free_bootmem_desc;
-	}
+	if (size) {
+		addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES,
+						 0, ARCH_LOW_ADDRESS_LIMIT);
+		if (!addr) {
+			pr_err("Failed to reserve lowmem bootmem\n");
+			goto err_free_bootmem_desc;
+		}
 
-	kho_bootmem[i].addr = addr;
-	kho_bootmem[i].size = size;
-	i++;
+		kho_bootmem[i].addr = addr;
+		kho_bootmem[i].size = size;
+		i++;
+	}
 
 	/* reserve large contiguous area for allocations without nid */
 	size = bootmem_size_global;
-	addr = memblock_phys_alloc(size, BOOTMEM_ALIGNMENT_BYTES);
-	if (!addr) {
-		pr_err("Failed to reserve global bootmem\n");
-		goto err_free_bootmem_areas;
-	}
+	if (size) {
+		addr = memblock_phys_alloc(size, BOOTMEM_ALIGNMENT_BYTES);
+		if (!addr) {
+			pr_err("Failed to reserve global bootmem\n");
+			goto err_free_bootmem_areas;
+		}
 
-	kho_bootmem[i].addr = addr;
-	kho_bootmem[i].size = size;
-	i++;
+		kho_bootmem[i].addr = addr;
+		kho_bootmem[i].size = size;
+		i++;
+	}
 
 	/*
 	 * Loop over nodes that have both memory and are online. Skip
-- 
2.50.1


