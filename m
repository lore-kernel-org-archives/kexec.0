Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB320CCA481
	for <kexec@archiver.kernel.org>; Fri, 15 Jul 2022 10:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=FNGXZOZN+JLVRGl7H7w/Fc/TBFN0UHgsHcTIqbj8suA=; b=xrYz2nOm0VoOGB
	K+6a3x+ECkuyc17VCIvQwoakR4yqyBiUFmmTc2jl2baqV/8EPvvSiu1Dcbif1Pr9iMr1r0zQch9Lp
	ypNCZq7y18nbxbECNfPelhVSEeqj30AYrk8aWCipHvwl2VcjZOZGtIsU3aKtG6A0Gq69OjYSGL+dJ
	vHnc9b4WiA+2D/nSs4FoL9uGavgREqu7RUg8H9PL3oyCkgfD9y+mNVo475+fu+goqky2DCpVSXIIA
	nZ88+B4LDF87TBH2KaZ0zEO5UU6p8CCSRqFZV5NOfn2z96JGdgofqWXR0UfNbCSLla5wunG0EYSJl
	cYK+Oi965UUpqRzExaxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCICT-006Hpa-1L; Fri, 15 Jul 2022 10:05:33 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCICM-006Hmf-NZ
	for kexec@lists.infradead.org; Fri, 15 Jul 2022 10:05:29 +0000
Received: from linux.localdomain (unknown [113.200.148.30])
	by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf+PaO9Fi9osgAA--.347S2;
	Fri, 15 Jul 2022 18:05:15 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
Subject: [PATCH] kexec-tools: Remove duplicate ultoa() definitions and redefine it
Date: Fri, 15 Jul 2022 18:05:14 +0800
Message-Id: <1657879514-29377-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxf+PaO9Fi9osgAA--.347S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1rZFy8XFyxXF45Zw17trb_yoW7Jw1xp3
	ZIy3sxJw40v3WDtr97JFWDXw43W3srKry2kanFq3s7X3W5AF1aq3yfXF1IqFyUJrWF9F1I
	krW5JrykZr4xuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8twCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUy0tCDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_030527_143676_E9B71A6C 
X-CRM114-Status: GOOD (  11.16  )
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

There exist duplicate ultoa() definitions in many archs, remove them,
and also redefine ultoa() in kexec/kexec.h to make it more readable.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kexec/arch/i386/crashdump-x86.c    | 19 -------------------
 kexec/arch/mips/crashdump-mips.c   | 19 -------------------
 kexec/arch/mips/kexec-elf-mips.c   | 19 -------------------
 kexec/arch/ppc64/crashdump-ppc64.c | 19 -------------------
 kexec/arch/sh/crashdump-sh.c       | 19 -------------------
 kexec/kexec.h                      | 16 ++++++++++++++++
 6 files changed, 16 insertions(+), 95 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 9826f6d..df1f24c 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -601,25 +601,6 @@ static int delete_memmap(struct memory_range *memmap_p, int *nr_memmap,
 	return 0;
 }
 
-/* Converts unsigned long to ascii string. */
-static void ultoa(unsigned long i, char *str)
-{
-	int j = 0, k;
-	char tmp;
-
-	do {
-		str[j++] = i % 10 + '0';
-	} while ((i /=10) > 0);
-	str[j] = '\0';
-
-	/* Reverse the string. */
-	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
-		tmp = str[k];
-		str[k] = str[j];
-		str[j] = tmp;
-	}
-}
-
 static void cmdline_add_memmap_internal(char *cmdline, unsigned long startk,
 					unsigned long endk, int type)
 {
diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index d9f4515..00f4335 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -224,25 +224,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	return 0;
 }
 
-/* Converts unsigned long to ascii string. */
-static void ultoa(unsigned long i, char *str)
-{
-	int j = 0, k;
-	char tmp;
-
-	do {
-		str[j++] = i % 10 + '0';
-	} while ((i /= 10) > 0);
-	str[j] = '\0';
-
-	/* Reverse the string. */
-	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
-		tmp = str[k];
-		str[k] = str[j];
-		str[j] = tmp;
-	}
-}
-
 /* Adds the appropriate mem= options to command line, indicating the
  * memory region the new kernel can use to boot into. */
 static int cmdline_add_mem(char *cmdline, unsigned long addr,
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 31f4c47..230d806 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -40,25 +40,6 @@ static const int probe_debug = 0;
 #define CMDLINE_PREFIX "kexec "
 static char cmdline_buf[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
 
-/* Converts unsigned long to ascii string. */
-static void ultoa(unsigned long i, char *str)
-{
-	int j = 0, k;
-	char tmp;
-
-	do {
-		str[j++] = i % 10 + '0';
-	} while ((i /= 10) > 0);
-	str[j] = '\0';
-
-	/* Reverse the string. */
-	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
-		tmp = str[k];
-		str[k] = str[j];
-		str[j] = tmp;
-	}
-}
-
 /* Adds initrd parameters to command line. */
 static int cmdline_add_initrd(char *cmdline, unsigned long addr, char *new_para)
 {
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 91f9521..6d47898 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -436,25 +436,6 @@ err:
 	return -1;
 }
 
-/* Converts unsigned long to ascii string. */
-static void ultoa(uint64_t i, char *str)
-{
-	int j = 0, k;
-	char tmp;
-
-	do {
-		str[j++] = i % 10 + '0';
-	} while ((i /=10) > 0);
-	str[j] = '\0';
-
-	/* Reverse the string. */
-	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
-		tmp = str[k];
-		str[k] = str[j];
-		str[j] = tmp;
-	}
-}
-
 static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
 				char *byte)
 {
diff --git a/kexec/arch/sh/crashdump-sh.c b/kexec/arch/sh/crashdump-sh.c
index aa25dea..36e9aaf 100644
--- a/kexec/arch/sh/crashdump-sh.c
+++ b/kexec/arch/sh/crashdump-sh.c
@@ -90,25 +90,6 @@ static struct crash_elf_info elf_info32 =
 	page_offset: PAGE_OFFSET,
 };
 
-/* Converts unsigned long to ascii string. */
-static void ultoa(unsigned long i, char *str)
-{
-	int j = 0, k;
-	char tmp;
-
-	do {
-		str[j++] = i % 10 + '0';
-	} while ((i /=10) > 0);
-	str[j] = '\0';
-
-	/* Reverse the string. */
-	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
-		tmp = str[k];
-		str[k] = str[j];
-		str[j] = tmp;
-	}
-}
-
 static int add_cmdline_param(char *cmdline, uint64_t addr, char *cmdstr,
 				char *byte)
 {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 0f97a97..8a05644 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -329,4 +329,20 @@ int xen_kexec_status(uint64_t kexec_flags);
 
 extern unsigned long long get_kernel_sym(const char *text);
 
+/* Converts unsigned long to ascii string. */
+static inline void ultoa(unsigned long val, char *str)
+{
+	char buf[36];
+	int len = 0, pos = 0;
+
+	do {
+		buf[len++] = val % 10;
+		val /= 10;
+	} while (val);
+
+	while (len)
+		str[pos++] = buf[--len] + '0';
+	str[pos] = 0;
+}
+
 #endif /* KEXEC_H */
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
