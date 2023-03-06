Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B5EC678DB
	for <kexec@archiver.kernel.org>; Mon,  6 Mar 2023 03:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vx1OiSvKe7KWIH69SDVdKzP1pteJ1vXot9/izV9Gwsk=; b=IzBsf5sY7WfLOY
	9woNoCNTep0Ya5NOSQD3ctvIn7nKP2Begyr9lwSDrzUeCg+tvxH6QFipIwfzMQMdqjlzpxUKs6YVq
	AgdVL05A18/blVqBhszTv0PAeJ4WOyXBxd+kKH9U0g0E0jaFmM0PPvh09NB+zOHS9aeg5TCFv89FJ
	z0Ug2tKjQK5vvC+U1PQn0ECsYSuotc1FrPdMfmNwYr9jJYLtBMzktJ9M/nRZpYqJntDZVYrDdgqUT
	VaZkIbP9Ios1mMrURpl2FDZwNJ+dyCCNyK+Vmu/oCsrMkg3PgZzi6Be0tCUDA22PYA7XigT0OMHjt
	iIDBT2NYHWyGnaj8jDUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18t-00B2g6-P4; Mon, 06 Mar 2023 03:04:03 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ18P-00B2Po-B7; Mon, 06 Mar 2023 03:03:35 +0000
Received: by mail-pl1-x62b.google.com with SMTP id h8so8740325plf.10;
        Sun, 05 Mar 2023 19:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678071811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmnZaXWwPw8Q5BGOyo7ZMPXWTzHCgCcEq5Rf19W6jjY=;
        b=b4ZttBFxSHV0UTeRy+Johv5uDFJa3j29vQ26lYcRbcoDE7CbND18CjCNP3MqhykBON
         rj2n7mnouEu7xsiSVV+YH7GdM+6a2DXFLKSILTomCAbOoX47T4VCurwDIaRolWT7uCg7
         pVUyiWCz01a807z6k5LwUh2Y9dnXSZg9N797Z90QK3BfIVweyxvrubBI1ThOM5nYOf1q
         iK5Gs8Jnw8dNxwL/obeDe8nnQD4xnkO40Vg/gv7tLhSmjyTbXUy4yaKL+erCzyo/AXT4
         owdhW/cD/0GQ8H65DF4ZuKRj07wfQNIEIndWbrL3UolVgrkyg7gEwwOO4y91pXLgnEgN
         J+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678071811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmnZaXWwPw8Q5BGOyo7ZMPXWTzHCgCcEq5Rf19W6jjY=;
        b=HAgXrQEMU3T2TvEOA9DEgu+M80hyqaVipLkYze76jnOhO1AX8hwTaOqla4Y/r+Vymx
         b+QG8xw3FLIpW1gHaeHDLGWB7i9GoeysZb573AgK7ZwY+QVij9wdrsGmJbVaW08JjAd7
         xmj3nERb9wtoYTBYlDnS+PdLB21S0/DwdYmRkgtSe1Mn2mHg9bYeSY9liwPQiqDg/EPu
         iMNuZza4+8TXMaFRp82UWhlnflK5ci3WBFcVcM+8kpaX1FfzRWLb7UfzpEPGYxGxklsz
         SilXMFQfecOfSS5+QGMcMMlQj7agcrHhkvQpgK/IpRHsdMY0bF9spF6ZgjyGcIRu/A7u
         Of6Q==
X-Gm-Message-State: AO0yUKUVwPv2l27pcHG5All2zpKNG6sho+Vb9QOGn8f7v3OE/RSGxA51
	4L0vTvPRlVVejkodnM5ES8cjumrhYw==
X-Google-Smtp-Source: AK7set+bL2b6hTuCcB0SX+LFxFf2ysaT8dLQzxUAkbXYIfAN7kezIJ6869ELdfcU/Vx/Hkl1HCI8Rw==
X-Received: by 2002:a17:902:c20d:b0:19e:839f:ef5a with SMTP id 13-20020a170902c20d00b0019e839fef5amr9306700pll.60.1678071811685;
        Sun, 05 Mar 2023 19:03:31 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy16-20020a17090342d000b0019719f752c5sm5410439plb.59.2023.03.05.19.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 19:03:31 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	kexec@lists.infradead.org
Subject: [PATCH 1/6] arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
Date: Mon,  6 Mar 2023 11:03:00 +0800
Message-Id: <20230306030305.15595-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_190333_798281_47132CA8 
X-CRM114-Status: GOOD (  12.52  )
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

With the emergence of zboot image format, kexec file load needs to
support multiple formats. In order to better distinguish the file's
purpose, renaming kexec_image.c to kexec_raw_image.c.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: kexec@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/kexec.h                         | 2 +-
 arch/arm64/kernel/Makefile                             | 2 +-
 arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} | 2 +-
 arch/arm64/kernel/machine_kexec_file.c                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 559bfae26715..3f3d5a6830b7 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -125,7 +125,7 @@ struct kimage_arch {
 };
 
 #ifdef CONFIG_KEXEC_FILE
-extern const struct kexec_file_ops kexec_image_ops;
+extern const struct kexec_file_ops kexec_raw_ops;
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ceba6792f5b3..99b52710606a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 obj-$(CONFIG_ELF_CORE)			+= elfcore.o
 obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
+obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_raw_image.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_raw_image.c
similarity index 98%
rename from arch/arm64/kernel/kexec_image.c
rename to arch/arm64/kernel/kexec_raw_image.c
index 5ed6a585f21f..2b3412b3ad2c 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_raw_image.c
@@ -129,7 +129,7 @@ static void *image_load(struct kimage *image,
 	return NULL;
 }
 
-const struct kexec_file_ops kexec_image_ops = {
+const struct kexec_file_ops kexec_raw_ops = {
 	.probe = image_probe,
 	.load = image_load,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index a11a6e14ba89..0738020507d1 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -23,7 +23,7 @@
 #include <linux/vmalloc.h>
 
 const struct kexec_file_ops * const kexec_file_loaders[] = {
-	&kexec_image_ops,
+	&kexec_raw_ops,
 	NULL
 };
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
