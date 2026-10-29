Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6788606A31D
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fny88Cph;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WhdvjoN5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GTbYn1B9uEaHo+IwnQISx6DSu8nadScf/DEgScNsxUY=; b=fny88CphztwFuC
	JkyEA8ATfuIy8vkWv1V9v1nWh+q74h9RnC/eVB0N6yoz79bGFUbNIMMB6/jjjpH8eVtmn6VvnjjpH
	GxNPbnFcIKeI19+mG0r5ej6so9+XNuU5CJunG8+B+K5Mocbbs3rNPRTLitrxuFcvosGo60w87EHrw
	Q0tpZTphp/PLLqaLx5ahz7b+Q1z1p4Dl9L9xLIqiARr5COM+N05MuPKHPBKzBnpQaK0/af3gxymWn
	InYOsjJBYqogsM3ywequHx1y5f9B501DXIaJ1Asz1MrG4vG2wk2F1b0PefiNFvYC1inOqrj3NhNYP
	PYgP5yEa7y5NUnkb9xGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWzk-0000000AMvi-2Yfz;
	Thu, 29 Oct 2026 20:45:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWzi-0000000AMv1-2O0J
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:45:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E5EFC60623;
	Thu, 29 Oct 2026 20:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB641F01826;
	Thu, 29 Oct 2026 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306705;
	bh=GTbYn1B9uEaHo+IwnQISx6DSu8nadScf/DEgScNsxUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WhdvjoN5s9yBtKL7TO38yUQNFfwrtZV+RPRgO+dXzIyrW8v5zeF7U9sUJeRD31dCv
	 tnqMt3RnlqgeqbFDBeJAps0ju8zYO89p+SoK/or2UoMdEm0hCT/TD/yDv0PCOqJ85P
	 fNE8dHo04vvN/YtksdSHaEnUUy15/kf2CTeZdHFG47FJoXBqSAglNrRlOwaDjz8AAy
	 wlfc60h5OWJMf1LQnsGiuPdwzn1ZbsCsvU/CR2NPTcn/RQ5ASf9KNEV4lkEIoVlIr7
	 6AOCkbODg+/zUBE9orFJVeVfbx5hHhBwXIQMFWWkdVDDspFJ9Pj/83r9qJZySYzwBG
	 KUEYRbyPx4IGw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:42 +0100
Subject: [PATCH v2 47/47] fs/proc/task_mmu: refuse addresses beyond 32 bits
 on 32bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-47-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=david@kernel.org;
 h=from:subject:message-id; bh=H23iSXQ9Zo3UCvNDkTgZhR+Jd2mqfSBMzvPG+6Su2Bs=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+36dd5g2Q4ND87Jf761zFBNvRKV+lT8j+vKzflze
 YyOa+w70FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEvrUyMqy5fPDlzml6Z/cX
 79h+PNfDilFB5ZDotvsSF56fsl9+5eVERoa/IndyDIr42sM3z5yxY7reXodOs79NDjUek3fdtxO
 tdeEBAA==
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Josef Bacik <josef@toxicpanda.com>

The addresses in struct pm_scan_arg are 64 bits wide.  The first thing
pagemap_scan_get_args() does with them is to cast them to unsigned
long.  On a 32-bit kernel the upper half is dropped without a word:
PAGEMAP_SCAN of 0x100001000-0x100002000 scans, and with
PM_SCAN_WP_MATCHING write-protects, 0x1000-0x2000, stores the result
at the lower half of vec, and reports success.

Return -EFAULT, as for other addresses outside of the address space.

This is probably not worth CCing stable.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/proc/task_mmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 7452b695fdae..762b6dbb81e4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3032,6 +3032,12 @@ static int pagemap_scan_get_args(struct pm_scan_arg *arg,
 	     arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
 		return -EINVAL;
 
+	/* Don't cut 64-bit numbers down to addresses that happen to work. */
+	if (arg->start != (unsigned long)arg->start ||
+	    arg->end != (unsigned long)arg->end ||
+	    arg->vec != (unsigned long)arg->vec)
+		return -EFAULT;
+
 	arg->start = untagged_addr((unsigned long)arg->start);
 	arg->end = untagged_addr((unsigned long)arg->end);
 	arg->vec = untagged_addr((unsigned long)arg->vec);

-- 
2.43.0


