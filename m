Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC73CD4F5B
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=o+LkVX5yvItsLOG85pbAr4wLlDhVGqjrSr28bMTZLNI=; b=1FOs6Xto65kwE/op48nz+tbkrE
	o6LPiJZqm2tGbx+Y+3JxXJqpwkfx6KAdNIVj+HhF1NqoCUdufDOlNC7ftpWZYC4aWehKqg51CGcad
	a3ClVcNE+zilaz2WVESUpBnh80X+vCZ4mxVqdbjQ3anCKyMjnIUuRJnOYoDxyRnlX1HIurxtQ66F6
	KxdJTcuyO1yS2Zpcu6tYpsnzFMwG7wEYZbKp/0SonbGeODjyxL9r8ImkbuePk1mF7nlUCqfrVy+oY
	9OBWeby2hWO/JwuWH6iybiCcXQs0fqR21weF0CpG0rTemFryml+knG8ZbyhysPWjPjf+inFlBPpJt
	4rygwUYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPMlF-000000028I7-1qBe;
	Tue, 19 May 2026 15:53:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPMlD-000000028Hs-40ij
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 15:53:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 01DE46012B;
	Tue, 19 May 2026 15:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEAEC2BCB3;
	Tue, 19 May 2026 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779206014;
	bh=XUKkEq/zBwZCDneFV3d4XY7FRw4qnYbdahDIQGyl9WY=;
	h=From:To:Cc:Subject:Date:From;
	b=aEaiq6JVQa2BIXrRE/R4JjRcdFUTvMo3hoMC1wkCTJ41hnIhmZ0x44zeeaSpsFgbM
	 +sIKrzMbZeZjRP43gButUTH9u0GCcbN7EMJ4GQxYC/iFsodqryxAh6MOWvvNwW4i3Z
	 j9+pOCDGYEvjBGhKwJTe3ut9pbefd4k80TcxjwMG6+XrxfwG0h9cjKmsUsa0yzLQmw
	 hgDGVFaFmM+nORb1gJmby5qI8NnkqDQ5GefonURZKmfkjPmdBa2H5wLkctmrQlU7Wp
	 AfI8o3HCrLLmIWoMaZpyEJx1pU0DKcDnpwdNEsCk4Ph7SLJtzXDuVJ5aWzPUsvWrvr
	 IRQ8+vtYoMiBw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kho: always print scratch sizes
Date: Tue, 19 May 2026 17:53:21 +0200
Message-ID: <20260519155324.2692594-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
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

Currently, KHO only prints scratch sizes when the size is specified
by the command line. It prints nothing when the size is calculated
at runtime by counting RSRV_KERN.

These prints are completely useless. When the user specified the size on
the command line, they already know how large the scratch areas are. And
that information is readily available by looking at the command line. It
is a lot more useful to know the sizes that are calculated at runtime
since they can vary by kernel version. Plus, if KHO fails to allocate
the scratch areas, the calculated scratch sizes are not available via
debugfs.

Print the scratch sizes in kho_reserve_scratch(). Do it before making
the allocations. The size can provide hints for the failure reason.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 33fcf848ef95..b030f53f2235 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -621,11 +621,6 @@ static int __init kho_parse_scratch_size(char *p)
 	scratch_size_pernode = sizes[2];
 	scratch_scale = 0;
 
-	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB pernode: %lldMiB\n",
-		  (u64)(scratch_size_lowmem >> 20),
-		  (u64)(scratch_size_global >> 20),
-		  (u64)(scratch_size_pernode >> 20));
-
 	return 0;
 }
 early_param("kho_scratch", kho_parse_scratch_size);
@@ -691,6 +686,10 @@ static void __init kho_reserve_scratch(void)
 		goto err_disable_kho;
 	}
 
+	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB\n",
+		  (u64)(scratch_size_lowmem >> 20),
+		  (u64)(scratch_size_global >> 20));
+
 	/*
 	 * reserve scratch area in low memory for lowmem allocations in the
 	 * next kernel
@@ -725,6 +724,9 @@ static void __init kho_reserve_scratch(void)
 	 */
 	for_each_node_state(nid, N_MEMORY) {
 		size = scratch_size_node(nid);
+
+		pr_notice("scratch_areas: nid %d: %lluMiB\n", nid, size >> 20);
+
 		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
 						0, MEMBLOCK_ALLOC_ACCESSIBLE,
 						nid, true);

base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
-- 
2.54.0.563.g4f69b47b94-goog


