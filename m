Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjRXC-0000KB-1I
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 09:26:22 +0000
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 14 Dec 2012 04:26:20 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AB7C1C9003C
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:18 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBE9QIcF286236
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:18 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBE9QHRx017071
 for <kexec@lists.infradead.org>; Fri, 14 Dec 2012 04:26:18 -0500
Subject: [PATCH v3 2/7] makedumpfile and eppic interface layer
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 14 Dec 2012 14:56:13 +0530
Message-ID: <20121214092613.4854.58650.stgit@aravinda>
In-Reply-To: <20121214092300.4854.30720.stgit@aravinda>
References: <20121214092300.4854.30720.stgit@aravinda>
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
language support. The patch dynamically loads the makedumpfile specific
shared object and calls the eppic_load function in shared object to
load/compile and execute the specified eppic macros.

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
 erase_info.c      |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 extension_eppic.h |    1 +
 makedumpfile.c    |    7 +++++-
 makedumpfile.h    |    6 +++++
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/erase_info.c b/erase_info.c
index e2e6a52..0b6dcf4 100644
--- a/erase_info.c
+++ b/erase_info.c
@@ -21,6 +21,8 @@
 #include "dwarf_info.h"
 #include "erase_info.h"
 
+#include <dlfcn.h>
+
 struct erase_info	*erase_info = NULL;
 unsigned long		num_erase_info = 1; /* Node 0 is unused. */
 
@@ -1811,6 +1813,48 @@ process_config_file(const char *name_config)
 	return TRUE;
 }
 
+
+/* Process the eppic macro using eppic library */
+static int
+process_eppic_file(char *name_config)
+{
+	void *handle;
+	void (*eppic_load)(char *), (*eppic_unload)(char *);
+
+	/*
+	 * Dynamically load the eppic_makedumpfile.so library.
+	 * Dynamically loading will cause _init function to be called
+	 */
+	handle = dlopen("eppic_makedumpfile.so", RTLD_LAZY | RTLD_GLOBAL);
+	if (!handle) {
+		ERRMSG("dlopen failed: %s\n", dlerror());
+		return FALSE;
+	}
+
+	/* TODO
+	 * Support specifying eppic macros in makedumpfile.conf file
+	 */
+
+	eppic_load = dlsym(handle, "eppic_load");
+	if (!eppic_load) {
+		ERRMSG("Could not find eppic_load function\n");
+		return FALSE;
+	}
+
+	eppic_unload = dlsym(handle, "eppic_unload");
+	if (!eppic_unload)
+		ERRMSG("Could not find eppic_unload function\n");
+
+	/* Load/compile, execute and unload the eppic macro */
+	eppic_load(name_config);
+	eppic_unload(name_config);
+
+	if (dlclose(handle))
+		ERRMSG("dlclose failed: %s\n", dlerror());
+
+	return TRUE;
+}
+
 static void
 split_filter_info(struct filter_info *prev, unsigned long long next_paddr,
 						size_t size)
@@ -1904,7 +1948,7 @@ extract_filter_info(unsigned long long start_paddr,
 int
 gather_filter_info(void)
 {
-	int ret;
+	int ret = TRUE;
 
 	/*
 	 * Before processing filter config file, load the symbol data of
@@ -1915,7 +1959,17 @@ gather_filter_info(void)
 	if (!load_module_symbols())
 		return FALSE;
 
-	ret = process_config_file(info->name_filterconfig);
+	/*
+	 * XXX: We support specifying both makedumpfile.conf and
+	 * eppic macro at the same time. Whether to retain or discard the
+	 * functionality provided by makedumpfile.conf is open for
+	 * discussion
+	 */
+	if (info->name_filterconfig)
+		ret = process_config_file(info->name_filterconfig);
+
+	if (info->name_eppic_config)
+		ret &= process_eppic_file(info->name_eppic_config);
 
 	/*
 	 * Remove modules symbol information, we dont need now.
diff --git a/extension_eppic.h b/extension_eppic.h
index ca74ce4..34396e4 100644
--- a/extension_eppic.h
+++ b/extension_eppic.h
@@ -21,3 +21,4 @@
 #include "eppic_api.h"
 
 #endif /* _EXTENSION_EPPIC_H */
+
diff --git a/makedumpfile.c b/makedumpfile.c
index 314dc46..087f556 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7330,7 +7330,8 @@ retry:
 		}
 	}
 
-	if (info->name_filterconfig && !gather_filter_info())
+	if ((info->name_filterconfig || info->name_eppic_config)
+			&& !gather_filter_info())
 		return FALSE;
 
 	if (!create_dump_bitmap())
@@ -8228,6 +8229,7 @@ static struct option longopts[] = {
 	{"diskset", required_argument, NULL, 'k'},
 	{"non-cyclic", no_argument, NULL, 'Y'},
 	{"cyclic-buffer", required_argument, NULL, 'Z'},
+	{"eppic", required_argument, NULL, 'S'},
 	{0, 0, 0, 0}
 };
 
@@ -8326,6 +8328,9 @@ main(int argc, char *argv[])
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
index d2bdc0c..a9b7680 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -905,6 +905,12 @@ struct DumpInfo {
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
