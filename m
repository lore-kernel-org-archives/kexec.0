Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471DCC87FCB
	for <kexec@archiver.kernel.org>; Tue,  5 Aug 2025 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XYQC0tIQmZ2K81MPMQ9fLTZs4TeD4tJc4sFcL0sR2FY=; b=5EKKzxmMKHwmgCtwoK8GF6ijP8
	n53QeqpUMWZ2M6rxzxTTUnIuNyIuZI1HLv8KMaR68AiXnipXuxLdFQgJH7Z5kQlg5jDMvC1jYTC+m
	VyyQRn9OszMyFMq6qtcxc7CIjZ3eZWXISD2veu2Tfvz3C91hBCBfq9bEP4+1FNh2gZMtGJ+wu+SGM
	uAktHKQrOPh8IMPv1vJKkf6CXM6QOXPyz11BeWRZJISIHdOvcx2fVBCdgxneodFSQ7JR2DipD588B
	lx5LKviLGB5Unk6ellhd7AICvdrVeDvgMKMAzzqSjtnAblF2fGPC//B1WABYW5H3HfXTXfLWDW+q7
	GqamhY8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujH5F-0000000CktS-3Ayu;
	Tue, 05 Aug 2025 12:48:01 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujH52-0000000CkqI-2QtT
	for kexec@lists.infradead.org;
	Tue, 05 Aug 2025 12:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754398063; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NeRynp4nLLvN1+b5I4hPHAhf6noIIcXaIDeE95O8JWQ2ECeNO9/OL7Uqi/d87PDYjETsjWHVv6vxBT29DPPvKK8JEFJmNvND+tq5R+MdA5HYbwy1XD57p6UQqKypvdXyK++Jk0IfQT9RrVBPFryK6b0i13H/nRr1ECsdvij16nU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754398063; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XYQC0tIQmZ2K81MPMQ9fLTZs4TeD4tJc4sFcL0sR2FY=; 
	b=IjXw/tLBtvTcKAkqgeBaDFtUN7HmqRSkYhMxWZWbob2z2m5EGD012zKOcSpjwuKVTqnlOaC9tpg9vxiMh1BtlC9iw/KO3WBsZ1etbTJ1BCtVO9gmFqro2oOfAPIOv1f7wYvFG0fz5+T0NccbbOpA5SvmQyKAVzO+DTG5qoVSm+g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754398063;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=XYQC0tIQmZ2K81MPMQ9fLTZs4TeD4tJc4sFcL0sR2FY=;
	b=SUh+gMH0V79oj+YElxdfaRongZcxV+6/tMxkCYnZosutenfnhsfVNCRLttKG8S9H
	l/5oGntGvydB/h8RLXkCL9+VsBrf+tf7WZbhQvi9t0K0Y8BD2vYNX8HIUJ4/9iImwCt
	k7KclC3lyMRZFkcYifY+f8EwwvlCPnrdRqSyBS1I=
Received: by mx.zohomail.com with SMTPS id 1754398060725861.2997188922598;
	Tue, 5 Aug 2025 05:47:40 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Simon Horman <horms@kernel.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	kexec@lists.infradead.org
Subject: [PATCH] fix printf string specifiers, otherwise kexec doesn't work on my laptop
Date: Tue,  5 Aug 2025 12:25:28 +0000
Message-ID: <20250805124722.11193-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227b098aae1d5de5c62d9eea37500006ddca112eadb0920e4f9f82c7a1da2bb5428e074ae7b2fe5a3:zu08011227589ede468c63cf235e22b556000031425bb630bdfdd6101709935f667f8c0424f12c63fb32e652:rf0801122cace98b88fabe34c42204302900004cdebc361c07a1a333a67cd900be389900e34655ca79cddfe2292c1e1ad6:ZohoMail
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_054748_663122_0D75DD25 
X-CRM114-Status: GOOD (  20.48  )
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

TL;DR: this patch fixes regression, introduced by aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4 .
This patch should be backported to all distributions, which packaged v2.0.31, otherwise
kexec doesn't work at all at my laptop with pretty common setup with v2.0.31.
v2.0.31 is broken without this patch.

Recently I found a bug: kexec doesn't work at my laptop.
Here is my setup:
* Laptop Dell Precision 7780
* CPU Intel Raptor Lake-S
* i915 GPU
* x86_64
* UEFI
* Linux d632ab86aff2cef21f794e337a8e7f2320ac3973 (this is current mainline)
* linux-firmware 37b63dc35d98e1fc5c2be95ab7468bf470c20dfd (this is current main)
* I do kexec from this kernel to the same kernel
* Kernel is UEFI PE image
* Secure boot is disabled
* Kernel config is minimized Debian config
* I use command 'kexec --debug --kexec-syscall -l /disk/vmlinuz --initrd=/disk/initramfs.cpio.gz --append="..."', then I execute 'kexec --debug -e'

When I execute "kexec --debug -e", nothing happens.

Bug reproduces on kexec-tools daa29443819d3045338792b5ba950ed90e79d7a5 (i. e. current main).

Also it reproduces on kexec-tools aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4 , but
doesn't reproduce on kexec-tools 6aecc32c6db895b1c0b1f522d82c8810ece65542 .

I. e. it is regression, introduced by aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4 .

Okay, why the bug happens? I suspect this is because aecc554e7b introduced "%lux"
string specifiers, which are totally wrong. The author meant "print in hexademical"
here, but this specifier prints number in decimal, followed by literal "x". Oops.
And this seems to break kexec.

Okay, how to fix this? Well, this is not easy. In 07821da7cf and d2f4297166 Andy Shevchenko
observed compilation warnings, when %lx is used with uint64_t, so he replaced %lx with %llx.

