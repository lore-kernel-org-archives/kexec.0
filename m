Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0NmH-0000xc-Rk
 for kexec@lists.infradead.org; Mon, 26 Mar 2018 08:46:55 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2Q8jZqZ133324
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2018 04:46:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gxty6q72h-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Mar 2018 04:46:41 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 09:46:40 +0100
Subject: [PATCH v2] kexec/ppc64: leverage kexec_file_load support
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 26 Mar 2018 14:16:34 +0530
MIME-Version: 1.0
Message-Id: <152205397129.8303.10583424055676557501.stgit@hbathini.in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>, Petr Tesarik <ptesarik@suse.cz>, bauerman@linux.vnet.ibm.com

PPC64 kernel now supports kexec_file_load system call. Leverage it by
enabling that support here. Note that loading crash kernel with this
system call is not yet supported in the kernel and trying to load one
will fail with '-ENOTSUPP' error.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---

Changes in v2:
* Avoided executable code from being added between variable declarations.


 kexec/arch/ppc64/kexec-elf-ppc64.c |   84 ++++++++++++++++++++++++++++++++++++
 kexec/kexec-syscall.h              |    3 +
 2 files changed, 87 insertions(+)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index ddd3de8..3510b70 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -93,6 +93,85 @@ static int read_prop(char *name, void *value, size_t len)
 	return 0;
 }
 
+static int elf_ppc64_load_file(int argc, char **argv, struct kexec_info *info)
+{
+	int ret = 0;
+	char *cmdline, *dtb;
+	int opt, cmdline_len = 0;
+
+	/* See options.h -- add any more there, too. */
+	static const struct option options[] = {
+		KEXEC_ARCH_OPTIONS
+		{ "command-line",       1, NULL, OPT_APPEND },
+		{ "append",             1, NULL, OPT_APPEND },
+		{ "ramdisk",            1, NULL, OPT_RAMDISK },
+		{ "initrd",             1, NULL, OPT_RAMDISK },
+		{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },
+		{ "dtb",                1, NULL, OPT_DEVICETREEBLOB },
+		{ "args-linux",		0, NULL, OPT_ARGS_IGNORE },
+		{ 0,                    0, NULL, 0 },
+	};
+
+	static const char short_options[] = KEXEC_OPT_STR "";
+
+	/* Parse command line arguments */
+	cmdline = 0;
+	dtb = 0;
+	ramdisk = 0;
+
+	while ((opt = getopt_long(argc, argv, short_options,
+					options, 0)) != -1) {
+		switch (opt) {
+		default:
+			/* Ignore core options */
+			if (opt < OPT_ARCH_MAX)
+				break;
+		case OPT_APPEND:
+			cmdline = optarg;
+			break;
+		case OPT_RAMDISK:
+			ramdisk = optarg;
+			break;
+		case OPT_DEVICETREEBLOB:
+			dtb = optarg;
+			break;
+		case OPT_ARGS_IGNORE:
+			break;
+		}
+	}
+
+	if (dtb)
+		die("--dtb not supported while using --kexec-file-syscall.\n");
+
+	if (reuse_initrd)
+		die("--reuseinitrd not supported with --kexec-file-syscall.\n");
+
+	if (cmdline) {
+		cmdline_len = strlen(cmdline) + 1;
+	} else {
+		cmdline = strdup("\0");
+		cmdline_len = 1;
+	}
+
+	if (ramdisk) {
+		info->initrd_fd = open(ramdisk, O_RDONLY);
+		if (info->initrd_fd == -1) {
+			fprintf(stderr, "Could not open initrd file %s:%s\n",
+					ramdisk, strerror(errno));
+			ret = -1;
+			goto out;
+		}
+	}
+
+	info->command_line = cmdline;
+	info->command_line_len = cmdline_len;
+	return ret;
+out:
+	if (cmdline_len == 1)
+		free(cmdline);
+	return ret;
+}
+
 int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			struct kexec_info *info)
 {
@@ -132,6 +211,9 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 
 	static const char short_options[] = KEXEC_OPT_STR "";
 
+	if (info->file_mode)
+		return elf_ppc64_load_file(argc, argv, info);
+
 	/* Parse command line arguments */
 	initrd_base = 0;
 	initrd_size = 0;
@@ -387,6 +469,8 @@ void elf_ppc64_usage(void)
 	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
 	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
 	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
+	fprintf(stderr, "                                 ");
+	fprintf(stderr, "Not applicable while using --kexec-file-syscall.\n");
 	fprintf(stderr, "     --dtb=<filename> same as --devicetreeblob.\n");
 
 	fprintf(stderr, "elf support is still broken\n");
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 3b5c528..33638c2 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -61,6 +61,9 @@
 #ifdef __x86_64__
 #define __NR_kexec_file_load	320
 #endif
+#ifdef __powerpc64__
+#define __NR_kexec_file_load	382
+#endif
 
 #ifndef __NR_kexec_file_load
 /* system call not available for the arch */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
