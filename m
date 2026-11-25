Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C0606A31E
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0WaTf8o1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohxyzMNl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=VHe5Uw67z1Y8nTKWeloBeO0r936iChXIFhmIiPgc1Jk=; b=0WaTf8o1MII/9EMlpvOhSMT33T
	L5DRDSw/xDMvdC0y4O1Ej05qlHpmMrLdq8bFw7Rw2rJBn4EKwEUVHIOeShND8Bi7Np0LCV5Mnuikc
	WAcl3YrZLAh35hOaDWWlAfa3peOwQar83VlXxP128h5PmHpGiT9Fr/pi5GFCKe8RoZtNZ7OTLhAHM
	3ucfYZm2u/a/f4HvwYWc/Es0SnRIsAkK347pG8Tc4AJseBdWMtJL4IsmOhY1FUDTuVcSbh2XlwFiy
	W5FJtqLMVYD1JSVQZgOt7Qnv4EMJa5Rwizu1d3bwHj0/r55q+nt3Xx3e/QyaeOPpMWEblYf6g9gHE
	hhiJr/Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFHN-0000000ASC9-3Kyv;
	Wed, 25 Nov 2026 15:51:29 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFHI-0000000ASBI-32vX
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 15:51:28 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so4395139a12.0
        for <kexec@lists.infradead.org>; Wed, 25 Nov 2026 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795621883; x=1796226683; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHe5Uw67z1Y8nTKWeloBeO0r936iChXIFhmIiPgc1Jk=;
        b=ohxyzMNlIpakfIVLJz/0SKGysPoP2cDGksT2WLWHav99uQ8/uqiifbY6pkqGHRPDGj
         sdex+qEPjnaUVAam+9QyM6z55cxaEXsJpMyWSL2IvkF/3UTr0pAdlf7SiY5BTYWNJH9x
         WEjXsc4QrKngiH95k0mun9NMIiWJ+obHoSY7A2fRuzB1DrkcIOzIwjgYTHmrJCLCaaq5
         7gQFRLcND7xCZRzyEJiLWoli5vBYu8lYiHL85GV7vaoCmIbJYFGxMm5a8NfNuqaWI53/
         pQiTBhXgMZlDDfYPLZIOkUr++MvfJolqPlof7GujYkalr8gT2kx0GdMm3JjMcITBhcwc
         XVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795621883; x=1796226683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHe5Uw67z1Y8nTKWeloBeO0r936iChXIFhmIiPgc1Jk=;
        b=MPCIC0wY03cvDSRqPsOw/me4oTlogfyC8rKa1/7sdUjc4KIx1QVEWM9jvQ9y+3ZSxH
         dBvTK1L5RM1OCxm6MPXFnTTSb3c48N6xB3U6+6yAW0x0wITiF+DrXR0Txg2h4AYUBQJd
         uJ7DwFhvaLTF0PGjq2744YZ4lxGno1pQtohFkeqsCm2wptveAQCZJtXShifD1DsKhEVJ
         Uqvh75aL4YXaEH/UqdKEZJKXyDIf1E/xSsNwT3bSPbBDgyOVWaIOVzIX4oGqWL2X14nx
         lLvg4XFiEohQhETsDPFfofsmO4ZWPmc7YXEl7tA3o0YT530AiX5NQXVejl0LRVDiQaHS
         CjLA==
X-Forwarded-Encrypted: i=1; AL+hErHuBlPoFCpNO8UI3AtDQyPO57uRHf3THHQfAkoJ3GanCntUxSByQ5psOvik4wREx2z5Fvny3Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z/oVMQFg/bELmrKQIyiSzE3/V1q++3WgN56ZCAQjniAEhlxnIdF
	muWnjF3DtS56KxvUmY4/zm8vf+QQw1YvyzP+Y/jsSIHMQQ3TUfby4nqG
