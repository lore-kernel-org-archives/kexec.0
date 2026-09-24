Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D138FC98314
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 07:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCdafuH2/Uxe28HFseeKEn19ps0WKwSir3Zjwz4Z0eY=; b=QOUoJc5wLiPR+mXxg0ftwK2now
	BmssPuG5KsfXnrnRYiODl0CWqwvjYLhhvJ5W2wSH6bem9ak7qjoB0bGwZvVGN8S1dS+jE5VyTJ0zm
	2gVbRYaX7wVKgVDU+TlKFO9rswRz0IVB/Ba0VLgwaC6VioCPi1JEJ00dHE8iPoUAujxsy0TrbUhok
	RJ0+B3S3CY8q55fLhto132TAIAnq7vivFGnHK2gGOova6btI0/0wqVXEyWZxfblfGcaT/r0AvmAYj
	tw9cA3160uE4hNly9kbPvwpdQm6FhLU1jeX65hE8rBdb8iu+7X95Sn9GU+5AQDvkFMGFhOOsh+6BE
	C0R7LXVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9eMJ-0000000ANMq-49vx;
	Thu, 24 Sep 2026 07:59:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9eMI-0000000ANMd-2bZY
	for kexec@bombadil.infradead.org;
	Thu, 24 Sep 2026 07:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uCdafuH2/Uxe28HFseeKEn19ps0WKwSir3Zjwz4Z0eY=; b=qIGMX6/h3q248OBETpYfgS0uDj
	7SfbepIpV3O7kTqaUN3zBmULG/38CRRdsT4TpyOMuaBkSju9nwICo88oHFgSGjjd9EGwauvQEKVl8
	hv2Pvn8gYxDMTUyBtX9UyRtgl9DPuX81L76u4oWTQp7hTnBQZcuLi6A/U6jC+0gbTQ4aGPS6homeu
	FKUulnH4KD6WG2C6NjaHhsoMx4BLDsTweAU0RRCQSqTyTicswvD0CmrTTvys3poen5a1rf7dk5Wsc
	0UuOI8CU3XbOvCgWOz/ZGEBMU0PElAln7MygAjj9Z63coK/DuVKK3O8cm2XqVgCPwzf3I5XlFW710
	H/zWbEOw==;
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9eMD-0000000Fgr9-22QM
	for kexec@lists.infradead.org;
	Thu, 24 Sep 2026 07:59:08 +0000
X-UUID: b6d53262b7ed11f19a56ed5b684f684d-20260924
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cb111aff-4125-417d-a602-48041cbe1fbe,IP:20,
	URL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.3.19,REQID:cb111aff-4125-417d-a602-48041cbe1fbe,IP:20,UR
	L:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:feb0b3b7ee6932ed16d02d9d7988ff3e,BulkI
	D:260924155827EAH3VYUG,BulkQuantity:0,SF:19|38|66|72|78|81|82|102|127|136|
	850|865|898,TC:nil,Content:0|15|50|99,EDM:-19|2|-100,IP:-2,URL:0,File:nil,
	RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b6d53262b7ed11f19a56ed5b684f684d-20260924
X-User: lianyangyang@kylinos.cn
Received: from localhost.localdomain [(39.156.73.11)] by mailgw.kylinos.cn
	(envelope-from <lianyangyang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1967902563; Thu, 24 Sep 2026 15:58:22 +0800
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
Subject: [PATCH v2] LoongArch: kdump: add arch_crash_save_vmcoreinfo() support
Date: Thu, 24 Sep 2026 15:56:55 +0800
Message-Id: <20260924075655.375632-1-lianyangyang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260923060349.146780-1-lianyangyang@kylinos.cn>
References: <20260923060349.146780-1-lianyangyang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_085906_378626_7FE38379 
X-CRM114-Status: GOOD (  16.12  )
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
V2 -> V1: Export VMEMMAP_END + 1 to make it an exclusive bound, matching
          what tools like makedumpfile expect.
          Add Tested-by tag from Tao Cui.

 .../admin-guide/kdump/vmcoreinfo.rst          | 29 +++++++++++++++++++
 arch/loongarch/kernel/Makefile                |  1 +
 arch/loongarch/kernel/vmcore_info.c           | 21 ++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 arch/loongarch/kernel/vmcore_info.c

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 7663c610fe90..2ff921232616 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -594,3 +594,32 @@ va_kernel_pa_offset
 
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
index 000000000000..fb703b716253
--- /dev/null
+++ b/arch/loongarch/kernel/vmcore_info.c
@@ -0,0 +1,21 @@
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
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+}
-- 
2.25.1


