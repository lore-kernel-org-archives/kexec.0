Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C0FC64ED8
	for <kexec@archiver.kernel.org>; Fri, 24 Feb 2023 09:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=noY6YyDSMeEdx4w8MpbEsBVo5N2sKVskW02SmIIzEiA=; b=sGcj2EfqZYwG1M
	4NEdJnl968uKGZSmqJ5UgFKAOlQUeJXYUPg1BX2V93SBvToi8+uVkY6TFWl9PwTPXe4pLXBrpCC5a
	U8itFmq7wc8hTlZztcRUuzsAu/wKXYUScWrXuatMZEpG8ODbC23qnZqdGBw2W+gej0HZtp8hM09mh
	pKD5qPp6gcyyvQZwGZsnIXtupMIhX/r8ISMWPGD27VaUlTIYbkY0doLVlcWvtqZOHzntdP05I/tAL
	SPswiFTAPviHIIUMYnZ6TyLFa00ujfZNqsotrRG9vumRctr7cYt/gep5Zj+9lEdZ+M5SBXQoAIKqj
	N7gmud9+eTm06wFOYMIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVUjZ-001kmN-SU; Fri, 24 Feb 2023 09:51:21 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVUjV-001kj4-Ic
	for kexec@lists.infradead.org; Fri, 24 Feb 2023 09:51:19 +0000
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxYeWPiPhjlqIEAA--.3660S3;
	Fri, 24 Feb 2023 17:51:11 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxUuWNiPhjInw6AA--.5816S3;
	Fri, 24 Feb 2023 17:51:09 +0800 (CST)
From: Youling Tang <tangyouling@loongson.cn>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
Subject: [PATCH 2/2] LoongArch: kdump: Set up kernel image segment
Date: Fri, 24 Feb 2023 17:51:08 +0800
Message-Id: <1677232268-2451-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
References: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8DxUuWNiPhjInw6AA--.5816S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXry8GFW5WF4xGrWkJr1UWrg_yoWrKF1fpF
	y7AFykGr4rWwnxtr97Ja98Zwn5X3s7Gr12qFyayry8uF4DXr1UXw18XasrXF1Utw4rKryI
	qrn5twn09a18Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
	b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
	1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
	x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
	0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230224_015118_020846_D2FB73BB 
X-CRM114-Status: GOOD (  14.05  )
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

On LoongArch, we can use the same kernel image as 1st kernel when
[1] is merged, but we have to modify the entry point as well as
segments' addresses in the kernel's elf header (or pei format
vmlinux.efi) in order to load them into correct places.

[1]: https://lore.kernel.org/loongarch/1677150391-12838-1-git-send-email-tangyouling@loongson.cn/T/#t

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kexec/arch/loongarch/crashdump-loongarch.c | 22 ++++++++++++++++++++++
 kexec/arch/loongarch/crashdump-loongarch.h |  1 +
 kexec/arch/loongarch/kexec-elf-loongarch.c |  8 ++++++++
 kexec/arch/loongarch/kexec-loongarch.c     |  3 ++-
 kexec/arch/loongarch/kexec-pei-loongarch.c |  7 +++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/kexec/arch/loongarch/crashdump-loongarch.c b/kexec/arch/loongarch/crashdump-loongarch.c
index aaf6cf3..81250e4 100644
--- a/kexec/arch/loongarch/crashdump-loongarch.c
+++ b/kexec/arch/loongarch/crashdump-loongarch.c
@@ -183,6 +183,28 @@ int load_crashdump_segments(struct kexec_info *info)
 	return 0;
 }
 
+/*
+ * e_entry and p_paddr are actually in virtual address space.
+ * Those values will be translated to physcal addresses by using
+ * virt_to_phys() in add_segment().
+ * So let's fix up those values for later use so the memory base will be
+ * correctly replaced with crash_reserved_mem[usablemem_rgns.size - 1].start.
+ */
+void fixup_elf_addrs(struct mem_ehdr *ehdr)
+{
+	struct mem_phdr *phdr;
+	int i;
+
+	ehdr->e_entry += crash_reserved_mem[usablemem_rgns.size - 1].start;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &ehdr->e_phdr[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+		phdr->p_paddr += crash_reserved_mem[usablemem_rgns.size - 1].start;
+	}
+}
+
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 {
 	if (!usablemem_rgns.size)
diff --git a/kexec/arch/loongarch/crashdump-loongarch.h b/kexec/arch/loongarch/crashdump-loongarch.h
index 3eb4e0a..25ff24b 100644
--- a/kexec/arch/loongarch/crashdump-loongarch.h
+++ b/kexec/arch/loongarch/crashdump-loongarch.h
@@ -8,6 +8,7 @@ extern struct memory_range elfcorehdr_mem;
 
 int load_crashdump_segments(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
+void fixup_elf_addrs(struct mem_ehdr *ehdr);
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
 
 #define PAGE_OFFSET	0x9000000000000000ULL
diff --git a/kexec/arch/loongarch/kexec-elf-loongarch.c b/kexec/arch/loongarch/kexec-elf-loongarch.c
index 2bf128f..45387ca 100644
--- a/kexec/arch/loongarch/kexec-elf-loongarch.c
+++ b/kexec/arch/loongarch/kexec-elf-loongarch.c
@@ -90,6 +90,14 @@ int elf_loongarch_load(int argc, char **argv, const char *kernel_buf,
 		}
 	}
 
+	/* load the kernel */
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+		/*
+		 * offset addresses in elf header in order to load
+		 * vmlinux (elf_exec) into crash kernel's memory.
+		 */
+		fixup_elf_addrs(&ehdr);
+
 	info->entry = (void *)virt_to_phys(ehdr.e_entry);
 
 	result = elf_exec_load(&ehdr, info);
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index 4c7361c..f47c998 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -253,7 +253,8 @@ unsigned long loongarch_locate_kernel_segment(struct kexec_info *info)
 		unsigned long hole_end;
 
 		hole = (crash_reserved_mem[usablemem_rgns.size - 1].start < mem_min ?
-				mem_min : crash_reserved_mem[usablemem_rgns.size - 1].start);
+				mem_min : crash_reserved_mem[usablemem_rgns.size - 1].start) +
+				loongarch_mem.text_offset;
 		hole = _ALIGN_UP(hole, MiB(1));
 		hole_end = hole + loongarch_mem.text_offset + loongarch_mem.image_size;
 
diff --git a/kexec/arch/loongarch/kexec-pei-loongarch.c b/kexec/arch/loongarch/kexec-pei-loongarch.c
index f86ac61..1a11103 100644
--- a/kexec/arch/loongarch/kexec-pei-loongarch.c
+++ b/kexec/arch/loongarch/kexec-pei-loongarch.c
@@ -66,6 +66,13 @@ int pei_loongarch_load(int argc, char **argv, const char *buf,
 
 	kernel_entry = virt_to_phys(loongarch_header_kernel_entry(header));
 
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+		/*
+		 * offset addresses in order to load vmlinux.efi into
+		 * crash kernel's memory.
+		 */
+		kernel_entry += crash_reserved_mem[usablemem_rgns.size - 1].start;
+
 	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
 	dbgprintf("%s: kernel_entry:   %016lx\n", __func__, kernel_entry);
 	dbgprintf("%s: image_size:     %016lx\n", __func__,
-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
