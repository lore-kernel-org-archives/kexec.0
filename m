Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13926C982F6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+SlWroSdaGxZWUb4GAQgkH+PVdX8bfzP0oz7opOlFk=; b=mqd2UJkHimEDq2Jge1olwmPLBc
	d3oDHUCg3/P6wIl5RDIGw59cjJ3TS/TlpJplBOs9a0Q/yUPcpLQegpViaF+T5MLHKCsTVM6eOIBk7
	+GghQxP6TPJ1037ip2qOlwBUqf5HObsTJ9Pe2ReYrBhiKe2rP+y+rojn9FRqPUJ7cDvkr/LXXwqVy
	Ny22GqEfYwPLaZD0dBnKPPt0xhftjn8CqXRiMtfTvGcjfQ8OYYXWC7XQQiu0FWaTGtQcWHO4YYcWw
	qB4sktp7H3Rtzs7lAidWRtFIFwu9Y2WExZPtDFauneWo3+rKl+pGHmggSJ9R7Y2nX7y/LLWuJKbgh
	32JpdXUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4M-00000000MHA-46Sj;
	Sun, 20 Sep 2026 20:23:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NMU-00000000Idp-0ASi
	for kexec@bombadil.infradead.org;
	Sun, 20 Sep 2026 19:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=H+SlWroSdaGxZWUb4GAQgkH+PVdX8bfzP0oz7opOlFk=; b=BiiGpM1UHKdQ/dlMsWhSxcxpEf
	8Eo3Te/p3hkFuOVOlYhSALspBNln6Jj5MeCERx0spahP08iOefu48WYz7j0Fx2FeUDwCaTWDD4R1k
	yJrU0rGfhKMV14jgH1Vwl0/gyJOCKDBExzgwXbIVPEm2gaZPatNzcQm9BHFdL14whvu1AwbN781le
	toAQzQicegOt1gJLrANJKc2glswOveRiUZcMemR0FSnRae3T5UHC8nF09bLZj562KFxacN/ubCbIA
	B6lHpefonB3EycZW2LAtzEYh7lfwO7lTf8OrLmh0w6QeXKhDqHAth6gWrVPhlaaqJfj/uBcW38J2U
	zwg9Busg==;
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8NMR-0000000BaRm-0Kjr
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:38:04 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d43ac8d1fso15034127b3.0
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933081; x=1790537881; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H+SlWroSdaGxZWUb4GAQgkH+PVdX8bfzP0oz7opOlFk=;
        b=Kb92NEXkQ0l53Ho7eU2l2IOy7oN2hrQPO8iDTE6TbQ72ihEX/nzuEt0c3qYq9RjApq
         EkNMtjxMXoq3y0pjr7jqDdgBswrt6QtnFoAXbppi+xradxeVxEGn3u7/du+Gw04l3vg0
         /E7/Jy/e7jZjXESr0fZRvk7PEtF3NEVbU6L9geB7gnVHlSh0ZqvyENV6pBypGPX9jtJb
         YeN7FJ92FpEtcmQCdlQFt7gyDK2Lr5k4a/4sptrCFUOq+/7OQVb/okA2NihhsQiVe1zC
         S5CJmCHnL21HQXslpmG0pNR/sQsGuL5EZCe3cbqNZHGmZLmUgJSROjB36EqUpT2yNYUK
         iZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933081; x=1790537881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H+SlWroSdaGxZWUb4GAQgkH+PVdX8bfzP0oz7opOlFk=;
        b=kr/wZZEvh0YzUIVyYW3rT3tXhACgt0bCIJXmv2H3u79pk6CpO5xAhBGdz0FwNByb2k
         NoblwZR3OI6Q6k4Q9dEnfVMK6Hip+Aflb9SE7ezlVZBd2eiKjwEyf3SB+RVqVDyVwGuu
         +mLCyEoHLNwIv0sBQWReCrGV8zLnPbNOPk9Iu9xVBUN1q1dw/mqVjx7lARCoDOUInmdz
         e6DLhbg8MxeT/YDyL0/0muR7B6mN17SELoY37ilRYuFPt12l33pHJn7eX8vZ1FkRx6o4
         xouXjsiYErIqaK13by/YMv55MMM53MdVFmoCfYb8vf2PfFReguuN4/+Sg0wfqw+bxfH6
         mKgg==
