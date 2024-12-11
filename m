Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C099CE7717F
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 02:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IfO9/oCHZjCjo42v2Mc1LVPYN0UeZN4vZ7FBVsa2sq0=; b=W6+6vfnG8V01SVWohOKawk9mdI
	R+zDvZjv3w3PAmCcc644ngKnO8jRl3jDfikQTz3U89pRlO+h2aQEOM4Kj2pVoytStxB1RK7Q9rIXg
	Eg6sTKtp7QXkSLsflQR7qNOBoI/tQh8jQPPr/cVpDHKcLfWt1cJkK3Gf4LlBhL2kNvW8MjGoR2ck8
	hgImGBHHgadlmPLCvtMLW6+9D+KWP7yFKaCe5S02KxBnXu0VXHQVs4+Wv2voYU4DtLxdkyIoeCheN
	oAf0ox1AVQDoO2ScoARF3zu6mWAeWu9XWlPzRmVLfu5FMsFi7pNIzGn4vmbLfdYTp7/DXxOKssNZ/
	jBZXunLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLCx6-0000000DZMX-2BjM;
	Wed, 11 Dec 2024 02:59:52 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLCw5-0000000DZ9A-1vgb
	for kexec@lists.infradead.org;
	Wed, 11 Dec 2024 02:58:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A538816F2;
	Tue, 10 Dec 2024 18:59:16 -0800 (PST)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82AE53F720;
	Tue, 10 Dec 2024 18:58:48 -0800 (PST)
From: Jeremy Linton <jeremy.linton@arm.com>
To: kexec@lists.infradead.org
Cc: piliu@redhat.com,
	horms@kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] Correct string specifiers
Date: Tue, 10 Dec 2024 20:58:46 -0600
Message-ID: <20241211025846.243026-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_185849_583671_41C58A16 
X-CRM114-Status: GOOD (  10.72  )
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

Recent GCC's on fedora complain about the use of
%lld for uint64_t because its unsigned. Convert a number
of these and similar calls.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kexec/arch/arm64/crashdump-arm64.c | 4 ++--
 kexec/arch/i386/crashdump-x86.c    | 2 +-
 kexec/arch/i386/kexec-x86-common.c | 2 +-
 kexec/arch/i386/x86-linux-setup.c  | 2 +-
 util_lib/elf_info.c                | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index f23b2bf..73cb611 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -1,6 +1,6 @@
 /*
  * ARM64 crashdump.
- *     partly derived from arm implementation
+ *     partly derived from                                    arm implementation
  *
  * Copyright (c) 2014-2017 Linaro Limited
  * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
@@ -71,7 +71,7 @@ static int iomem_range_callback(void *UNUSED(data), int UNUSED(nr),
 		 */
 		for (i = 0; i < usablemem_rgns.max_size; i++) {
 			if (usablemem_rgns.ranges[i].start == base) {
-				fprintf(stderr, "Warning, the range already exists in usablemem_rgns, base=%lx, length=%lx\n",
+				fprintf(stderr, "Warning, the range already exists in usablemem_rgns, base=%llx, length=%llx\n",
 						base, length);
 				return 0;
 			}
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 800ae2c..770e3f1 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -784,7 +784,7 @@ static void cmdline_add_efi(char *cmdline)
 	if (!acpi_rsdp)
 		return;
 
-	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%llx", acpi_rsdp);
+	sprintf(acpi_rsdp_buf, " acpi_rsdp=0x%lux", acpi_rsdp);
 	if (strlen(cmdline) + strlen(acpi_rsdp_buf) > (COMMAND_LINE_SIZE - 1))
 		die("Command line overflow\n");
 
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 67da043..acacb45 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -422,7 +422,7 @@ static uint64_t efi_get_acpi_rsdp(void) {
 		/* ACPI20= always goes before ACPI= */
 		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
 			s = strchr(line, '=') + 1;
-			sscanf(s, "0x%llx", &acpi_rsdp);
+			sscanf(s, "0x%lux", &acpi_rsdp);
 			break;
 		}
 	}
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 1f96372..70656e3 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -760,7 +760,7 @@ static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
 				e820[i].type = E820_RESERVED;
 				break;
 		}
-		dbgprintf("%016llx-%016llx (%d)\n",
+		dbgprintf("%016lux-%016lux (%d)\n",
 				e820[i].addr,
 				e820[i].addr + e820[i].size - 1,
 				e820[i].type);
diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index 8f84f52..5cf438c 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -890,7 +890,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 					handler(out_buf, len);
 				fprintf(stderr, "Cycle when parsing dmesg detected.\n");
 				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%llx, idx = 0x%x\n",
+				fprintf(stderr, "log_buf = 0x%lux, idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(68);
 			}
@@ -904,7 +904,7 @@ static void dump_dmesg_structured(int fd, void (*handler)(char*, unsigned int))
 					handler(out_buf, len);
 				fprintf(stderr, "Index outside log_buf detected.\n");
 				fprintf(stderr, "The prink log_buf is most likely corrupted.\n");
-				fprintf(stderr, "log_buf = 0x%llx, idx = 0x%x\n",
+				fprintf(stderr, "log_buf = 0x%lux, idx = 0x%x\n",
 					log_buf, current_idx);
 				exit(69);
 			}
-- 
2.47.0


