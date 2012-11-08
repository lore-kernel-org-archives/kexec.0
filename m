Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWSJQ-000610-91
 for kexec@lists.infradead.org; Thu, 08 Nov 2012 13:38:30 +0000
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 8 Nov 2012 08:38:27 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B95CCC9004C
 for <kexec@lists.infradead.org>; Thu,  8 Nov 2012 08:38:22 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA8DcLJa150344
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 08:38:21 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA8DcJfE009192
 for <kexec@lists.infradead.org>; Thu, 8 Nov 2012 08:38:20 -0500
Subject: [PATCH v2 2/7] makedumpfile and eppic interface layer
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 08 Nov 2012 19:08:15 +0530
Message-ID: <20121108133814.28410.44597.stgit@aravinda>
In-Reply-To: <20121108133554.28410.99763.stgit@aravinda>
References: <20121108133554.28410.99763.stgit@aravinda>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org
Cc: LChouinard@s2sys.com, mahesh@linux.vnet.ibm.com, tachibana@mxm.nes.nec.co.jp, ananth@in.ibm.com, buendgen@de.ibm.com

This patch extends the makedumpfile functionality to include eppic
language support. The patch initializes eppic and then loads and
executes the specified eppic macros.

This patch also includes "--eppic" option to makedumpfile command to
specify the eppic macro or the directory containing eppic macros. The
specified eppic macro will be executed to scrub the data in the
dumpfile. In case of a directory, all the eppic macros inside the
directory will be executed for scrubbing the data.

TODO
	- Support specifying eppic macros in the makedumpfile.conf file.
	  A new command should be added to makedumpfile.conf to identify
	  an eppic macro. This command could be used in any section of
	  the makedumpfile.conf, where the section name indicates the kernel
	  module name. makedumpfile will only search for symbols encountered
	  by eppic macro only in the specified module. Because, searching
	  these symbols in all the modules will cause huge performance
	  overhead.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 erase_info.c      |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 erase_info.h      |    4 ++++
 extension_eppic.h |    3 +++
 makedumpfile.c    |    7 ++++++-
 makedumpfile.h    |    6 ++++++
 5 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index e2e6a52..5d4cfd1 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -1811,6 +1811,34 @@ process_config_file(const char *name_config)
 	return TRUE;
 }
 
+
+/* Process the eppic macro using eppic library */
+#ifdef EPPIC
+static int
+process_eppic_file(char *name_config)
+{
+	int ret = 0;
+
+	/* Initialize eppic*/
+	ret = eppic_init();
+	if (ret) {
+		ERRMSG("Eppic initialization failed\n");
+		return FALSE;
+	}
+
+	/* TODO
+	 * Support specifying eppic macros in makedumpfile.conf file
+	 */
+
+	/* Load/compile and execute the eppic macro */
+	eppic_load(name_config);
+
+	eppic_unload(name_config);
+
+	return TRUE;
+}
+#endif
+
 static void
 split_filter_info(struct filter_info *prev, unsigned long long next_paddr,
 						size_t size)
@@ -1904,7 +1932,7 @@ extract_filter_info(unsigned long long start_paddr,
 int
 gather_filter_info(void)
 {
-	int ret;
+	int ret = TRUE;
 
 	/*
 	 * Before processing filter config file, load the symbol data of
@@ -1915,7 +1943,25 @@ gather_filter_info(void)
 	if (!load_module_symbols())
 		return FALSE;
 
-	ret = process_config_file(info->name_filterconfig);
+	/*
+	 * This patch supports specifying both makedumpfile.conf and
+	 * eppic macro at the same time. Whether to retain or discard the
+	 * functionality provided by makedumpfile.conf is open for
+	 * discussion
+	 */
+	if (info->name_filterconfig)
+		ret = process_config_file(info->name_filterconfig);
+
+	if (info->name_eppic_config)
+#ifdef EPPIC
+		ret &= process_eppic_file(info->name_eppic_config);
+#else
+	{
+		MSG("'-eppic' option is disabled, because this ");
+		MSG("binary doesn't support scrubbing using eppic.\n");
+		MSG("Try `make EPPIC=on` when building.\n");
+	}
+#endif
 
 	/*
 	 * Remove modules symbol information, we dont need now.
diff --git a/erase_info.h b/erase_info.h
index 636fcfa..0e3c3a3 100644
--- a/erase_info.h
+++ b/erase_info.h
@@ -19,6 +19,10 @@
 #ifndef _ERASE_INFO_H
 #define _ERASE_INFO_H
 
+#ifdef EPPIC
+#include "extension_eppic.h"
+#endif
+
 #define MAX_SIZE_STR_LEN (26)
 
 /*
diff --git a/extension_eppic.h b/extension_eppic.h
index ca74ce4..67efd11 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -20,4 +20,7 @@
 
 #include "eppic_api.h"
 
+int eppic_init(void);    /* Eppic initialize */
+
 #endif /* _EXTENSION_EPPIC_H */
+
diff --git a/makedumpfile.c b/makedumpfile.c
index 4931319..3ba74ca 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6943,7 +6943,8 @@ retry:
 		}
 	}
 
-	if (info->name_filterconfig && !gather_filter_info())
+	if ((info->name_filterconfig || info->name_eppic_config)
+			&& !gather_filter_info())
 		return FALSE;
 
 	if (!create_dump_bitmap())
@@ -7779,6 +7780,7 @@ static struct option longopts[] = {
 	{"diskset", required_argument, NULL, 'k'},
 	{"non-cyclic", no_argument, NULL, 'Y'},
 	{"cyclic-buffer", required_argument, NULL, 'Z'},
+	{"eppic", required_argument, NULL, 'S'},
 	{0, 0, 0, 0}
 };
 
@@ -7874,6 +7876,9 @@ main(int argc, char *argv[])
 		case 's':
 			info->flag_split = 1;
 			break;
+		case 'S':
+			info->name_eppic_config = optarg;
+			break;
 		case 'r':
 			info->flag_reassemble = 1;
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index 2b88fa4..f7e0616 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -830,6 +830,12 @@ struct DumpInfo {
 	FILE		*file_filterconfig;
 
 	/*
+	 * Filter config file containing eppic language filtering rules
+	 * to filter out kernel data from vmcore
+	 */
+	char		*name_eppic_config;
+
+	/*
 	 * diskdimp info:
 	 */
 	int		block_order;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
