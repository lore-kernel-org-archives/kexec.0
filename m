Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86970D72366
	for <kexec@archiver.kernel.org>; Fri, 23 Jan 2026 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OraLy8XeIZjSbX8NkjbCmR86yFe9whSrom3FX0RuLfQ=; b=YVtCEkLb1FZGC46Ig7HB6InKy6
	9PFqK9eLVNChds02w/q5andBBm5a28ByEgEDnzPvEtO+IU/i6dwyaaRcdVnNkhzOq1bBe0iMEgQUl
	SmP37C9ijHlJrQcLkRyY9+EtjoTtf87yFPJrEoVeh5OZffxDrEiGyoxr+OGqBVOF14jgIAHobd81s
	g2gQN3MiD1VXH4IO/eBshuVJbUMxjnN0204OKh/JdQAYNZIjKRHqaC5xQuRY6tCep0NV6shJrOalh
	MSomKNw0l0fF1FPlsS4rbyxl0bwnt1W5XtD8B9nV9raT9l3eaCtLVUvA6vUKaQ+8JKFyn4HkR490k
	xehwXL5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjDwd-00000008f2L-2SQT;
	Fri, 23 Jan 2026 09:59:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjDwc-00000008f1E-07sH
	for kexec@lists.infradead.org;
	Fri, 23 Jan 2026 09:59:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 24E0543CEB;
	Fri, 23 Jan 2026 09:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18175C19425;
	Fri, 23 Jan 2026 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162349;
	bh=JvST1LRGXZAf6Fyp43JKlkKdk/TN8dTyoER4Anwc9lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ty+NY1Hrg5UajXyM+Q53oJKE4lYESs2Ndf+rrFZyw5pJWcm5xsIKI1M81U/M88o4t
	 6IJzU0w8L9WRwVIjLWvHI6yTSrh2shg2g1jDjpzIzu9SLF22HeiOs8HZUSkeMOO554
	 eNrgEcRxRSUE8dV4e6skUucVCyYLm/CgKNAlktZzmlkPPqEaas8BY6rSMTLzYKEo8/
	 0bS7kgysYI3H0JHAYcpov9Epz6ufCGqgafeXowxD4ICwP0M2xtAyQYsDZUw1BqM3fp
	 DynHLuIgjz6nJpa/6iPihIquJZcegVo5xCJaTBInm4jlAIDGmKek8t1d/Q5A8b3n/C
	 ntzq4giz/m+Xg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] memfd: export memfd_{add,get}_seals()
Date: Fri, 23 Jan 2026 10:58:50 +0100
Message-ID: <20260123095854.535058-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260123095854.535058-1-pratyush@kernel.org>
References: <20260123095854.535058-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_015910_096529_11227E82 
X-CRM114-Status: GOOD (  11.88  )
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

Support for preserving file seals will be added to memfd preservation
using the Live Update Orchestrator (LUO). Export
memfd_{add,get}_seals)() so memfd_luo can use them to manipulate the
seals.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/memfd.h | 12 ++++++++++++
 mm/memfd.c            |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index c328a7b356d0..b4fda09dab9f 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -18,6 +18,8 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
  */
 int memfd_check_seals_mmap(struct file *file, vm_flags_t *vm_flags_ptr);
 struct file *memfd_alloc_file(const char *name, unsigned int flags);
+int memfd_get_seals(struct file *file);
+int memfd_add_seals(struct file *file, unsigned int seals);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
@@ -37,6 +39,16 @@ static inline struct file *memfd_alloc_file(const char *name, unsigned int flags
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int memfd_get_seals(struct file *file)
+{
+	return -EINVAL;
+}
+
+static inline int memfd_add_seals(struct file *file, unsigned int seals)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* __LINUX_MEMFD_H */
diff --git a/mm/memfd.c b/mm/memfd.c
index f032c6052926..46c5508beea4 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -228,7 +228,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
 		     F_SEAL_WRITE | \
 		     F_SEAL_FUTURE_WRITE)
 
-static int memfd_add_seals(struct file *file, unsigned int seals)
+int memfd_add_seals(struct file *file, unsigned int seals)
 {
 	struct inode *inode = file_inode(file);
 	unsigned int *file_seals;
@@ -310,7 +310,7 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 	return error;
 }
 
-static int memfd_get_seals(struct file *file)
+int memfd_get_seals(struct file *file)
 {
 	unsigned int *seals = memfd_file_seals_ptr(file);
 
-- 
2.52.0.457.g6b5491de43-goog


