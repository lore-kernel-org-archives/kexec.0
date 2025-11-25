Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F7D0E6C7
	for <kexec@archiver.kernel.org>; Tue, 25 Nov 2025 11:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLudhvToMeKdi9ZoJPE+kAOPQdbLossQ5hWDi0Y+cLA=; b=ynATC+zBRBQXpogssx44C1VncE
	AErhUmQGinJomz8kstFH73S5xzCcW6gJ8BGJVDYVP4gn8dgYBHQNqBIEbmMSmATaWsIqgLniO9m0U
	CIQ0eLUgROyihJ6P3K0gL+gOt5B+NflimuktcuLEtkmIHW2l2tJCcQB/a753cP5z65ghCjlMRBiLs
	x0NOcvib8OrR70cIk4b14h6HbWp/rD1e8cPgusqGvhvdwG6OqLkqvfavV2oznC92W3k9je++VDvwr
	IgmU45Iile/rUASHK1jjAwB4giZ6HduQDip0Wnca2XOJE4yoLVH9pOzK3MYwXklh8HOvyC8QkqAXX
	C+AqC+Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqvJ-0000000DBd8-3yWb;
	Tue, 25 Nov 2025 11:09:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNqvG-0000000DBbU-3PWf
	for kexec@lists.infradead.org;
	Tue, 25 Nov 2025 11:09:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E7F96018C;
	Tue, 25 Nov 2025 11:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5D3C116B1;
	Tue, 25 Nov 2025 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764068965;
	bh=tl0WK0vKXJu7BGS4fSCa6MdaVgIDRX4gqgHFUZ7FCvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbnlXt4vHwhp3etx/I2CyBGBAEisjkzEBHPcohG60xGiIC2LCcCaadt9eBE5cTRuQ
	 IH8TsX9arsUjYD7UGW81qx/k5gn+ElbZ2oOta0wgR7UasVfPoXTs4M+2IbevAwTGL2
	 vD6tuNrdOEWObS30ep/vIBJSSZtytYYFm4poTr71FvNMwxHJr8vk1m7AQxpzda4eIX
	 1zQBl3vcEjdiqCjairTRFNGZXKNel9ojJ7dDIelhQ37jOwDq916GlbdDc35oUbppWx
	 e6EzScsu+5yFNTNhF/1M0CpKcUa9XG7P1PvND4uQtVtWo1hs0jXm50lrFblQKlUOod
	 h9TFZXswX5hWg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kho: kho_restore_vmalloc: fix initialization of pages array
Date: Tue, 25 Nov 2025 13:09:16 +0200
Message-ID: <20251125110917.843744-2-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125110917.843744-1-rppt@kernel.org>
References: <20251125110917.843744-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

In case a preserved vmalloc allocation was using huge pages, all pages in
the array of pages added to vm_struct during kho_restore_vmalloc() are
wrongly set to the same page.

Fix the indexing when assigning pages to that array.

Fixes: a667300bd53f ("kho: add support for preserving vmalloc allocations")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5809c6fe331c..e64ee87fa62a 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1096,7 +1096,7 @@ void *kho_restore_vmalloc(const struct kho_vmalloc *preservation)
 				goto err_free_pages_array;
 
 			for (int j = 0; j < contig_pages; j++)
-				pages[idx++] = page;
+				pages[idx++] = page + j;
 
 			phys += contig_pages * PAGE_SIZE;
 		}
-- 
2.50.1


