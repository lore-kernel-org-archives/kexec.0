Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF319C43219
	for <kexec@archiver.kernel.org>; Fri, 14 Oct 2022 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=azThDphqkIrkr7sQLTE7Me7kyEv+B7PDHN5ZPzv9yPY=; b=SM+i+XoQFvpgsm
	1TtWTEQ64EtJb2i3R08cAwvkCEre1QS+vWqepKdh1qRALqR2Odhoi7X6MN4236NbEpSV7NbgkPcvh
	/F7Gqm/wBdegmFy5HynjuLYSLhW6JpZ5Qc4Oi39qOvzRMM/q1EeByQbkVqpkmUINx9WprabTMUZN4
	8oSp+ug/R+5Q9Boa392/FHIRGOOMpOmRnu9XLd+KzahrZFMRtbhjb5977OJnAs5d+Buk18NoSy24e
	eOY9TJzYeTyX4NueXPreCjkSVFxm5Iqu2GHDSifXouus/JPSOeCbK8ERNkijiz/wtyv+T2Ghtuz/8
	pTrSMF35d062N4lvkI1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojFSw-00DxM2-F4; Fri, 14 Oct 2022 07:50:46 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ojFSp-00Dx6x-Mm; Fri, 14 Oct 2022 07:50:42 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VS6v5D._1665733712;
Received: from localhost.localdomain(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VS6v5D._1665733712)
          by smtp.aliyun-inc.com;
          Fri, 14 Oct 2022 15:48:33 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	anup@brainfault.org,
	heiko@sntech.de,
	guoren@kernel.org,
	mick@ics.forth.gr,
	alexandre.ghiti@canonical.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net,
	Conor.Dooley@microchip.com
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	crash-utility@redhat.com,
	heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com,
	hschauhan@nulltrace.org,
	yixun.lan@gmail.com,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Date: Fri, 14 Oct 2022 15:48:09 +0800
Message-Id: <20221014074810.4471-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221014_005039_958119_01297422 
X-CRM114-Status: GOOD (  13.22  )
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

Add arch_crash_save_vmcoreinfo(), which exports VM layout(MODULES, VMALLOC,
VMEMMAP and KERNEL_LINK_ADDR ranges), va bits and ram base for vmcore.

Default pagetable levels and PAGE_OFFSET aren't same for different kernel
version as below. For default pagetable levels, it sets sv57 on defaultly
in latest kernel and do fallback to try to set sv48 on boot time if sv57
is not supported in current hardware.

For ram base, the default value is 0x80200000 for qemu riscv64 env, 0x200000
for riscv64 SoC platform(eg, SoC platform of RISC-V XuanTie 910 CPU).

 * Linux Kernel 5.18 ~
 *      PGTABLE_LEVELS = 5
 *      PAGE_OFFSET = 0xff60000000000000
 * Linux Kernel 5.17 ~
 *      PGTABLE_LEVELS = 4
 *      PAGE_OFFSET = 0xffffaf8000000000
 * Linux Kernel 4.19 ~
 *      PGTABLE_LEVELS = 3
 *      PAGE_OFFSET = 0xffffffe000000000

Since these configurations change from time to time and version to version,
it is preferable to export them via vmcoreinfo than to change the crash's
code frequently, it can simplify the development of crash tool.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/kernel/Makefile     |  1 +
 arch/riscv/kernel/crash_core.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/riscv/kernel/crash_core.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index db6e4b1294ba..4cf303a779ab 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
 obj-$(CONFIG_KEXEC_FILE)	+= elf_kexec.o machine_kexec_file.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
+obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
 
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
new file mode 100644
index 000000000000..8d7f5ff108da
--- /dev/null
+++ b/arch/riscv/kernel/crash_core.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/crash_core.h>
+#include <linux/pagemap.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	VMCOREINFO_NUMBER(VA_BITS);
+	VMCOREINFO_NUMBER(phys_ram_base);
+
+	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
+#ifdef CONFIG_64BIT
+	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
+	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
+#endif
+
+	if (IS_ENABLED(CONFIG_64BIT)) {
+#ifdef CONFIG_KASAN
+		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_START)=0x%lx\n", KASAN_SHADOW_START);
+		vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_END)=0x%lx\n", KASAN_SHADOW_END);
+#endif
+		vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
+		vmcoreinfo_append_str("NUMBER(ADDRESS_SPACE_END)=0x%lx\n", ADDRESS_SPACE_END);
+	}
+}
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
