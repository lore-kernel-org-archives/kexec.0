Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKr2Z-0003O5-8t
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 14:09:23 +0000
Received: by mail-pa0-f49.google.com with SMTP id kp14so1900119pab.22
 for <kexec@lists.infradead.org>; Wed, 27 Mar 2013 07:09:21 -0700 (PDT)
Message-ID: <5152FD8C.2070100@gmail.com>
Date: Wed, 27 Mar 2013 22:09:16 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: ppc: Use die() instead of fatal()
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

fatal() nearly does the same thing as die() does, so this is kind of
duplicate. Remove fatal() and use die() instead.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/fixup_dtb.c      |    8 ++++----
 kexec/arch/ppc/libfdt-wrapper.c |    8 ++++----
 kexec/arch/ppc/ops.h            |    2 --
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index f832026..2c9e250 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -54,7 +54,7 @@ static void fixup_nodes(char *nodes[])
 
 		len = asprintf(&fname, "%s%s", proc_dts, nodes[index]);
 		if (len < 0)
-			fatal("asprintf() failed\n");
+			die("asprintf() failed\n");
 
 		content = slurp_file(fname, &content_size);
 		if (!content) {
@@ -78,7 +78,7 @@ static void fixup_nodes(char *nodes[])
 
 		ret = setprop(node, prop_name, content, content_size);
 		if (ret < 0)
-			fatal("setprop of %s/%s size: %ld failed: %s\n",
+			die("setprop of %s/%s size: %ld failed: %s\n",
 					node_name, prop_name, content_size,
 					fdt_strerror(ret));
 
@@ -125,10 +125,10 @@ static char *expand_buf(int minexpand, char *blob_buf, off_t *blob_size)
 	size = _ALIGN(size + minexpand, EXPAND_GRANULARITY);
 	blob_buf = realloc(blob_buf, size);
 	if (!blob_buf)
-		fatal("Couldn't find %d bytes to expand device tree\n\r", size);
+		die("Couldn't find %d bytes to expand device tree\n\r", size);
 	rc = fdt_open_into(blob_buf, blob_buf, size);
 	if (rc != 0)
-		fatal("Couldn't expand fdt into new buffer: %s\n\r",
+		die("Couldn't expand fdt into new buffer: %s\n\r",
 			fdt_strerror(rc));
 
 	*blob_size = fdt_totalsize(blob_buf);
diff --git a/kexec/arch/ppc/libfdt-wrapper.c b/kexec/arch/ppc/libfdt-wrapper.c
index 5fbd3a8..ef355d0 100644
--- a/kexec/arch/ppc/libfdt-wrapper.c
+++ b/kexec/arch/ppc/libfdt-wrapper.c
@@ -66,10 +66,10 @@ static void expand_buf(int minexpand)
 	size = _ALIGN(size + minexpand, EXPAND_GRANULARITY);
 	buf = realloc(buf, size);
 	if (!buf)
-		fatal("Couldn't find %d bytes to expand device tree\n\r", size);
+		die("Couldn't find %d bytes to expand device tree\n\r", size);
 	rc = fdt_open_into(fdt, buf, size);
 	if (rc != 0)
-		fatal("Couldn't expand fdt into new buffer: %s\n\r",
+		die("Couldn't expand fdt into new buffer: %s\n\r",
 		      fdt_strerror(rc));
 
 	fdt = buf;
@@ -159,7 +159,7 @@ static unsigned long fdt_wrapper_finalize(void)
 
 	rc = fdt_pack(fdt);
 	if (rc != 0)
-		fatal("Couldn't pack flat tree: %s\n\r",
+		die("Couldn't pack flat tree: %s\n\r",
 		      fdt_strerror(rc));
 	return (unsigned long)fdt;
 }
@@ -185,5 +185,5 @@ void fdt_init(void *blob)
 
 	err = fdt_open_into(fdt, fdt, bufsize);
 	if (err != 0)
-		fatal("fdt_init(): %s\n\r", fdt_strerror(err));
+		die("fdt_init(): %s\n\r", fdt_strerror(err));
 }
diff --git a/kexec/arch/ppc/ops.h b/kexec/arch/ppc/ops.h
index a2eb140..7334a05 100644
--- a/kexec/arch/ppc/ops.h
+++ b/kexec/arch/ppc/ops.h
@@ -145,6 +145,4 @@ static inline char *get_path(const void *phandle, char *buf, int len)
 	return NULL;
 }
 
-#define fatal(args...) { printf(args); exit(1); }
-
 #endif /* _PPC_BOOT_OPS_H_ */
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
