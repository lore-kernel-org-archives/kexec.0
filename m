Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1682CEE34A
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=394+H/Toca3IhEDlevEbnwpMVzzRkjVMci3ILAhLtJM=; b=SEkUuYhS5FfT6DAFUQUgEjpicf
	jH6RnGzEOmhS6ViuZ8PrwKiqGwYxelt84OSRDLIcmJkVj+h9cC2Wj2fzdapB4N4Xm/Zx4uizyJA0P
	45O4ZX1vIauDfb9DrIJBAd2FFTh3m8CkScydPAt76ez9ieB362a+VE2v9ziU0cYHXTNus7cXOXsKN
	fMJnz1QRKraHdRzn9IrryIC9/b0+vqyulEqCNU+ha+wRtVdBPnD7+aV9Z3J7SnV/JWET93ZIPyfm2
	HGoOLof2Ixd+jxIBfofwtsP07QAzfMfQTFJQlO5f4zHeW+fGVp2UV5ogiR9WCFtf59mCmDNkT+YHP
	cHJptZqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQLS-00000000vPN-0Ar2;
	Tue, 18 Nov 2025 18:22:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLQLP-00000000vOi-42sI
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 18:22:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3A8F841A35;
	Tue, 18 Nov 2025 18:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E85EC116B1;
	Tue, 18 Nov 2025 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763490142;
	bh=uzS720AirCAjrMk0zf7E+fhaADPKoEUqjQkc9kLBcHM=;
	h=From:To:Cc:Subject:Date:From;
	b=N2Lpuo2gjYgnW1qXmgvYExPmrxjrbXMnmciJEvMO2ppCTNo9jYroJ4Qt5fNf5Dejm
	 2Eoi5IKxD7jLGCpyN49cQ3ynn7AyFb4n9DveQ+GsmXnBX4wsVd/0yJXJ4PbYF3JCOU
	 2HbUAWCaJtfVer2FyB7TzlipCCzuWoMpHlykP8oVOjdtALt6fBOrzVJN5WU55CbhYW
	 pYd4sovXWm1lsYK/3pSbyup1udeW0/RTPfRXV/OIgaKEcs1qCDPQPStXxyJPCpyEL1
	 g63+BWAOExeD3zpDrPJyBSmqeX6T3Rk+RMfbwdTvw48MsE1DlszyWusQ/efDdc0vS7
	 yP49q1AvL5VJA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: free chunks using free_page() instead of kfree()
Date: Tue, 18 Nov 2025 19:22:16 +0100
Message-ID: <20251118182218.63044-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_102224_040784_9442F79E 
X-CRM114-Status: GOOD (  10.56  )
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

Before commit fa759cd75bce5 ("kho: allocate metadata directly from the
buddy allocator"), the chunks were allocated from the slab allocator
using kzalloc(). Those were rightly freed using kfree().

When the commit switched to using the buddy allocator directly, it
missed updating kho_mem_ser_free() to use free_page() instead of
kfree().

Fixes: fa759cd75bce5 ("kho: allocate metadata directly from the buddy allocator")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---

Notes:
    Commit 73976b0f7cefe ("kho: remove abort functionality and support state
    refresh") made this bug easier to trigger by providing a deterministic
    method to trigger freeing of the chunks.

 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 515339fa526e0..6497fe68c2d24 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -360,7 +360,7 @@ static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
 		struct khoser_mem_chunk *tmp = chunk;
 
 		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
-		kfree(tmp);
+		free_page((unsigned long)tmp);
 	}
 }
 

base-commit: f0bfdc2b69f5c600b88ee484c01b213712c63d94
prerequisite-patch-id: f54df1de9bdcb4fe396940cdcc578f5adcc9397c
prerequisite-patch-id: 800ec910c37120fd77aff1fad8ec10daaeaeddb1
-- 
2.47.3


