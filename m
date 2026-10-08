Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA63CA6007
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 02:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CgcNlsxcMo959axM9HhFkWRFdv9y7UY2NnaNAKcvJqA=; b=mgkTZd4pgdqFeBANg0kEyFHmtY
	fb/5VmOLaoqEQrDGcSeeWU5Nv8WRgU9ITe7d1lZxBJVOJQ3UcNk/iJfviX+MP0KDZWc+4kBCS4IkI
	qHbHYuord5a1edrIpYQ11e9FDCBVm40NndE7hdKrZmD6Mkp2xg6QYNKaChqrPT+tn/Q7t1ZzQJGDj
	c8zunx5dWisaZYrWkvH4n7pSj7lesQe/8IrdZecRb2gjGOKJeYlrVVDIlTIAhzbdrsTHnRTnadUlr
	gpkXzD+SBfdwl/quBGPq9m95F3puC31azz+LbcY5ioWjWWDvuJZ1uY7sAaKJdQwPmBDP2v3r8ur54
	MZiV/TZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEdz7-00000003PI4-1hAJ;
	Thu, 08 Oct 2026 02:35:53 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEdz4-00000003PHA-0DtI
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 02:35:52 +0000
X-UUID: ee459a10c2c011f19a56ed5b684f684d-20261008
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:043ab7c5-33e0-466a-94bd-72c1afd6518b,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:043ab7c5-33e0-466a-94bd-72c1afd6518b,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,ACTI
	ON:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:f6fc088eedafb6138651ddfddfcb4f23,BulkI
	D:261008103534QVX47VGW,BulkQuantity:0,SF:19|38|66|72|78|81|82|102|127|136|
	850|865|898,TC:nil,Content:0|15|50|99,EDM:-19|2|-100,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ee459a10c2c011f19a56ed5b684f684d-20261008
X-User: lianyangyang@kylinos.cn
Received: from localhost.localdomain [(39.156.73.11)] by mailgw.kylinos.cn
	(envelope-from <lianyangyang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 50174354; Thu, 08 Oct 2026 10:35:31 +0800
From: Yangyang Lian <lianyangyang@kylinos.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Dave Young <ruirui.yang@linux.dev>,
	WANG Xuerui <kernel@xen0n.name>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yangyang Lian <lianyangyang@kylinos.cn>,
	Haoran Jiang <jianghaoran@kylinos.cn>,
	Tao Cui <cuitao@kylinos.cn>,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v3] LoongArch: kdump: add arch_crash_save_vmcoreinfo() support
Date: Thu,  8 Oct 2026 10:34:19 +0800
Message-Id: <20261008023419.118623-1-lianyangyang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260924075655.375632-1-lianyangyang@kylinos.cn>
References: <20260924075655.375632-1-lianyangyang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261007_193550_423416_C6FCAE2A 
X-CRM114-Status: GOOD (  16.45  )
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

Since commit 23c85094fe18 ("proc/kcore: add vmcoreinfo note to
/proc/kcore") the kernel has exported the vmcoreinfo PT_NOTE on
/proc/kcore as wellas /proc/vmcore.

LoongArch does not provide arch_crash_save_vmcoreinfo(), so the
arch-specific values are missing from the vmcoreinfo PT_NOTE. The
generic exporter in kernel/vmcore_info.c already provides
NUMBER(VMALLOC_START), but tools like crash cannot derive the module
and vmemmap ranges, VA_BITS, or the KASLR offset of a LoongArch dump.

Since commit 18210a104bb9 ("LoongArch: Expand module virtual address
space to 2GB") the vmalloc and module boundaries are no longer stable
across kernel versions either, so vmcoreinfo is the only reliable
source for them.

Provide this function in a separate file that is built at the same time
as its caller in kernel/vmcore_info.c, and add a LOONGARCH64 section to
Documentation/admin-guide/kdump/vmcoreinfo.rst.

Reported-by: Haoran Jiang <jianghaoran@kylinos.cn>
Suggested-by: Haoran Jiang <jianghaoran@kylinos.cn>
Tested-by: Tao Cui <cuitao@kylinos.cn>
Co-developed-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Yangyang Lian <lianyangyang@kylinos.cn>
---
V3 -> V2: Export PAGE_OFFSET, as suggested by Huacai Chen. It is not a
          fixed value on LoongArch (PAGE_OFFSET = CACHE_BASE + PHYS_OFFSET)
          and RISC-V already exports it.
V2 -> V1: Export VMEMMAP_END + 1 to make it an exclusive bound, matching
          what tools like makedumpfile expect.
          Add Tested-by tag from Tao Cui.

 .../admin-guide/kdump/vmcoreinfo.rst          | 36 +++++++++++++++++++
 arch/loongarch/kernel/Makefile                |  1 +
 arch/loongarch/kernel/vmcore_info.c           | 22 ++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 arch/loongarch/kernel/vmcore_info.c

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 7663c610fe90..dd1f1d6225b6 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -594,3 +594,39 @@ va_kernel_pa_offset
 
 Indicates the offset between the kernel virtual and physical mappings.
 Used to translate virtual to physical addresses.
+
+LOONGARCH64
+===========
+
+VA_BITS
+-------
+
+The maximum number of bits for virtual addresses. Used to compute the
+virtual memory ranges.
+
+PHYS_OFFSET
+-----------
+
+Indicates the physical address of the start of memory. Used to translate
+virtual to physical addresses.
+
+PAGE_OFFSET
+-----------
+
+Indicates the virtual kernel start address of the direct-mapped RAM region.
+Used together with PHYS_OFFSET to translate between virtual and physical
+addresses.
+
+KERNELOFFSET
+------------
+
+The kernel randomization offset. Used to locate the kernel text in
+virtual memory. If KASLR is disabled, this value is zero.
+
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
+-----------------------------------------------------------------------------
+
+Used to get the correct ranges:
+	MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
+	VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
+	VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page array.
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 001924877772..6260c15adaba 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_RELOCATABLE)	+= relocate.o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_efi.o kexec_elf.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
+obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 
 obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
 obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
diff --git a/arch/loongarch/kernel/vmcore_info.c b/arch/loongarch/kernel/vmcore_info.c
new file mode 100644
index 000000000000..e4efc35165b1
--- /dev/null
+++ b/arch/loongarch/kernel/vmcore_info.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/vmcore_info.h>
+#include <asm/addrspace.h>
+#include <asm/pgtable.h>
+#include <asm/setup.h>
+
+void arch_crash_save_vmcoreinfo(void)
+{
+	VMCOREINFO_NUMBER(VA_BITS);
+	/* NUMBER(VMALLOC_START) is exported by the generic code */
+	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+#ifdef CONFIG_64BIT
+	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
+	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", (unsigned long)vmemmap);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END + 1);
+#endif
+	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%lx\n", PHYS_OFFSET);
+	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+}
-- 
2.25.1


