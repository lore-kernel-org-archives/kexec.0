Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF1606A31E
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QgX16pKG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmfZUdKj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NWNJ/XENAKSS8XJu2StXXvDx4pA/ZlIpefLloruQ3+A=; b=QgX16pKGd9hrwp
	MJQDAROPbqiRok+kfyeZdJZ50LwB6vIZFY702Rc0LeeMELAVP5d/Q0aCd9p/SQTNOEh8/vPcQZoIi
	d8BkM3AeXHTwMhSLsG6DpxtYkOj+NZMehEPz6bnF37buFQ34D2ypsk4Ts2lherLQfYjXF7nPqHhuK
	oWakrNyauI4AZrPWbRkhiMFtAem+gsDA1BF5Tu/Cm1PjM3MnzhLDVmHzLMIHifRm8DhqQ9fXT/UuA
	nXQ7jJX6A+d+WjEL4+VNJWVQtNI0D+lSLYuGUU5TqRyZN624/UnspLMb8wG/bH7d+zWrRjXqUBiXD
	us2IJZ9ts6VdZBYF7urA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU3v-00000003QQX-0Tv3;
	Mon, 26 Oct 2026 23:25:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU3t-00000003QPu-3TR1
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:25:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 90FCA43A59;
	Mon, 26 Oct 2026 23:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC9B1F01825;
	Mon, 26 Oct 2026 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057105;
	bh=NWNJ/XENAKSS8XJu2StXXvDx4pA/ZlIpefLloruQ3+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XmfZUdKj2CDA3hO/9OSbirdo/tI8K3m4+KVIN68gYUkWYDqjcQkm5g1INwhB61XHz
	 B7RwKeG1CHsN5S6OJkvQsHmA0cql1QWmgbZ5b07svv40y4SxyrPzL9VUHMao1+/lbv
	 pDTINIXQaAyXCwuj/k/OuayFvhOlGgVfUtolZmXavmCRIrRKJuvsa8MOnJFaFRq87R
	 SIHKlLe+V7Ng+b4lAvM+DKz0SlqtEc9SiBdUFWJwiu2lctCWh0cYkKTc28rEazIUI+
	 jxN1CCeJj3IYrRDtRR5yXE9lyp4+zAuIjWbwmIF85IHU5AghTyKrUsQAlewE4xpgIz
	 p8s5ToS7ru13A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:43 +0100
Subject: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288; i=david@kernel.org;
 h=from:subject:message-id; bh=SZZ0c1Ekk71/HNTctZ9IxQIrBH8id6NjD8hfDnFWvMg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/m/ShOQ+gHDwePwf/j9sIbLn+O83as/W7OorTuo
 pR2iufujlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACbyTpyR4dflzBz7RJm7Wi7e
 fkozPU4pZU8RvNeV+djcwsszqL8ghuF/+r1nL/aekqm5sah+zstDGa/fJO6drqF1452p++uS9GA
 1fgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

userfaultfd_unregister() wakes pending missing faults before clearing the
VMA's userfaultfd registration. With per-VMA fault locking, holding
mmap_lock for write does not prevent another fault from queuing after
the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
waiter can then remain asleep indefinitely.

Call vma_start_write() before waking waiters. Existing fault handlers
queue themselves before dropping the VMA read lock, and new readers are
excluded until mmap_write_unlock().

Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 669f71d485d02..7e30b5ff17be1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
+		/* Prevent new userfaults from being queued after the wakeup. */
+		vma_start_write(vma);
+
 		if (userfaultfd_missing(vma)) {
 			/*
 			 * Wake any concurrent pending userfault while

-- 
2.43.0