X-Forwarded-Encrypted: i=1; AKwUvBy+GiCgXsDsqlBsAFqCW3ca8YWxqL/3RUs2kyuv30TojOUGbAt5Tj5kZGWTkcHGM6o27bZBzA==@lists.infradead.org
X-Gm-Message-State: AFuF++nt0B3acuhxXsrX330FtCOfrziooLMM88a+Z0ksi5UiOlKuv7P8
	hwB2NEMCaQCwLLmI08/7vMmsXuy0zPydYAVg7v2VRooWCr+JFQbpilYVe8t3WqEcBrI=
X-Gm-Gg: AYBFou3kkRqjjIJNZMNuDQ7o8CXmhyMTJkGfA8lqSLRNP2NWkLUzJTAMM6ULEcK/y9U
	BUmOMB50FP/b7WkYLj5wGkv+VWgR/kGFAh9gzTlr582Qz9p2Wd2ShmVoGhNdR/yLylGqNhfvPiO
	rYiXDWO3qThNMbbLfZ/wQdtLJUyjFA/k3kns8gWap/CJzCD+HVaPDzj1BTkLiGfQrGuwE9EQUHC
	WmGbAN7blCXpgPgqBb2VoQbIkUpk/gkWY5acIxCtEp3F5Fo4xTG5m5f8NjMp1OCkr6XWK6eTtsg
	PusS6LiiSjcvwVCdOosIlsR8VL/UhEfNwr82ggftg2JGuUSqUzhgj6nC9djbeKKbpj8p0HNT49e
	NJnMc+xrDLF7CXa3GBPILGKQIXWCAchmiM/kC1tA0UAh224Th3T48XkTp19LLo7lE698eQVukbh
	tT1oJJvGviPGkpe0ijtic0m9JMiOzn0M41jAeYiIxqiG+qxn4dcug+MsYMJ4uF1IDRfcWHHpUzm
	TVwJJkk9aDGcY43VZ0A8tlQtqj/wyFOCj0Yxfgz3twu8JuGp8VkDtiUSZTXGVIdIWrwhmuQCgya
	32MvHc6M1sPnvVC69+VO
X-Received: by 2002:a05:690c:60c7:b0:873:5c0f:280 with SMTP id 00721157ae682-89735f6df22mr25869157b3.42.1789933081162;
        Sun, 20 Sep 2026 12:38:01 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a46a44699sm18596057b3.19.2026.09.20.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:59 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 11/46] liveupdate: Define CPU preservation linker sections
