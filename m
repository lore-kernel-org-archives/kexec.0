Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0VP4-000427-0P
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 18:32:15 +0000
Received: by mail-qk1-x743.google.com with SMTP id 201so2706915qkm.9
 for <kexec@lists.infradead.org>; Wed, 21 Aug 2019 11:32:13 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v3 05/17] arm64, hibernate: check pgd table allocation
Date: Wed, 21 Aug 2019 14:31:52 -0400
Message-Id: <20190821183204.23576-6-pasha.tatashin@soleen.com>
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

There is a bug in create_safe_exec_page(), when page table is allocated
it is not checked that table is allocated successfully:

But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).

Another issue, is that phys_to_ttbr() uses an offset in page table instead
of pgd directly.

So, allocate page table, check that allocation was successful, and use it
directly to set ttbr0_el1.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index ee34a06d8a35..750ecc7f2cbe 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -199,6 +199,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 phys_addr_t *phys_dst_addr)
 {
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
+	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -210,7 +211,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
-	pgdp = pgd_offset_raw((void *)get_safe_page(GFP_ATOMIC), dst_addr);
+	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
+	if (!trans_pgd)
+		return -ENOMEM;
+
+	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pudp)
@@ -251,7 +256,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	 */
 	cpu_set_reserved_ttbr0();
 	local_flush_tlb_all();
-	write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
+	write_sysreg(phys_to_ttbr(virt_to_phys(trans_pgd)), ttbr0_el1);
 	isb();
 
 	*phys_dst_addr = virt_to_phys(page);
-- 
2.23.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
