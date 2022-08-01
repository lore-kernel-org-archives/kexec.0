Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44677C00144
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 04:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+X4lYvQk4KFuCStBnlqtKvocm3GOBO/9eGfipqWCeas=; b=Hd4/IOmk96lONf
	SOrIXbpXRrsKKQJ16FEY9IgC8IpgCJE1gdQHsSf1DS5uEdh9pdeX6jAq+yS31TetVrx/fnzNgWCr3
	KcSRm9v2lfyTDtbOiJ4H5pzpND0sOgFlZ7byqlm7sSZ6J1+N50OjkNzV0KZWnLE/D+F9GQWjXJa0I
	agBXrXk2GOHdhNSy1GRQvfwWTtgbl0yWCi9Wvvn5+aVlFPgfqXnfpQOqbuGRZbev3lok8mH6S7XJL
	BGS2gv6XPQmVJrQNnm6SWUYSzpFP7c9y+44t7T6Zp3aQKjgMlZ57rdvfYj6pwzvsX26gsq1yMv2lc
	nT5rMoziiGdKngmAMHIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN5U-001jKA-2T; Mon, 01 Aug 2022 04:31:28 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIN4z-001iuA-Ld; Mon, 01 Aug 2022 04:31:03 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VL.kDdj_1659328250;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VL.kDdj_1659328250)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 12:30:51 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: crash-utility@redhat.com,
	mick@ics.forth.gr,
	heinrich.schuchardt@canonical.com,
	guoren@kernel.org,
	k-hagio-ab@nec.com,
	yixun.lan@gmail.com
Cc: linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	hschauhan@nulltrace.org,
	huanyi.xj@alibaba-inc.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [Crash-utility][PATCH V2 7/9] RISCV64: Add 'help -m/M' command support
Date: Mon,  1 Aug 2022 12:30:38 +0800
Message-Id: <20220801043040.2003264-8-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
References: <20220801043040.2003264-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220731_213058_142728_DA7788D2 
X-CRM114-Status: UNSURE (   6.43  )
X-CRM114-Notice: Please train this message.
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Add riscv64_dump_machdep_table() implementation, display machdep_table.