Then in aecc554e7b Jeremy Linton observed warnings with %llx and replaced it with %lux.
(Yes, C is nightmare.)

So, uint64_t is sometimes defined as long unsigned, and thus needs %lx, and sometimes as
long long unsigned and thus needs %llx.

How to fix this once and for all?

I see three ways.

1. uint64_t a; printf ("%llx", (unsigned long long)a);
2. uint64_t a; printf ("%" PRIx64, a);
3. uint64_t a; printf ("%w64x", a);

%w64x is most clean and beautiful of all, but it causes compilation warnings on clang. (Facepalm.)
PRIx64 is ugly, and other people will probably fail to understand it.
So I chose explicit conversion to unsigned long long.

Also this patch does these things:
* Remove extra whitespace in kexec/arch/arm64/crashdump-arm64.c introduced in aecc554e7b
* Remove duplicate <stdio.h> in kexec/arch/i386/kexec-x86-common.c
* Fix "prink" typo in util_lib/elf_info.c
* Fix %lux in kexec/kexec-elf-exec.c , introduced long before aecc554e7b

I tested this patch on my laptop.

Fixes: aecc554e7ba8bd449dceaf3eeecacc09b9b77fc4
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 kexec/arch/arm64/crashdump-arm64.c |  2 +-
 kexec/arch/i386/crashdump-x86.c    |  2 +-
 kexec/arch/i386/kexec-x86-common.c |  5 ++---
 kexec/arch/i386/x86-linux-setup.c  |  6 +++---
 kexec/kexec-elf-exec.c             |  2 +-
 util_lib/elf_info.c                | 12 ++++++------
 6 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 73cb611..050dd72 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -1,6 +1,6 @@
 /*
  * ARM64 crashdump.
- *     partly derived from                                    arm implementation
+ *     partly derived from arm implementation
  *
  * Copyright (c) 2014-2017 Linaro Limited
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 770e3f1..08e03fe 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -784,7 +784,7 @@ static void cmdline_add_efi(char *cmdline)
 	if (!acpi_rsdp)
 		return;
 
-	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%lux", acpi_rsdp);
+	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%llx", (unsigned long long)acpi_rsdp);
 	if (strlen(cmdline) + strlen(acpi_rsdp_buf) > (COMMAND_LINE_SIZE - 1))
 		die("Command line overflow\n");
 
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index acacb45..395f88b 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -29,7 +29,6 @@
 #include <string.h>
 #include <limits.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
@@ -412,7 +411,7 @@ static uint64_t bootparam_get_acpi_rsdp(void) {
 static uint64_t efi_get_acpi_rsdp(void) {
 	FILE *fp;
 	char line[MAX_LINE], *s;
-	uint64_t acpi_rsdp = 0;
+	unsigned long long acpi_rsdp = 0;
 
 	fp = fopen("/sys/firmware/efi/systab", "r");
 	if (!fp)
@@ -422,7 +421,7 @@ static uint64_t efi_get_acpi_rsdp(void) {
 		/* ACPI20= always goes before ACPI= */
 		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
 			s = strchr(line, '=') + 1;
-			sscanf(s, "0x%lux", &acpi_rsdp);
+			sscanf(s, "0x%llx", &acpi_rsdp);
 			break;
 		}
 	}
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 70656e3..0932087 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -760,9 +760,9 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 				e820[i].type = E820_RESERVED;
 				break;
 		}
-		dbgprintf("%016lux-%016lux (%d)\n",
-				e820[i].addr,
-				e820[i].addr + e820[i].size - 1,
+		dbgprintf("%016llx-%016llx (%u)\n",
+				(unsigned long long)e820[i].addr,
+				(unsigned long long)(e820[i].addr + e820[i].size - 1),
 				e820[i].type);
 
 		if (range[i].type != RANGE_RAM)
diff --git a/kexec/kexec-elf-exec.c b/kexec/kexec-elf-exec.c
index b337642..644af8a 100644
--- a/kexec/kexec-elf-exec.c
+++ b/kexec/kexec-elf-exec.c
@@ -167,7 +167,7 @@ int elf_exec_load_relocatable(struct mem_ehdr *ehdr, struct kexec_info *info,
 	int result;
 
 	if (reloc_min > reloc_max) {
-		fprintf(stderr, "Bad relocation range, start=%lux > end=%lux.\n", reloc_min, reloc_max);
+		fprintf(stderr, "Bad relocation range, start=%lx > end=%lx.\n", reloc_min, reloc_max);
 		result = -1;
 		goto out;
 	}
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 5cf438c..1662612 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -889,9 +889,9 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 				if (len && handler)
 					handler(out_buf, len);
 				fprintf(stderr, "Cycle when parsing dmesg detected.\n");
-				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%lux, idx = 0x%x\n",
-					log_buf, current_idx);
+				fprintf(stderr, "The printk log_buf is most likely corrupted.\n");
+				fprintf(stderr, "log_buf = 0x%llx, idx = 0x%x\n",
+					(unsigned long long)log_buf, current_idx);
 				exit(68);
 			}
 			current_idx = 0;
@@ -903,9 +903,9 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 				if (len && handler)
 					handler(out_buf, len);
 				fprintf(stderr, "Index outside log_buf detected.\n");
-				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%lux, idx = 0x%x\n",
-					log_buf, current_idx);
+				fprintf(stderr, "The printk log_buf is most likely corrupted.\n");
+				fprintf(stderr, "log_buf = 0x%llx, idx = 0x%x\n",
+					(unsigned long long)log_buf, current_idx);
 				exit(69);
 			}
 		}
-- 
2.47.2


