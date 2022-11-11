Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA39C433FE
	for <kexec@archiver.kernel.org>; Fri, 11 Nov 2022 01:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XrPOYfk02dI7VQtCHQPLe28JDBz3WkBCoWorp8T6VLU=; b=v6GohhGXhuqqeH
	34cLFDs8htv9C4k5Pr/Lto0rxfDhOT19umxx9q6S9MC2cY0DOgndomgW9ccZFIumTh7reUekELdFI
	cq7n9IQm7OM7Uvle28KHRT23Op4YhzCMVJS1iMlb3w3h2QgtwrQ64U3VLuEhSwLE2nttKGaONhcgz
	ThaprFpXf3tVaQQdEnAOj0nUZjkuROIIOTvemha0MVNe6DIzlf10bP5dcJh35towaQ45a4yP5FPLZ
	DvP9p39T53a4iag4+YLwx/4HRrXWfN3QkAQq6iPbN2Bql2LRiNOcTyM1bbsYUgwgzZCBQltB5XkWK
	v/L0UOWZdmytWXbqLcAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otIxe-00Bo6d-VN; Fri, 11 Nov 2022 01:36:02 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otIxb-00Bo5L-7q
	for kexec@lists.infradead.org; Fri, 11 Nov 2022 01:36:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0D851B823D8;
	Fri, 11 Nov 2022 01:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2127BC433D6;
	Fri, 11 Nov 2022 01:35:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Nob2uOYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1668130553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4rp5D2BB0lIb8zOROgUIXIM5QS26CXMfzvc7/8uxz3A=;
	b=Nob2uOYRaYlnBHuitPG5AZKD++mElZmN2NcUxd7ZtnlT1ZABEfJDpSFTZ3dEmW6iTYpgNu
	jL9j0t52VaB2AN1jClGoCF+BCt1y9GYRQKjZXSci8WLHd6t7evd2lBljbFWsE0uNE8rWU9
	DCoAqS4bXouG2d/UgZ+3l8TNJGdpZ4M=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d0321a36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Nov 2022 01:35:53 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@verge.net.au>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 RESEND kexec-tools] m68k: pass rng seed via BI_RNG_SEED
Date: Fri, 11 Nov 2022 02:35:33 +0100
Message-Id: <20221111013532.494463-1-Jason@zx2c4.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_173559_936099_2BD140A7 
X-CRM114-Status: GOOD (  15.21  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

In order to pass fresh entropy to kexec'd kernels, use BI_RNG_SEED
for passing a seed, with the same semantics that kexec-tools currently
uses for i386's setup_data.

Link: https://git.kernel.org/torvalds/c/dc63a086daee92c63e3
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Seems like this was forgotten about, so resending.

 kexec/arch/m68k/bootinfo.c       | 23 +++++++++++++++++++++++
 kexec/arch/m68k/bootinfo.h       |  5 +++++
 kexec/arch/m68k/kexec-elf-m68k.c |  1 +
 3 files changed, 29 insertions(+)

diff --git a/kexec/arch/m68k/bootinfo.c b/kexec/arch/m68k/bootinfo.c
index 18bf226..086a34b 100644
--- a/kexec/arch/m68k/bootinfo.c
+++ b/kexec/arch/m68k/bootinfo.c
@@ -2,6 +2,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/random.h>
 
 #include "../../kexec.h"
 
@@ -152,6 +153,11 @@ void bootinfo_print(void)
 			printf("BI_COMMAND_LINE: %s\n", bi->string);
 			break;
 
+		case BI_RNG_SEED:
+			/* These are secret, so never print them to the console */
+			printf("BI_RNG_SEED: 0x%08x bytes\n", be16_to_cpu(bi->rng_seed.len));
+			break;
+
 		default:
 			printf("BI tag 0x%04x size %u\n", tag, size);
 			break;
@@ -212,6 +218,23 @@ void bootinfo_set_ramdisk(unsigned long ramdisk_addr,
 	bi->mem_info.size = ramdisk_size;
 }
 
+void bootinfo_add_rng_seed(void)
+{
+	enum { RNG_SEED_LEN = 32 };
+	struct bi_rec *bi;
+
+	/* Remove existing rng seed records */
+	bi_remove(BI_RNG_SEED);
+
+	/* Add new rng seed record */
+	bi = bi_add(BI_RNG_SEED, sizeof(bi->rng_seed) + RNG_SEED_LEN);
+	if (getrandom(bi->rng_seed.data, RNG_SEED_LEN, GRND_NONBLOCK) != RNG_SEED_LEN) {
+		bi_remove(BI_RNG_SEED);
+		return;
+	}
+	bi->rng_seed.len = cpu_to_be16(RNG_SEED_LEN);
+}
+
 
     /*
      * Check the bootinfo version in the kernel image
diff --git a/kexec/arch/m68k/bootinfo.h b/kexec/arch/m68k/bootinfo.h
index b6f453d..90f75ad 100644
--- a/kexec/arch/m68k/bootinfo.h
+++ b/kexec/arch/m68k/bootinfo.h
@@ -20,6 +20,10 @@ struct bi_rec {
 			__be32 size;
 		} mem_info;
 		char string[0];
+		struct {
+			__be16 len;
+			u8 data[0];
+		} rng_seed;
 	};
 };
 
@@ -39,5 +43,6 @@ extern int bootinfo_get_memory_ranges(struct memory_range **range);
 extern void bootinfo_set_cmdline(const char *cmdline);
 extern void bootinfo_set_ramdisk(unsigned long ramdisk_addr,
 				 unsigned long ramdisk_size);
+extern void bootinfo_add_rng_seed(void);
 extern void bootinfo_check_bootversion(const struct kexec_info *info);
 extern void add_bootinfo(struct kexec_info *info, unsigned long addr);
diff --git a/kexec/arch/m68k/kexec-elf-m68k.c b/kexec/arch/m68k/kexec-elf-m68k.c
index 8d00eb9..a2bf7ee 100644
--- a/kexec/arch/m68k/kexec-elf-m68k.c
+++ b/kexec/arch/m68k/kexec-elf-m68k.c
@@ -162,6 +162,7 @@ int elf_m68k_load(int argc, char **argv, const char *buf, off_t len,
 	/* Update and add bootinfo */
 	bootinfo_set_cmdline(cmdline);
 	bootinfo_set_ramdisk(ramdisk_addr, ramdisk_size);
+	bootinfo_add_rng_seed();
 	if (kexec_debug)
 		bootinfo_print();
 	add_bootinfo(info, bootinfo_addr);
-- 
2.38.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
