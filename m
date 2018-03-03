Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1esCPB-0002hK-Jb
 for kexec@lists.infradead.org; Sat, 03 Mar 2018 19:01:15 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w23Iwr9D023572
 for <kexec@lists.infradead.org>; Sat, 3 Mar 2018 14:01:00 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gfpwr6uy8-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Sat, 03 Mar 2018 14:00:59 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 3 Mar 2018 19:00:58 -0000
Subject: [PATCH] kexec/ppc64: leverage kexec_file_load support
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Sun, 04 Mar 2018 00:30:50 +0530
MIME-Version: 1.0
Message-Id: <152010365000.15494.15072043690885225651.stgit@hbathini.in.ibm.com>
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
Cc: bauerman@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Kexec-ml <kexec@lists.infradead.org>, Geoff Levand <geoff@infradead.org>

PPC64 kernel now supports kexec_file_load system call. Leverage it by
enabling that support here. Note that loading crash kernel with this
system call is not yet supported in the kernel and trying to load one
will fail with '-ENOTSUPP' error.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c |   84 ++++++++++++++++++++++++++++++++++++
 kexec/kexec-syscall.h              |    3 +
 2 files changed, 87 insertions(+)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index ddd3de8..2742cd6 100644
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
@@ -117,6 +196,9 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	uint32_t my_run_at_load;
 	unsigned int slave_code[256/sizeof (unsigned int)], master_entry;
 
+	if (info->file_mode)
+		return elf_ppc64_load_file(argc, argv, info);
+
 	/* See options.h -- add any more there, too. */
 	static const struct option options[] = {
 		KEXEC_ARCH_OPTIONS
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