X-Gm-Gg: AZFdTZd9Enb8piq0XraTRupjkVk/fu+M8pB0MVTk6bpfeP153WQ9zRlQPAEYhOUavKo
	P+fl3k3df1C4/5sMeiOxRYpFOyn4Y8i4Bsdcm44zpWccZuwk+SiLKJbYIlAMetdUp3UsTCjdykv
	rmsytyPBhNGKBcy3PJIYrhS+E0fGKuapGVDWTiK8pKX2vsRjkKBKm8wqemKBi1uHml9RswTcsIw
	Om1/SvlfKo/woPjD6XWzKjsmnQZmhUql7kCF0JooIWz286kdL5PTIMmD8Ak91yqYCegCqgC7kAK
	dAH8avBuwb8ndcE0jNVomgFbvPtJBNn5MsQArC8Zpt9fd28DtRtFkPkpd4HlnlRpxgkdbAt6bvM
	ActFWMnXtauVflPDGptg/lagvTGdVt8zK7007FzOxwuoauYa69k0vasQorcHi/91TH10+kIiSFP
	z13ZjLaAlu27NKuuPUl4JypdoucKbxjft7RXsiu9DnE2shSK9W+TKRpdN6lQRDTqP+nykSGwUG3
	A1whlhFebwNMxpTUJa3Ls6OO0T9JA/wJVroJJ5frA4uD9oPxnq1z1EW9eB5HDc3jW0r4ymo0lGu
	W2vq4Cmt3xoXGYrSm2Epnys+DB4pptRfdciA/x5NtOOWjiTOFZo9
X-Received: by 2002:a05:6a21:8201:b0:3f5:ef59:3aaa with SMTP id adf61e73a8af0-4014ae81ebbmr19762858637.16.1795621883355;
        Wed, 25 Nov 2026 07:51:23 -0800 (PST)
Received: from ubuntu ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm9058205a12.30.2026.11.25.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:51:22 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Usama Arif <usama.arif@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Frank van der Linden <fvdl@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Jiri Bohac <jbohac@suse.cz>,
	kexec@lists.infradead.org
Subject: [PATCH] mm/cma: reject long-term pins of HugeTLB folios overlapping crashkernel CMA
Date: Thu, 26 Nov 2026 00:51:06 +0900
Message-ID: <20261125155108.24098-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_075124_766628_458C9C22 
X-CRM114-Status: GOOD (  16.16  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

crashkernel=size,cma uses existing hugetlb_cma memory, so
crashk_cma_ranges[] may contain HugeTLB folios. HugeTLB folios allocated
from hugetlb_cma can be long-term pinned without being migrated.

After a crash, the crash kernel uses the memory in crashk_cma_ranges[],
but a device can still write to a long-term pinned folio.

So reject long-term pins of HugeTLB folios overlapping
crashk_cma_ranges[].

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
The above scenario is only possible with the two patches below applied.
Currently only linux-next, which is targeting v7.5, has both of them.

  "mm/hugetlb: allow crashkernel to reuse hugetlb CMA memory" (kexec-next)
  "mm: gup: allow long-term pins of CMA-allocated HugeTLB folios" (mm-unstable)
---
 mm/cma.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 0c97aadcfea4..cb4a92e2b9f5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -32,6 +32,8 @@
 #include <linux/hugetlb.h>
 #include <trace/events/cma.h>
 #include <linux/page-isolation.h>
+#include <linux/crash_reserve.h>
+#include <linux/range.h>
 
 #include "internal.h"
 #include "cma.h"
@@ -42,12 +44,33 @@ unsigned int cma_area_count;
 
 bool cma_folio_is_longterm_pinnable(struct folio *folio)
 {
+	struct range r;
+	int i;
+
 	/*
 	 * Explicitly allocated CMA folios own their CMA memory and can be
 	 * pinned even in ZONE_MOVABLE, as CMA memory cannot be offlined.
 	 * For now, only HugeTLB tracks these allocations with a folio flag.
 	 */
-	return folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio);
+	if (!folio_test_hugetlb(folio) || !folio_test_hugetlb_cma(folio))
+		return false;
+
+	/*
+	 * The crash kernel uses the memory in crashk_cma_ranges[], but a
+	 * device can still write to a long-term pinned folio after a crash.
+	 */
+	if (!crashk_cma_cnt)
+		return true;
+
+	r.start = PFN_PHYS(folio_pfn(folio));
+	r.end = r.start + folio_size(folio) - 1;
+
+	for (i = 0; i < crashk_cma_cnt; i++) {
+		if (range_overlaps(&crashk_cma_ranges[i], &r))
+			return false;
+	}
+
+	return true;
 }
 
 phys_addr_t cma_get_base(const struct cma *cma)

base-commit: a036649714c3446abfdc36d0ae483046432b16c5
-- 
2.53.0


