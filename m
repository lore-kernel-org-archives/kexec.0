Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0VPA-0004AW-Jj
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 18:32:22 +0000
Received: by mail-qk1-x744.google.com with SMTP id d79so2695779qke.11
 for <kexec@lists.infradead.org>; Wed, 21 Aug 2019 11:32:20 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v3 09/17] arm64, trans_pgd: add trans_pgd_create_empty
Date: Wed, 21 Aug 2019 14:31:56 -0400
Message-Id: <20190821183204.23576-10-pasha.tatashin@soleen.com>
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com

This functions returns a zeroed trans_pgd using the allocator that is
specified in the info argument.

trans_pgds should be created by using this function.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  3 +++
 arch/arm64/kernel/hibernate.c      |  6 +++---
 arch/arm64/mm/trans_pgd.c          | 12 ++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index e3d022b1b526..26e5a63676b5 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -40,6 +40,9 @@ struct trans_pgd_info {
 	unsigned long trans_flags;
 };
 
+/* Create and empty trans_pgd page table */
+int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd);
+
 int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			  unsigned long end);
 
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 17426dc8cb54..8c2641a9bb09 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -216,9 +216,9 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
-	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_pgd)
-		return -ENOMEM;
+	rc = trans_pgd_create_empty(&trans_info, &trans_pgd);
+	if (rc)
+		return rc;
 
 	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
 				PAGE_KERNEL_EXEC);
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index dbabccd78cc4..ece797aa1841 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -164,6 +164,18 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 	return 0;
 }
 
+int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd)
+{
+	pgd_t *dst_pgdp = trans_alloc(info);
+
+	if (!dst_pgdp)
+		return -ENOMEM;
+
+	*trans_pgd = dst_pgdp;
+
+	return 0;
+}
+
 int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			  unsigned long end)
 {
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