Date: Sun, 20 Sep 2026 15:36:15 -0400
Message-ID: <20260920193650.3373435-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_203803_340029_60747922 
X-CRM114-Status: GOOD (  23.28  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Define CPU_PRESERVED_TEXT and CPU_PRESERVED_DATA linker macros to place
code and data required for CPU preservation into dedicated sections
(.text.cpu_preserved and .data.cpu_preserved).

These sections are preserved across live update transitions and mapped
executable/read-write as needed.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/asm-generic/vmlinux.lds.h     | 29 +++++++++++++++++
 include/linux/cpu_preserve.h          | 47 +++++++++++++++++++++++++++
 scripts/mod/modpost.c                 | 32 +++++++++++++++---
 tools/objtool/check.c                 | 35 +++++++++++++++++++-
 tools/objtool/include/objtool/check.h |  1 +
 tools/objtool/include/objtool/elf.h   |  2 +-
 6 files changed, 140 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/cpu_preserve.h

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..0dbaac582bcc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -655,6 +655,34 @@
 		*(.static_call.text)					\
 		__static_call_text_end = .;
 
+/*
+ * Page-aligned text and data sections for preserved CPUs.
+ * This code and data are KHO preserved when CPUs are preserved across
+ * live update.
+ */
+#ifdef CONFIG_LIVEUPDATE_CPU
+#define CPU_PRESERVED_TEXT						\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_text_start = .;				\
+		*(.text.cpu_preserved .text.cpu_preserved.*)		\
+		*(.cpu_preserved.text .cpu_preserved.text.*)		\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_text_end = .;
+
+#define CPU_PRESERVED_DATA						\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_data_start = .;				\
+		*(.data.cpu_preserved .data.cpu_preserved.*)		\
+		*(.cpu_preserved.data .cpu_preserved.data.*)		\
+		*(.rodata.cpu_preserved .rodata.cpu_preserved.*)	\
+		*(.bss..data.cpu_preserved .bss..data.cpu_preserved.*)	\
+		. = ALIGN(PAGE_SIZE);					\
+		__cpu_preserved_data_end = .;
+#else
+#define CPU_PRESERVED_TEXT
+#define CPU_PRESERVED_DATA
+#endif
+
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  KEEP(*(.head.text))
 
@@ -1155,6 +1183,7 @@
 		INIT_TASK_DATA(inittask)				\
 		NOSAVE_DATA						\
 		PAGE_ALIGNED_DATA(pagealigned)				\
+		CPU_PRESERVED_DATA					\
 		CACHE_HOT_DATA(cacheline)				\
 		CACHELINE_ALIGNED_DATA(cacheline)			\
 		READ_MOSTLY_DATA(cacheline)				\
diff --git a/include/linux/cpu_preserve.h b/include/linux/cpu_preserve.h
new file mode 100644
index 000000000000..f653838c383d
--- /dev/null
+++ b/include/linux/cpu_preserve.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Preserved CPU across Live Update
+ */
+#ifndef _LINUX_CPU_PRESERVE_H
+#define _LINUX_CPU_PRESERVE_H
+
+#include <linux/compiler.h>
+
+#ifdef CONFIG_LIVEUPDATE_CPU
+
+/*
+ * __cpu_preserved_text: Code executed by preserved physical CPUs during live
+ * update kexec handover in orphan mode.
+ *
+ * All code in this section must run without stack protector checks because
+ * per-CPU canary state may be invalid during handover and __stack_chk_fail()
+ * resides in regular .text, which gets overwritten during kexec before the
+ * incoming kernel boots.
+ *
+ * Architecture-specific requirements (such as disabling external retpolines
+ * and return thunks on x86) are supplied via ARCH_CPU_PRESERVED_TEXT.
+ */
+#ifndef ARCH_CPU_PRESERVED_TEXT
+#define ARCH_CPU_PRESERVED_TEXT
+#endif
+
+#define __cpu_preserved_text					\
+	__section(".text.cpu_preserved")			\
+	__no_stack_protector					\
+	ARCH_CPU_PRESERVED_TEXT
+#define __cpu_preserved_data	__section(".data.cpu_preserved")
+
+extern char __cpu_preserved_text_start[], __cpu_preserved_text_end[];
+extern char __cpu_preserved_data_start[], __cpu_preserved_data_end[];
+
+#else /* !CONFIG_LIVEUPDATE_CPU */
+
+#define __cpu_preserved_text
+#define __cpu_preserved_data
+
+#endif /* CONFIG_LIVEUPDATE_CPU */
+
+#endif /* _LINUX_CPU_PRESERVE_H */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 75374c64b8cc..51631cd2f6c4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -810,13 +810,27 @@ static void check_section(struct module *mod, struct elf_info *elf,
 #define ALL_INIT_SECTIONS ".init.*"
 #define ALL_EXIT_SECTIONS ".exit.*"
 
+#define ALL_CPU_PRESERVED_TEXT_SECTIONS \
+	".text.cpu_preserved", ".text.cpu_preserved.*", \
+	".cpu_preserved.text", ".cpu_preserved.text.*"
+
+#define ALL_CPU_PRESERVED_DATA_SECTIONS \
+	".data.cpu_preserved", ".data.cpu_preserved.*", \
+	".cpu_preserved.data", ".cpu_preserved.data.*", \
+	".rodata.cpu_preserved", ".rodata.cpu_preserved.*", \
+	".bss..data.cpu_preserved", ".bss..data.cpu_preserved.*"
+
+#define ALL_CPU_PRESERVED_SECTIONS \
+	ALL_CPU_PRESERVED_TEXT_SECTIONS, ALL_CPU_PRESERVED_DATA_SECTIONS
+
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
 		".kprobes.text", ".cpuidle.text", ".noinstr.text", \
 		".ltext", ".ltext.*"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", \
-		".coldtext", ".softirqentry.text", ".irqentry.text"
+		".coldtext", ".softirqentry.text", ".irqentry.text", \
+		ALL_CPU_PRESERVED_TEXT_SECTIONS
 
 #define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
@@ -827,6 +841,7 @@ enum mismatch {
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
 	EXTABLE_TO_NON_TEXT,
+	CPU_PRESERVED_TO_NON_PRESERVED,
 };
 
 /**
@@ -843,13 +858,19 @@ enum mismatch {
  * @mismatch: Type of mismatch.
  */
 struct sectioncheck {
-	const char *fromsec[20];
-	const char *bad_tosec[20];
-	const char *good_tosec[20];
+	const char *fromsec[32];
+	const char *bad_tosec[32];
+	const char *good_tosec[32];
 	enum mismatch mismatch;
 };
 
 static const struct sectioncheck sectioncheck[] = {
+/* Do not reference non-preserved code/data from cpu_preserved sections */
+{
+	.fromsec = { ALL_CPU_PRESERVED_SECTIONS, NULL },
+	.good_tosec = { ALL_CPU_PRESERVED_SECTIONS, NULL },
+	.mismatch = CPU_PRESERVED_TO_NON_PRESERVED,
+},
 /* Do not reference init/exit code/data from
  * normal code and data
  */
@@ -960,6 +981,9 @@ static const struct sectioncheck *section_mismatch(
 static int secref_whitelist(const char *fromsec, const char *fromsym,
 			    const char *tosec, const char *tosym)
 {
+	if (match(fromsec, PATTERNS(ALL_CPU_PRESERVED_SECTIONS)))
+		return 1;
+
 	/* Check for pattern 1 */
 	if (match(tosec, PATTERNS(ALL_INIT_DATA_SECTIONS)) &&
 	    match(fromsec, PATTERNS(DATA_SECTIONS)) &&
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 464f6c9d9ff0..77389fbfd9ea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -329,6 +329,8 @@ static void init_insn_state(struct objtool_file *file, struct insn_state *state,
 
 	if (opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
+	if (sec)
+		state->cpu_preserved = sec->cpu_preserved;
 }
 
 static struct cfi_state *cfi_alloc(void)
@@ -419,6 +421,14 @@ static int decode_instructions(struct objtool_file *file)
 		u8 prev_len = 0;
 		u8 idx = 0;
 
+		if (!strncmp(sec->name, ".text.cpu_preserved", 19) ||
+		    !strncmp(sec->name, ".cpu_preserved.text", 19) ||
+		    !strncmp(sec->name, ".data.cpu_preserved", 19) ||
+		    !strncmp(sec->name, ".cpu_preserved.data", 19) ||
+		    !strncmp(sec->name, ".rodata.cpu_preserved", 21) ||
+		    !strncmp(sec->name, ".bss..data.cpu_preserved", 24))
+			sec->cpu_preserved = true;
+
 		if (!is_text_sec(sec))
 			continue;
 
@@ -3511,6 +3521,17 @@ static int validate_call(struct objtool_file *file,
 			 struct instruction *insn,
 			 struct insn_state *state)
 {
+	if (state->cpu_preserved) {
+		struct symbol *dest = insn_call_dest(insn);
+
+		if (dest && (dest->sec->idx != SHN_UNDEF || opts.link) &&
+		    !dest->sec->cpu_preserved) {
+			WARN_INSN(insn, "call to %s() leaves .text.cpu_preserved section",
+				  call_dest_name(insn));
+			return 1;
+		}
+	}
+
 	if (state->noinstr && state->instr <= 0 &&
 	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
 		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(insn));
@@ -4164,7 +4185,13 @@ static int validate_retpoline(struct objtool_file *file)
 		if (insn->retpoline_safe)
 			continue;
 
-		if (insn->sec->init)
+		/*
+		 * Preserved CPU text (.text.cpu_preserved) executes across
+		 * kexec when the outgoing kernel's retpoline/rethunk targets
+		 * are no longer mapped.
+		 */
+		if (insn->sec->init ||
+		    !strcmp(insn->sec->name, ".text.cpu_preserved"))
 			continue;
 
 		if (insn->type == INSN_RETURN) {
@@ -4440,6 +4467,12 @@ static int validate_noinstr_sections(struct objtool_file *file)
 		warnings += validate_unwind_hints(file, sec);
 	}
 
+	sec = find_section_by_name(file->elf, ".text.cpu_preserved");
+	if (sec) {
+		warnings += validate_section(file, sec);
+		warnings += validate_unwind_hints(file, sec);
+	}
+
 	return warnings;
 }
 
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 063f5985fecd..18318f2faf11 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -16,6 +16,7 @@ struct insn_state {
 	bool uaccess;
 	bool df;
 	bool noinstr;
+	bool cpu_preserved;
 	s8 instr;
 };
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index a82517a76a0f..bac9e5f4921f 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -58,7 +58,7 @@ struct section {
 	Elf_Data *data;
 	const char *name;
 	int idx;
-	bool _changed, text, rodata, noinstr, init, truncate;
+	bool _changed, text, rodata, noinstr, init, cpu_preserved, truncate;
 	struct reloc *relocs;
 	unsigned long nr_alloc_relocs;
 	struct section *twin;
-- 
2.55.0.1082.g2b9226bbc0-goog


