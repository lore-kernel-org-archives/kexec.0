Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C3FC636D7
	for <kexec@archiver.kernel.org>; Thu, 23 Feb 2023 06:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Qo3b01DQmp+p29lEYONo3lDLUxwdNpo6bMvXHebpFto=; b=EgzxqKcm8zMInC
	GQZN8W1MUm9FfR0IxxykFGnTTYJy2TiDh9YqCONF/70Y5CVvFj7Sx3kNQHKwxvCUfFc+06p9MJbPa
	gSXilugSzItruZv0dx+xUADPHmyGjcvZVslOkrPEVjlYZxx9Jt134d9NsqmcXCoX6WqaROaR5EJkW
	G5Gf2b1kUw6h69sShV8xtl33gMC27IKVXfqDLa0w/Cdl0WYGhRQi/bLYPlJG8W2VzoAgJUMN6uBp3
	WAkuOhR835I75xTyIbl1ojUZM7kEPOgX9PEt1YUpkcVFBRdNr4xri77+7V+8oYxVWHQrs8uJ5ET16
	1/D2Xb5MSZ+rw16iA3Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pV4fz-00FDyv-Oq; Thu, 23 Feb 2023 06:01:55 +0000
Received: from mout.web.de ([217.72.192.78])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pV4fv-00FDwb-EV
	for kexec@lists.infradead.org; Thu, 23 Feb 2023 06:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1677132102; i=julian.winkler1@web.de;
	bh=HxsVqgKdqJFEaMoFMadFDqY835DV7iRYejvdQv3XFT4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=d3V846wI8SrWH1/rWtc2qoq/otM/LO50oseGABtrd0f0AZQBwjzoa3+Iz1azD8ATA
	 5XEBYcvkp9auYOManySWM8r2gz0ZHSq5GrUF4oPg6iRtlWjGByrlLS7cOZzZTzBIHj
	 J/AWNasMO86FgHcFEGqGHVzPu+BNCLkaz2xy06w4YivRJdq0bSOvvBIy4JXyypDvdP
	 lQ12FHEe8CtnVEocTDfa9+HYP5iCpiOf7nriwq5vJb1Y9Ewah6vYJxnX1iHrRASouR
	 si5qdIzbUGDbWI38IW2VPD5AokAQIrAeh03H6hli/4MXUkgF+k86TylXe+9ULPBbhW
	 FfRMMU2lhMH0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from aspire-e.fritz.box ([86.103.228.143]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1oTneL1SlT-011YTw; Thu, 23
 Feb 2023 07:01:42 +0100
From: Julian Winkler <julian.winkler1@web.de>
To: kexec@lists.infradead.org
Cc: Julian Winkler <julian.winkler1@web.de>
Subject: [PATCH v2] x86: add devicetree support
Date: Thu, 23 Feb 2023 07:01:07 +0100
Message-Id: <20230223060107.23029-1-julian.winkler1@web.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Provags-ID: V03:K1:iPuANDvOmzUilk4UAnwx1a+Go/pD6585+Yun/lRKjHi2AgBAkFS
 P3NO5Vd+407h8xZDoxm+13i5z4lfkSytXwTqCHOyiiA/LLheAlWYiTZZyVFE0Zu0iFzXBDP
 kNdNHGnXzsnqy6/n1V/z66dpskyES9QVPXW1iNSnP16eumaNTWkOilw+Fw+do3DkcRevp+X
 QuhZizR6285RFKYlWTSAw==
UI-OutboundReport: notjunk:1;M01:P0:VcKEPFyNK20=;pBnkCaYbj7n6iANpbN6eJTMm9yH
 CYkkt500vItSNeJeWsQ517oN4/SxVErPx7j1xjs2v6oDQsOWZSPR6H03WABQXFuQyN+XhDykv
 8UcXyD6CMmFJfWFwQhGMmySyJEoAMjAebe9Fjtc+Mv7RL97P7hWhaBrmkGQ547wtkDp8mYAxH
 RGdH5us7GEgmSCJ+tkar5ZTLvsHgcBSu5Rc3g23iMGEfhwInTS2de78d5/tFhMBg0bJurPxop
 viXu7u88f1j9xJuuB4KVlkdkGlF7TQkeHB8dU42j9OenwpHlu7UE3/n6/SlZYumoYrjmxS054
 RiG8bKf+xaCrUldLkDvBKJwM+RNywvO+btMoDx2GM6FUUFkMZN8ItxUCZPipHdQETg52bn2a1
 cyDXrAzicg+6EoihUjaW/yfZxm5sCO/Rg1RKRZHK2y6vifZiVSDEnCbwO/3I2sZLDrphK7TXB
 CCQcxfvzAC9GAULyHl5oGsi88JGz83Li1FtcmZLQCJt6jv24D8nwxriAI160S8FFFGiCZXrbe
 Xll1XiK491lq2K8w0FN2//UFm+3cQiQuVw9bDvDwTXTwfcVIvqb5xy21rNiEIsvsi1pb0ygZj
 mhajA7RGciJwbJ2Ma2wMu4SWpnFFj0/w/iAy+jh3R4giFRZwHk6w89abZsL1ThnsUD0oH3Or2
 lu4aJ98t4bUlzFvYSjZolXWd+ay0uY4ajiNZU8FurZJMqp+eY1qfXVia0c9yTXDnYmvOU8BbY
 7L77L1xHVrGf2IsqfPSsa0c1T7Pt87nEGQi7M0gAsD3v8fbyyEiNxA7kZb6GU2MdRN7AgWpT/
 qy3Rs3uIgqzv/91UiI+z6odYxYz7hvltC9AYa6P2AQ5/jSrSn9M0BT28PmuEWGgoSgwVWY8+D
 WGxtPWRNMrhPMK1K0+e/CcRcANed6j0wmZKyOFOOAszLjbPFNw215Bpugi7KZyJ1cJhxjV5jY
 x4ux0pSecNGJEKDtdofGdGPljSE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230222_220151_978568_C6248741 
X-CRM114-Status: GOOD (  16.99  )
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

Signed-off-by: Julian Winkler <julian.winkler1@web.de>
---
V2: added Signed-off-by to commit message

In the first version, the whitespaces got screwed up by my mail
provider, sending this time with --transfer-encoding=quoted-printable

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
