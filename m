Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hyojo-0002UV-MM
 for kexec@lists.infradead.org; Sat, 17 Aug 2019 02:46:44 +0000
Received: by mail-qt1-x841.google.com with SMTP id q4so8244103qtp.1
 for <kexec@lists.infradead.org>; Fri, 16 Aug 2019 19:46:40 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v2 06/14] arm64, trans_table: add trans_table_create_empty
Date: Fri, 16 Aug 2019 22:46:21 -0400
Message-Id: <20190817024629.26611-7-pasha.tatashin@soleen.com>
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com, matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org

This functions returns a zeroed trans_table using the allocator that is
specified in the info argument.

trans_tables should be created by using this function.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_table.h |  4 ++++
 arch/arm64/kernel/hibernate.c        |  6 +++---
 arch/arm64/mm/trans_table.c          | 12 ++++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/trans_table.h b/arch/arm64/include/asm/trans_table.h
index 1a57af09ded5..02d3a0333dc9 100644
--- a/arch/arm64/include/asm/trans_table.h
+++ b/arch/arm64/include/asm/trans_table.h
@@ -40,6 +40,10 @@ struct trans_table_info {
 	unsigned long trans_flags;
 };
 
+/* Create and empty trans table. */
+int trans_table_create_empty(struct trans_table_info *info,
+			     pgd_t **trans_table);
+
 int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			    unsigned long end);
 
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 524b68ec3233..3a7b362e5a58 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -216,9 +216,9 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
-	trans_table = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_table)
-		return -ENOMEM;
+	rc = trans_table_create_empty(&trans_info, &trans_table);
+	if (rc)
+		return rc;
 
 	rc = trans_table_map_page(&trans_info, trans_table, page, dst_addr,
 				  PAGE_KERNEL_EXEC);
diff --git a/arch/arm64/mm/trans_table.c b/arch/arm64/mm/trans_table.c
index 12f4b3cab6d6..6deb35f83118 100644
--- a/arch/arm64/mm/trans_table.c
+++ b/arch/arm64/mm/trans_table.c
@@ -164,6 +164,18 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 	return 0;
 }
 
+int trans_table_create_empty(struct trans_table_info *info, pgd_t **trans_table)
+{
+	pgd_t *dst_pgdp = trans_alloc(info);
+
+	if (!dst_pgdp)
+		return -ENOMEM;
+
+	*trans_table = dst_pgdp;
+
+	return 0;
+}
+
 int trans_table_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			    unsigned long end)
 {
-- 
2.22.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
