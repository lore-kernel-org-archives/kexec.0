Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52748CCFA08
	for <kexec@archiver.kernel.org>; Mon,  3 Nov 2025 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErWge/UzD1LqvuHl7Z8/FN67Gq0geRz5k29l1oyq1Is=; b=Cuw7xKGbt2rneamoiezUOmS+v7
	G8LuImhbG6MqkCEpl3oFDQ5l44L6Z5iG69r3YAZqqJVkljYSv+fJnx+WYnFSJzBPyQDn59WLZpdnF
	wTdge/3J7e1pa/g5Z51QEXtZvDZYrG3Beqsy+OL1Jdwc4md7LYz1WbUL4lX+ThPo8SeROK/5Ktba2
	sd3S/rl46oXxo64IB09886TaqfDKEOK0V/i/+upndm0fu2tBqSjtk0FoiTo1ytARESX3Xset6CetU
	PygsS8HMFLtVydnczlOgwFA5YhIjYfJY6Vi+AnVKnySKXJ2CKwublGvMxDF68IfHRg5WutK0z/VRv
	jixC66vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFytD-0000000AS1y-3zt2;
	Mon, 03 Nov 2025 18:02:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFytB-0000000AS0J-1EqI
	for kexec@lists.infradead.org;
	Mon, 03 Nov 2025 18:02:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 068FF41E48;
	Mon,  3 Nov 2025 18:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD2DC4AF09;
	Mon,  3 Nov 2025 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192964;
	bh=XAwF/h8XdutL+ENyQyWob7z7axCXjW7g+SCPNNUBiyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IogQUODJjyTWMTWVWaSKOwkSJBVW67K2O34Yde/KtslQOOC/Iz4sy8KaX6kqBr7H5
	 GFb0Mcw/CkdVwmgfsioszFx5cEWJnFMulKlO4IIWvyPCxOY1jfelhxhEZQ5AP4Ct20
	 0Vgjho6r1cDd6BAXDhjF53c2kxEy94T2XEauW2MpEwvaH7ybnXWy2ukCRmB/8Xzbk8
	 Q8XlwO1XtdHF4UuXTBo9/62vnf1B1SOwpRq/JctgNqhxnH4iX4n2dIk3KVMpmHVZDY
	 fl6Itix1asg+IRwQ/C5Alq02OX92QqFS6qSZ4BEdLJGRyEcSa9MguO0nJ5vMyR8QXe
	 Rxj/Q36Ehv0Gg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kho: warn and exit when unpreserved page wasn't preserved
Date: Mon,  3 Nov 2025 19:02:32 +0100
Message-ID: <20251103180235.71409-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103180235.71409-1-pratyush@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_100245_356434_0E031F69 
X-CRM114-Status: GOOD (  10.78  )
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

Calling __kho_unpreserve() on a pair of (pfn, end_pfn) that wasn't
preserved is a bug. Currently, if that is done, the physxa or bits can
be NULL. This results in a soft lockup since a NULL physxa or bits
results in redoing the loop without ever making any progress.

Return when physxa or bits are not found, but WARN first to loudly
indicate invalid behaviour.

Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c2bcbb10918ce..e5fd833726226 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -167,12 +167,12 @@ static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
 		const unsigned long pfn_high = pfn >> order;
 
 		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+		if (WARN_ON_ONCE(!physxa))
+			return;
 
 		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+		if (WARN_ON_ONCE(!bits))
+			return;
 
 		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
 
-- 
2.47.3