crash> help -m
              flags: 80 ()
             kvbase: ff60000000000000
  identity_map_base: ff60000000000000
           pagesize: 4096
          pageshift: 12
           pagemask: fffffffffffff000
         pageoffset: fff
        pgdir_shift: 48
       ptrs_per_pgd: 512
       ptrs_per_pte: 512
          stacksize: 16384
                 hz: 250
            memsize: 1071644672 (0x3fe00000)
               bits: 64
         back_trace: riscv64_back_trace_cmd()
    processor_speed: riscv64_processor_speed()
              uvtop: riscv64_uvtop()
              kvtop: riscv64_kvtop()
    get_stack_frame: riscv64_get_stack_frame()
      get_stackbase: generic_get_stackbase()
       get_stacktop: generic_get_stacktop()
      translate_pte: riscv64_translate_pte()
        memory_size: generic_memory_size()
      vmalloc_start: riscv64_vmalloc_start()
       is_task_addr: riscv64_is_task_addr()
      verify_symbol: riscv64_verify_symbol()
         dis_filter: generic_dis_filter()
           dump_irq: generic_dump_irq()
    show_interrupts: generic_show_interrupts()
   get_irq_affinity: generic_get_irq_affinity()
           cmd_mach: riscv64_cmd_mach()
       get_smp_cpus: riscv64_get_smp_cpus()
          is_kvaddr: riscv64_is_kvaddr()
          is_uvaddr: riscv64_is_uvaddr()
       verify_paddr: generic_verify_paddr()
    init_kernel_pgd: NULL
    value_to_symbol: generic_machdep_value_to_symbol()
  line_number_hooks: NULL
      last_pgd_read: ffffffff810e9000
      last_p4d_read: 81410000
      last_pud_read: 81411000
      last_pmd_read: 81412000
     last_ptbl_read: 81415000
                pgd: 560d586f3ab0
                p4d: 560d586f4ac0
                pud: 560d586f5ad0
                pmd: 560d586f6ae0
               ptbl: 560d586f7af0
  section_size_bits: 27
   max_physmem_bits: 56
  sections_per_root: 0
           machspec: 560d57d204a0

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 riscv64.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/riscv64.c b/riscv64.c
index 0e2b906..1506e05 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -131,7 +131,65 @@ riscv64_verify_symbol(const char *name, ulong value, char type)
 void
 riscv64_dump_machdep_table(ulong arg)
 {
-	/* TODO: */
+	int others = 0;
+
+	fprintf(fp, "              flags: %lx (", machdep->flags);
+	if (machdep->flags & KSYMS_START)
+		fprintf(fp, "%sKSYMS_START", others++ ? "|" : "");
+	fprintf(fp, ")\n");
+
+	fprintf(fp, "             kvbase: %lx\n", machdep->kvbase);
+	fprintf(fp, "  identity_map_base: %lx\n", machdep->identity_map_base);
+	fprintf(fp, "           pagesize: %d\n", machdep->pagesize);
+	fprintf(fp, "          pageshift: %d\n", machdep->pageshift);
+	fprintf(fp, "           pagemask: %llx\n", machdep->pagemask);
+	fprintf(fp, "         pageoffset: %lx\n", machdep->pageoffset);
+	fprintf(fp, "        pgdir_shift: %ld\n", machdep->machspec->va_bits - 9);
+	fprintf(fp, "       ptrs_per_pgd: %u\n", PTRS_PER_PGD);
+	fprintf(fp, "       ptrs_per_pte: %d\n", PTRS_PER_PTE);
+	fprintf(fp, "          stacksize: %ld\n", machdep->stacksize);
+	fprintf(fp, "                 hz: %d\n", machdep->hz);
+	fprintf(fp, "            memsize: %ld (0x%lx)\n",
+		machdep->memsize, machdep->memsize);
+	fprintf(fp, "               bits: %d\n", machdep->bits);
+	fprintf(fp, "         back_trace: riscv64_back_trace_cmd()\n");
+	fprintf(fp, "    processor_speed: riscv64_processor_speed()\n");
+	fprintf(fp, "              uvtop: riscv64_uvtop()\n");
+	fprintf(fp, "              kvtop: riscv64_kvtop()\n");
+	fprintf(fp, "    get_stack_frame: riscv64_get_stack_frame()\n");
+	fprintf(fp, "      get_stackbase: generic_get_stackbase()\n");
+	fprintf(fp, "       get_stacktop: generic_get_stacktop()\n");
+	fprintf(fp, "      translate_pte: riscv64_translate_pte()\n");
+	fprintf(fp, "        memory_size: generic_memory_size()\n");
+	fprintf(fp, "      vmalloc_start: riscv64_vmalloc_start()\n");
+	fprintf(fp, "       is_task_addr: riscv64_is_task_addr()\n");
+	fprintf(fp, "      verify_symbol: riscv64_verify_symbol()\n");
+	fprintf(fp, "         dis_filter: generic_dis_filter()\n");
+	fprintf(fp, "           dump_irq: generic_dump_irq()\n");
+	fprintf(fp, "    show_interrupts: generic_show_interrupts()\n");
+	fprintf(fp, "   get_irq_affinity: generic_get_irq_affinity()\n");
+	fprintf(fp, "           cmd_mach: riscv64_cmd_mach()\n");
+	fprintf(fp, "       get_smp_cpus: riscv64_get_smp_cpus()\n");
+	fprintf(fp, "          is_kvaddr: riscv64_is_kvaddr()\n");
+	fprintf(fp, "          is_uvaddr: riscv64_is_uvaddr()\n");
+	fprintf(fp, "       verify_paddr: generic_verify_paddr()\n");
+	fprintf(fp, "    init_kernel_pgd: NULL\n");
+	fprintf(fp, "    value_to_symbol: generic_machdep_value_to_symbol()\n");
+	fprintf(fp, "  line_number_hooks: NULL\n");
+	fprintf(fp, "      last_pgd_read: %lx\n", machdep->last_pgd_read);
+	fprintf(fp, "      last_p4d_read: %lx\n", machdep->machspec->last_p4d_read);
+	fprintf(fp, "      last_pud_read: %lx\n", machdep->last_pud_read);
+	fprintf(fp, "      last_pmd_read: %lx\n", machdep->last_pmd_read);
+	fprintf(fp, "     last_ptbl_read: %lx\n", machdep->last_ptbl_read);
+	fprintf(fp, "                pgd: %lx\n", (ulong)machdep->pgd);
+	fprintf(fp, "                p4d: %lx\n", (ulong)machdep->machspec->p4d);
+	fprintf(fp, "                pud: %lx\n", (ulong)machdep->pud);
+	fprintf(fp, "                pmd: %lx\n", (ulong)machdep->pmd);
+	fprintf(fp, "               ptbl: %lx\n", (ulong)machdep->ptbl);
+	fprintf(fp, "  section_size_bits: %ld\n", machdep->section_size_bits);
+	fprintf(fp, "   max_physmem_bits: %ld\n", machdep->max_physmem_bits);
+	fprintf(fp, "  sections_per_root: %ld\n", machdep->sections_per_root);
+	fprintf(fp, "           machspec: %lx\n", (ulong)machdep->machspec);
 }
 
 static ulong
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
