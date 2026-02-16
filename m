Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564ACE83823
	for <kexec@archiver.kernel.org>; Mon, 16 Feb 2026 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C/dKMkgdjI+mYgJARn4sBz+QeKEfxgv8U21+9jtU7M0=; b=m0GvNCfTmqzhFe9HOgf3Mt+Iqr
	OlDK2SY5IcLKkWTZN0onEGkCTPxSFu2jmKe+2f/D62D+ZB7EKXEZuTuA16DbfPLyXo5Wk5i+vnxTu
	SM2NJLIC1/wmgm+nD0+k03Zzbywyxlr2MOUjafrs6LLABQRKKLAIA9Zd9R2Lt8+ezTzPpYU5LMzTG
	5X73xiMVZ1/ZtRJ2k5TYUzxxtlNeda/7DGwnJht6tKJE9j4EyVxhRW7Ar27Wyvwy/5ZZQsVi2Vwv0
	bx0+uFTEugqla7jxxQ9nR2clzcbgzAQe5MJm4eCaixWhcdfUpD/iz38q+JLt0QdG6q7EdkHnxUFnz
	45gXiCoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3pF-00000007AuP-0xJF;
	Mon, 16 Feb 2026 19:00:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs3pC-00000007AuB-1mkG
	for kexec@lists.infradead.org;
	Mon, 16 Feb 2026 19:00:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 88F9160145;
	Mon, 16 Feb 2026 19:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44499C19422;
	Mon, 16 Feb 2026 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771268401;
	bh=6Hh3KYw2Jyb1btkJg7DMiLM+J1fGkbsEdPXZYlYEctY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhrvYoaV8utxpqTBno7SbwJVX0AU+R7vbcXf+xXIJS/M7LfbjsrGjyg7hefx912jU
	 h7aAkI7h2dJTIHUkFGciVaMnHvtGJnHwex2MjrPSU0A8PLd+lFsmTPGBVh5aoKsZUH
	 g17wZ0SmTm+fvGPCvJ6XZlkUx4KTWjNK/ktTwNTvRRtGxbf4e4cOrFaxWT92RWogmt
	 CXyjVnEnhA4+I4jMzg6zzL1snyXnjK9e8V3QWjI1JGPZIKaPNvK3/RDDRgoCHgHmPj
	 ZzJxAo0ixeA0nQFity8fNEte4xt0YGsiS9B0R/ZJ3mwnclbsdMGvOXlnalX4FdMYmD
	 +35c/JPjEJUxA==
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
Subject: [PATCH v2 1/2] memfd: export memfd_{add,get}_seals()
Date: Mon, 16 Feb 2026 19:59:32 +0100
Message-ID: <20260216185946.1215770-2-pratyush@kernel.org>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
In-Reply-To: <20260216185946.1215770-1-pratyush@kernel.org>
References: <20260216185946.1215770-1-pratyush@kernel.org>
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

Support for preserving file seals will be added to memfd preservation
using the Live Update Orchestrator (LUO). Export
memfd_{add,get}_seals)() so memfd_luo can use them to manipulate the
seals.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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
2.53.0.335.g19a08e0c02-goog


