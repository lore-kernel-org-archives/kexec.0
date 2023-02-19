Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E185C05027
	for <kexec@archiver.kernel.org>; Sun, 19 Feb 2023 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uefogfJUbyz07UT6f23TU6mzdH/9jOyCHXQ/5+ZNiuE=; b=ATTGxHM8p6yvNo
	1UUyr1wVmChUjZtFdKLhnjXd80fR4Ek+1cJmkEK9jGRPckLY/jBaCDgrV/O9q7Vt2y3tOBW+wrHYz
	6GwtiCCj91btugJdv4n/slGUuGB+szE2t/mkFpc3gI446K++4oA6ZfZ0ZeMm1pWbMf60V73dzLEKx
	VRvQT/2JGkMtyGb1gJXh6DfHs11JZICFWA/GNk5+Q8DZCbNd8oTo47ISiPcR+JYRPshisBB31sB6Z
	L5b62598YLVD54QYmWLI40Vy7tsLjuxDBMVRaJiTMBokNdBPNMPL7lewxnS6HhlFGqja0AfctUzmm
	hhUtEH40M6xIOqyJ8fWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTgtQ-001JG3-CX; Sun, 19 Feb 2023 10:26:04 +0000
Received: from mout.web.de ([212.227.17.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTgtH-001JEB-Tk
	for kexec@lists.infradead.org; Sun, 19 Feb 2023 10:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1676802345; i=julian.winkler1@web.de;
	bh=evvdKUDXgntYlASQ7AH1wMB9d5KDjtK7KSm+7v3bYwk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=g4ubDXrgJgYj/Yx2XhZBgbz6ZXHgEGzrXy/s3BU0OxWzo3fRCOajs/TB1uvWcRFsi
	 J3meUOGWrB1lAZx2N1Kx9WHQ7RGnymRHNnE9kdJJA02uop9/89zHaX4smmLiH8EKX3
	 /V6pIuieXkQKKZ+Z30wblWPFTqw6UBfh49Uv9Si6yV1HdB2Ux7tR3bD2NyJjG+kCnG
	 qqRmdhLk25buiD33es0Di0HPAOzYs7Xv9bZgTGLwls5XIsiTq6kO56D4zdZ0oNSSd8
	 BVlJz6apEF03BuLQvKBMrn86gnBlWWmoTOAGk6MMPuZSLyLQayPHDgLk80fT9JN6l9
	 YRzqX+mDkyfcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from aspire-e.fritz.box ([86.103.18.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTL1-1owHnV3Nsn-00bkwn; Sun, 19
 Feb 2023 11:20:40 +0100
From: Julian Winkler <julian.winkler1@web.de>
To: kexec@lists.infradead.org
Cc: Julian Winkler <julian.winkler1@web.de>
Subject: [PATCH] x86: add devicetree support
Date: Sun, 19 Feb 2023 11:18:13 +0100
Message-Id: <20230219101813.903377-1-julian.winkler1@web.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Provags-ID: V03:K1:T71mylQQr+Fv7j+zjd1dm6EA9gFQG9L3A2T17jebTJdLejR6qA2
 bNrzAzTthzuq+THdmhFPtmLvRvC26FT5f5SNQMGSx4oWzxDlsAFaDQvjoGXBSAMyL8b+KqB
 8eLzf5YZRhJ7ZghVr9frOxvgToCVS62pLqzmZ9JEsaVEDwBtJgYHqLCgqOrAfAh/9arzxd5
 xPpxkU0xLvxXa9NZp0zrw==
UI-OutboundReport: notjunk:1;M01:P0:Jea2cMbDQ/Q=;T4j8dIsadbsP+YK9S1dlK5t/Pbi
 TAN/ERyF/vkXD5KC3PXM/3PEDRWobkBlvKZTsjYRD596o9/ihXbaEoJ9PZzwa815QwqGCDYQw
 VnUE5aRHw9fRaxw3wNCKRHXUPTrehgHVCf4QAxa3WQdKOOGfeHg5dq1n4YMGUmyxG6asYDp8X
 3463k0nzP6LxW0VYx5dY+fcXVxCQLMLNHrRsDP1zRffupGdZPvcc02iZaQneeihPOQZxjQu7G
 O5HCuLAnBuY0qt1oKyAdkST2pIcOvmXqxyZCI+ALr2SC4TcRBLob+ffnn3jTZ+I857B/dQWN1
 ZPWhNyVTsLzh6daYmrblZGJdRBFNmLw+X1K3yOynbuCzfkBo2iwb6/gSeqqJlGshTsQ+EpbYr
 fRcMAZapeGoEUw5q0P3xbyhP8cK9dI0bwUZZOaNubP9CW41QDJ+7Vxvn1A5T0fq3ZDWSAhRWr
 2OWwzcf8/df6dC/01owkCeEuJKJKJO+V8o3vo5QDjoUPDbHZyadYUAIPfMzHS198D/1cPLmpv
 tV40510w3kW6q080j4hFOcfs4XDTS3gducAUZjUtQhINqXhXAcWT+ONxbNGnEiXCUrtaA0akW
 NKoU9jGIMLHUzHlENI57opS8Axhsi7HCI9CwlacWNftpcMVJqIg5MPnY7aEo0ksyLf5nyrI6V
 dSnD7i0jCqq9wxqdbpgtMBt2HQfKN1og03EuIdCqTnKDgsLBP4v3mtPfX6MujenWWa+ztRv3N
 /rgOxtICHe4jTt7qKTdWjNXtJvPVGCfvNguAcWQvjJUsHo+j4HLKYYnqPXUBnk71HNnEUNxly
 ecNzLxu/sUFidjQppV+WvtGTXKRq4OVsLFjwLk54YUmxO7vKw8BNfSc380swLyuCaE22qzUQE
 7reT9G51X5gleUC2rW/sklYlo3xFZIkBD1uIHnq3Ih0mEZ5spTW4MU647wykytHsLaZMaS07t
 /JA6r6+X7Fz17cCqUcjzOpcSYko=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230219_022556_465526_A03ECC1D 
X-CRM114-Status: GOOD (  15.28  )
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

Since linux kernel has dropped support for simple firmware interface
(SFI), the only way of boot newer versions on intel MID platform is
using devicetree
---
 kexec/arch/i386/include/arch/options.h |  4 +++-
 kexec/arch/i386/kexec-beoboot-x86.c    |  2 +-
 kexec/arch/i386/kexec-bzImage.c        | 21 ++++++++++++++++++++-
 kexec/arch/i386/kexec-x86.h            |  1 +
 kexec/arch/i386/x86-linux-setup.c      | 15 +++++++++++++++
 kexec/arch/i386/x86-linux-setup.h      |  2 ++
 kexec/arch/x86_64/kexec-bzImage64.c    |  2 +-
 7 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/include/arch/options.h b/kexec/arch/i386/include/arch/options.h
index 0e57951..89e0a95 100644
--- a/kexec/arch/i386/include/arch/options.h
+++ b/kexec/arch/i386/include/arch/options.h
@@ -33,6 +33,7 @@
 #define OPT_PASS_MEMMAP_CMDLINE	(OPT_ARCH_MAX+11)
 #define OPT_NOEFI		(OPT_ARCH_MAX+12)
 #define OPT_REUSE_VIDEO_TYPE	(OPT_ARCH_MAX+13)
+#define OPT_DTB			(OPT_ARCH_MAX+14)

 /* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
@@ -76,7 +77,8 @@
 	{ "args-none",		0, NULL, OPT_ARGS_NONE },	\
 	{ "module",		1, 0, OPT_MOD },		\
 	{ "real-mode",		0, NULL, OPT_REAL_MODE },	\
-	{ "entry-32bit",	0, NULL, OPT_ENTRY_32BIT },
+	{ "entry-32bit",	0, NULL, OPT_ENTRY_32BIT },	\
+	{ "dtb",		1, NULL, OPT_DTB },

 #define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR

diff --git a/kexec/arch/i386/kexec-beoboot-x86.c b/kexec/arch/i386/kexec-beoboot-x86.c
index b121834..d949ab8 100644
--- a/kexec/arch/i386/kexec-beoboot-x86.c
+++ b/kexec/arch/i386/kexec-beoboot-x86.c
@@ -125,7 +125,7 @@ int beoboot_load(int argc, char **argv, const char *buf, off_t UNUSED(len),
 		kernel,        bb_header.kernel_size,
 		command_line,  bb_header.cmdline_size,
 		initrd,        bb_header.initrd_size,
-		real_mode_entry);
+		0, 0, real_mode_entry);

 	return result;
 }
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index df8985d..1b8f20c 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -95,6 +95,7 @@ void bzImage_usage(void)
 		"    --reuse-cmdline       Use kernel command line from running system.\n"
 		"    --initrd=FILE         Use FILE as the kernel's initial ramdisk.\n"
 		"    --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
+		"    --dtb=FILE            Use FILE as devicetree.\n"
 		);

 }
@@ -103,6 +104,7 @@ int do_bzImage_load(struct kexec_info *info,
 	const char *kernel, off_t kernel_len,
 	const char *command_line, off_t command_line_len,
 	const char *initrd, off_t initrd_len,
+	const char *dtb, off_t dtb_len,
 	int real_mode_entry)
 {
 	struct x86_linux_header setup_header;
@@ -373,6 +375,10 @@ int do_bzImage_load(struct kexec_info *info,
 		setup_linux_system_parameters(info, real_mode);
 	}

+	if (dtb) {
+		setup_linux_dtb(info, real_mode, dtb, dtb_len);
+	}
+
 	return 0;
 }

@@ -381,13 +387,15 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 {
 	char *command_line = NULL;
 	char *tmp_cmdline = NULL;
-	const char *ramdisk, *append = NULL;
+	const char *ramdisk, *append = NULL, *dtb;
 	char *ramdisk_buf;
 	off_t ramdisk_length;
 	int command_line_len;
 	int real_mode_entry;
 	int opt;
 	int result;
+	char *dtb_buf;
+	off_t dtb_length;

 	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
@@ -398,6 +406,7 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 		{ "initrd",		1, 0, OPT_RAMDISK },
 		{ "ramdisk",		1, 0, OPT_RAMDISK },
 		{ "real-mode",		0, 0, OPT_REAL_MODE },
+		{ "dtb",		1, 0, OPT_DTB },
 		{ 0, 			0, 0, 0 },
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "d";
@@ -405,6 +414,8 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 	real_mode_entry = 0;
 	ramdisk = 0;
 	ramdisk_length = 0;
+	dtb = 0;
+	dtb_length = 0;
 	while((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch(opt) {
 		default:
@@ -424,6 +435,9 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 		case OPT_REAL_MODE:
 			real_mode_entry = 1;
 			break;
+		case OPT_DTB:
+			dtb = optarg;
+			break;
 		}
 	}
 	command_line = concat_cmdline(tmp_cmdline, append);
@@ -441,10 +455,15 @@ int bzImage_load(int argc, char **argv, const char *buf, off_t len,
 	if (ramdisk) {
 		ramdisk_buf = slurp_file(ramdisk, &ramdisk_length);
 	}
+	dtb_buf = 0;
+	if (dtb) {
+		dtb_buf = slurp_file(dtb, &dtb_length);
+	}
 	result = do_bzImage_load(info,
 		buf, len,
 		command_line, command_line_len,
 		ramdisk_buf, ramdisk_length,
+		dtb_buf, dtb_length,
 		real_mode_entry);

 	free(command_line);
diff --git a/kexec/arch/i386/kexec-x86.h b/kexec/arch/i386/kexec-x86.h
index 71e4329..46e2898 100644
--- a/kexec/arch/i386/kexec-x86.h
+++ b/kexec/arch/i386/kexec-x86.h
@@ -79,6 +79,7 @@ int do_bzImage_load(struct kexec_info *info,
 	const char *kernel, off_t kernel_len,
 	const char *command_line, off_t command_line_len,
 	const char *initrd, off_t initrd_len,
+	const char *dtb, off_t dtb_len,
 	int real_mode_entry);

 int beoboot_probe(const char *buf, off_t len);
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 14263b0..9a281dc 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -954,3 +954,18 @@ void setup_linux_system_parameters(struct kexec_info *info,
 	/* Always try to fill acpi_rsdp_addr */
 	real_mode->acpi_rsdp_addr = get_acpi_rsdp();
 }
+
+void setup_linux_dtb(struct kexec_info *info, struct x86_linux_param_header *real_mode,
+				   const char *dtb_buf, int dtb_len)
+{
+	struct setup_data *sd;
+
+	sd = xmalloc(sizeof(struct setup_data) + dtb_len);
+	sd->next = 0;
+	sd->len = dtb_len;
+	sd->type = SETUP_DTB;
+	memcpy(sd->data, dtb_buf, dtb_len);
+
+
+	add_setup_data(info, real_mode, sd);
+}
diff --git a/kexec/arch/i386/x86-linux-setup.h b/kexec/arch/i386/x86-linux-setup.h
index 0c651e5..b5e1ad5 100644
--- a/kexec/arch/i386/x86-linux-setup.h
+++ b/kexec/arch/i386/x86-linux-setup.h
@@ -21,6 +21,8 @@ static inline void setup_linux_bootloader_parameters(
 }
 void setup_linux_system_parameters(struct kexec_info *info,
 	struct x86_linux_param_header *real_mode);
+void setup_linux_dtb(struct kexec_info *info, struct x86_linux_param_header *real_mode,
+				   const char *dtb_buf, int dtb_len);
 int get_bootparam(void *buf, off_t offset, size_t size);


diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index ba8dc48..aba4e3b 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -386,7 +386,7 @@ int bzImage64_load(int argc, char **argv, const char *buf, off_t len,
 	if (entry_16bit || entry_32bit)
 		result = do_bzImage_load(info, buf, len, command_line,
 					command_line_len, ramdisk_buf,
-					ramdisk_length, entry_16bit);
+					ramdisk_length, 0, 0, entry_16bit);
 	else
 		result = do_bzImage64_load(info, buf, len, command_line,
 					command_line_len, ramdisk_buf,
--
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
