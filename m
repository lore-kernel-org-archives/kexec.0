Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B5CD8C83
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Hq29nobeHte/zgkXSzWoaRdOwXra0la1omlEHsUXW0=; b=dzb31YoNjGpB0Vwy0qX5Q3wsjR
	+/QJYl4AwwQl0Mm0WjNoLieR9A13G1RUQ1qixRN52X9q1l1IzqgBhd79J2cebWypvDvPhi7KBdVgi
	0UO4SfQxzWnh2sCAKmGf4KLRxBqmi9N4e4ZW8SrlJqYWzkzXmzbs750IpmUdEMYEW+XUkKmGBhMMC
	gmJduJ2aeRuCnX4XWbp27p+vuTlBddNP8U6/8XcXuj2TRfXEVRaw6+VXmPUxt32amSVKLfml2WNoa
	cZaHVbEt2Q7LJeYU0rPLH9QnRGvTUHmbP2e/MPk4x89w58//gBTxB0hBFJ5OHXkKwic9PodvQo2SV
	gNrLuXtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOg-000000013bl-45Hm;
	Fri, 05 Jun 2026 18:35:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOf-000000013aC-0UFc
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DBABA4338F;
	Fri,  5 Jun 2026 18:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A913E1F0089C;
	Fri,  5 Jun 2026 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684556;
	bh=1Hq29nobeHte/zgkXSzWoaRdOwXra0la1omlEHsUXW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bUfHWrW5rXMnv2UvKJJvwS1trNmxa2rXAjoYxroYpe1q5lIcs760w3ankAJ6BB1Py
	 g73wErrnH91np/zObpNmIFsHWrAUvhr3VJlJAcj4xTTHk/cvcRExmAy12bklfYEH+w
	 kAaKAZcTcXTI0uCCo5vFlyOqxzHlqa46oLSVDq6qe5fpJTloUX20PBsylCddF9x0z1
	 wSJgYCMJGOGDk0bXCPolKk9SFYRhFNmMU1wQ2M0lk0ybHyOBjtAtQX1FwVJvlUEqUg
	 bVjPGABJTG6H4zot5hDdg1Ua9KeRvqsn0epir31a1xmaTVbNjXDhZhjEnok0JZYRXG
	 YmdbPzofSIHPA==
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
Subject: [PATCH v2 18/18] kho: exclude hugetlb memory from scratch size calculation
Date: Fri,  5 Jun 2026 20:34:51 +0200
Message-ID: <20260605183501.3884950-19-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
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

HugeTLB pages can be preserved memory. So they are never allocated from
scratch. Instead, they are allocated from the memory blocks with no
preserved memory. These areas are detected at runtime on each boot.

But since they are allocated via memblock, they show up as RSRV_KERN,
and blow up the scratch size when scratch scale is in use.

All hugetlb pages are marked RSRV_HUGETLB. Subtract their size from
RSRV_KERN when calculating scratch sizes.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b3c33f150e85..0d106c9197d9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -744,7 +744,8 @@ static void __init scratch_size_update(void)
 {
 	/*
 	 * If fixed sizes are not provided via command line, calculate them
-	 * now.
+	 * now. Use RSRV_KERN to count allocated memory, but remove HugeTLB
+	 * allocations from it because they never get allocated from scratch.
 	 */
 	if (scratch_scale) {
 		phys_addr_t size;
@@ -752,12 +753,19 @@ static void __init scratch_size_update(void)
 		size = memblock_reserved_size_flags(ARCH_LOW_ADDRESS_LIMIT,
 						    NUMA_NO_NODE,
 						    MEMBLOCK_RSRV_KERN);
+		size -= memblock_reserved_size_flags(ARCH_LOW_ADDRESS_LIMIT,
+						     NUMA_NO_NODE,
+						     MEMBLOCK_RSRV_HUGETLB);
+
 		size = size * scratch_scale / 100;
 		scratch_size_lowmem = size;
 
 		size = memblock_reserved_size_flags(MEMBLOCK_ALLOC_ANYWHERE,
 						    NUMA_NO_NODE,
 						    MEMBLOCK_RSRV_KERN);
+		size -= memblock_reserved_size_flags(MEMBLOCK_ALLOC_ANYWHERE,
+						     NUMA_NO_NODE,
+						     MEMBLOCK_RSRV_HUGETLB);
 		size = size * scratch_scale / 100 - scratch_size_lowmem;
 		scratch_size_global = size;
 	}
@@ -777,6 +785,9 @@ static phys_addr_t __init scratch_size_node(int nid)
 	if (scratch_scale) {
 		size = memblock_reserved_size_flags(MEMBLOCK_ALLOC_ANYWHERE,
 						    nid, MEMBLOCK_RSRV_KERN);
+		/* Do not count HugeTLB pages. */
+		size -= memblock_reserved_size_flags(MEMBLOCK_ALLOC_ANYWHERE,
+						     nid, MEMBLOCK_RSRV_HUGETLB);
 		size = size * scratch_scale / 100;
 	} else {
 		size = scratch_size_pernode;
-- 
2.54.0.1032.g2f8565e1d1-goog


