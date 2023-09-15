Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D3AEEAA42
	for <kexec@archiver.kernel.org>; Fri, 15 Sep 2023 03:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8+2UCMAcT0HS3KyUYoc9Lqi7b07S1wI4YIAhW2f9+3M=; b=yBm6pNCUJ2D97u
	UNdanlBlCupG/eYzzMks9/KS4RJ+0yeSOFQRin6zzTiOj8JwPWp2V4jip5+pNbP9SuRBYvhtbvV1E
	9TccTVHIfB0+U3RC+HzkD2T8Ri9mCryW9EDiiFpJ5vyl1IZ3DPtPEqAk1v95PXMXivk7twfi+ojd9
	OXgMqK9D18UjSrzhJ863I72e9MHM8aqrbyzu5d7mvGRksxgQaH2nDGd0gnOKKaP/eocYx6DTFKCHw
	AlDGZToAA7KB8DcEBbBHk49fPplL5BdsFB58O7TT1iwSYGvia//nSfFVHiuJAl/jCv1KBm8+yOpBp
	nh4vc/UzUF5L1GrAPFqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzwv-009hlK-0V;
	Fri, 15 Sep 2023 03:56:57 +0000
Received: from bg2.exmail.qq.com ([114.132.197.227])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgzws-009hkq-11
	for kexec@lists.infradead.org;
	Fri, 15 Sep 2023 03:56:56 +0000
X-QQ-mid: bizesmtp62t1694750193t16lsnh6
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Sep 2023 11:56:31 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: xqqSCOrcRQE+IzSi6j0LrfoxTGJYNsCRNA2ob8q67NBuXe8/sRCuJ5ZtLg3Ny
	/oOXlMRdZuRMqOK9Xmk003BTdUbXiWk0iB2LH+khbWevEptr48OYguYFBsgBCjA9TLwtWh6
	WuvklB4jst1OlnTWAeQ1C2pEdhgoh0hN2g0UbcI5OCFuscJsfV1FjG/fHYq5aA0nKM0cTxz
	zd7KGeKONmJ0DH8hMxHELoXaYL+JPJTRhUpijcM6icEqpIxaZ/63vsVvmgkKtE/ZeIBEPHR
	GMmtuV/NauiW/4edHbisOTjheSu5ES7Z5yOhyZIslC3rp0J63qgF+LtJXAEnVsS7P9qzy9N
	zWpysJe0bWH/khT/bvpG97q8/MyG1Zy9MO23g8AINhy4pduGmXqXzE97yYO+GssE3eZgguI
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13553461837954552895
From: Song Shuai <songshuaishuai@tinylab.org>
To: lizhengyu3@huawei.com,
	liaochang1@huawei.com,
	xianting.tian@linux.alibaba.com,
	guoren@kernel.org,
	horms@kernel.org,
	horms@verge.net.au,
	huanyi.xj@alibaba-inc.com,
	mick@ics.forth.gr,
	yixun.lan@gmail.com
Cc: kexec@lists.infradead.org,
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 5/7] RISC-V: Enable kexe_file_load
Date: Fri, 15 Sep 2023 11:50:11 +0800
Message-Id: <20230915035013.1582679-6-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
References: <20230915035013.1582679-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_205654_691997_41B40650 
X-CRM114-Status: GOOD (  17.06  )
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

From: Li Zhengyu <lizhengyu3@huawei.com>

Create prepare_kexec_file_options() function to prepare the options
to kexec_file_load syscall, and it would be used in elf_riscv_load()
or the future image_riscv_load().

The patch comes from the RISC-V Linux kernel_file_load support[1],
So its author should be Li Zhengyu.

[1]: https://lore.kernel.org/all/20220408100914.150110-1-lizhengyu3@huawei.com/

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kexec/arch/riscv/kexec-elf-riscv.c |  5 ++--
 kexec/arch/riscv/kexec-riscv.c     | 41 ++++++++++++++++++++++++++++++
 kexec/arch/riscv/kexec-riscv.h     |  1 +
 kexec/kexec-syscall.h              |  3 +++
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/riscv/kexec-elf-riscv.c b/kexec/arch/riscv/kexec-elf-riscv.c
index f3c011c..2b9f66d 100644
--- a/kexec/arch/riscv/kexec-elf-riscv.c
+++ b/kexec/arch/riscv/kexec-elf-riscv.c
@@ -112,6 +112,7 @@ void elf_riscv_usage(void)
 {
 }
 
+
 int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
 		   struct kexec_info *info)
 {
@@ -127,9 +128,7 @@ int elf_riscv_load(int argc, char **argv, const char *buf, off_t len,
 	int ret = 0;
 
 	if (info->file_mode) {
-		fprintf(stderr, "kexec_file not supported on this "
-				"architecture\n");
-		return -EINVAL;
+		return prepare_kexec_file_options(info);
 	}
 
 	/* Parse the ELF file */
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index 00ae869..4500aa9 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -16,6 +16,14 @@
 #include <libfdt.h>		/* For DeviceTree handling */
 #include "kexec-riscv.h"
 #include "iomem.h"
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#ifndef _O_BINARY
+#define _O_BINARY 0
+#endif
+
+
 
 const struct arch_map_entry arches[] = {
 	{ "riscv32", KEXEC_ARCH_RISCV },
@@ -141,6 +149,39 @@ void arch_usage(void)
 	printf(riscv_opts_usage);
 }
 
+int prepare_kexec_file_options(struct kexec_info *info)
+{
+	int fd;
+	ssize_t result;
+	struct stat stats;
+
+	if (arch_options.cmdline) {
+		info->command_line = (char *)arch_options.cmdline;
+		info->command_line_len = strlen(info->command_line) + 1;
+	}
+
+	if (!arch_options.initrd_path) {
+		info->initrd_fd = -1;
+		return 0;
+	}
+
+	fd = open(arch_options.initrd_path, O_RDONLY | _O_BINARY);
+	if (fd < 0) {
+		fprintf(stderr, "Cannot open `%s': %s\n", arch_options.initrd_path,
+				strerror(errno));
+		return -EINVAL;
+	}
+	result = fstat(fd, &stats);
+	if (result < 0) {
+		close(fd);
+		fprintf(stderr, "Cannot stat: %s: %s\n", arch_options.initrd_path,
+				strerror(errno));
+		return -EINVAL;
+	}
+	info->initrd_fd = fd;
+	return 0;
+}
+
 int arch_process_options(int argc, char **argv)
 {
 	static const struct option options[] = {
diff --git a/kexec/arch/riscv/kexec-riscv.h b/kexec/arch/riscv/kexec-riscv.h
index c4323a6..f136c7e 100644
--- a/kexec/arch/riscv/kexec-riscv.h
+++ b/kexec/arch/riscv/kexec-riscv.h
@@ -23,6 +23,7 @@ extern struct memory_range elfcorehdr_mem;
 int load_elfcorehdr(struct kexec_info *info);
 
 /* kexec-riscv.c */
+int prepare_kexec_file_options(struct kexec_info *info);
 int load_extra_segments(struct kexec_info *info, uint64_t kernel_base,
 			uint64_t kernel_size, uint64_t max_addr);
 
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 4cdae84..2310b98 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -80,6 +80,9 @@
 #ifdef __hppa__
 #define __NR_kexec_file_load	355
 #endif
+#if defined(__riscv__) || defined(__riscv)
+#define __NR_kexec_file_load	294
+#endif
 
 #ifndef __NR_kexec_file_load
 /* system call not available for the arch */
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
