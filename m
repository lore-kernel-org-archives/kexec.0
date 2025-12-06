Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3931BD3B7E5
	for <kexec@archiver.kernel.org>; Sat,  6 Dec 2025 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o7YoGpMyUPp3jH132CIdD3VVC6kyvyTZv2wvu2Rm4MU=; b=x4hIKKTZYvbNAYFJAPqz57ENu6
	al/a1Q7EK6cCgKlszoWMe3Kg9O8vhMMYRAnRx56hBuLO3Zvag3nSRbPe5y7jG2UMBr5FgjXvUBPyr
	CLZNcayavvJpe615WQuCt/FhKNUHqfBLKleFL/Zzd3aUb9lAWeD0ylTiZFFVWzZJoxroEEYG1oIMr
	pKFnM3D9O6LxB0eLatM3WlIdRnlu1He5mXdwCUXJOT5UpttuICbPfQH4eplb8J+z8kfbmRsI5Mrfm
	jqyqE6pkSpO5/Y4UYaZ6+/NkDWfF9AaRAjFi3QfIxItRT3mZocobG2p+/im5t3vKAt692iwe5HT0M
	IBMyOSsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1Jo-0000000BI3o-3UNp;
	Sat, 06 Dec 2025 23:04:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vS1Jm-0000000BI0T-0Sr0
	for kexec@lists.infradead.org;
	Sat, 06 Dec 2025 23:03:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C791B43CEA;
	Sat,  6 Dec 2025 23:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BDEC4CEF5;
	Sat,  6 Dec 2025 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765062237;
	bh=fGPbJKByL7S+VIwHfLLrxZLls7YbYHHkduUbnM1vhgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJ2JZwXMPZBVSnMwc5z8fugeGrViXv1sYM2jgFTCIoMG++wHeJDsoqlg2QWMyz1fG
	 /D34iNvXn6M1p4hEMRSR80EXzWx5TeD/YRn4gwPgpNUCQIsRcEdDJn4HH8cUc530+Z
	 X9dHrgt33cuDK7Q9iVwzJvfxywhfHrIuKYqc8x/HPgLuQzzPHrJPpoZCilQbQV9dOD
	 MPBWe8RhC+HfjVA/0WNKEKtWzH3M9hSus+AN8uv7wPg+eA1RA6A5l67e4n9a6VdDag
	 vDH2yDJC1sTAhvwujm6FimvTkDOlCN4Am9/l9c5dKYMRMxpQWn++1R0J682zSIP+3Y
	 3eHXsYi/SqXYA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Alexander Graf <graf@amazon.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Vipin Sharma <vipinsh@google.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [RFC PATCH 08/10] mm: hugetlb: disable CMA if liveupdate is enabled
Date: Sun,  7 Dec 2025 00:02:18 +0100
Message-ID: <20251206230222.853493-9-pratyush@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251206230222.853493-1-pratyush@kernel.org>
References: <20251206230222.853493-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251206_150358_170136_1EA48859 
X-CRM114-Status: GOOD (  10.32  )
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

Hugetlb live update support does not yet work with CMA. Print a warning
and disable CMA if the config for live updating hugetlb is enabled, and
liveupdate is enabled at runtime.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/Kconfig | 3 +++
 mm/hugetlb_cma.c          | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 86e76aed8a93..4676fea6d8a6 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -82,6 +82,9 @@ config LIVEUPDATE_HUGETLB
 	  use hugetlb memfd to back VM memory, or for other user workloads needing
 	  to live update huge pages.
 
+	  Enabling this config disables CMA for hugetlb pages. It is not yet
+	  supported with live update.
+
 	  If unsure, say N.
 
 endmenu
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index e8e4dc7182d5..fa3bb776c0d2 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -4,6 +4,7 @@
 #include <linux/cma.h>
 #include <linux/compiler.h>
 #include <linux/mm_inline.h>
+#include <linux/liveupdate.h>
 
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -152,6 +153,12 @@ void __init hugetlb_cma_reserve(int order)
 	if (!hugetlb_cma_size)
 		return;
 
+	if (IS_ENABLED(CONFIG_LIVEUPDATE_HUGETLB) && liveupdate_enabled()) {
+		pr_warn("HugeTLB: CMA not supported with live update. Falling back to pre-allocating pages.\n");
+		hugetlb_cma_size = 0;
+		return;
+	}
+
 	hugetlb_bootmem_set_nodes();
 
 	for (nid = 0; nid < MAX_NUMNODES; nid++) {
-- 
2.43.0


