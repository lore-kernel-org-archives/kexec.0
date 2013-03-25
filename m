Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK975-0003hy-5l
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 15:15:07 +0000
Received: by mail-pb0-f42.google.com with SMTP id xb4so4220487pbc.29
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 08:15:05 -0700 (PDT)
Message-ID: <515069F4.40707@gmail.com>
Date: Mon, 25 Mar 2013 23:15:00 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 09/13] kexec: ppc: uImage: fix possible memory leak in
 ppc_load_bare_bits
References: <51506758.4070902@gmail.com>
In-Reply-To: <51506758.4070902@gmail.com>
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

In ppc_load_bare_bits, allocated memory may not be free'd if the code
exits abnormally, by calling die() or return. So the patch fixes
the possible memory leak.

This patch is also a preparation for patch10.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/ppc/kexec-uImage-ppc.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 900cd16..fd8959c 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -90,13 +90,14 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	char *fixup_nodes[FIXUP_ENTRYS + 1];
 	int cur_fixup = 0;
 	int opt;
-	int ret;
+	int ret = 0;
 	char *seg_buf = NULL;
 	off_t seg_size = 0;
 	unsigned long long hole_addr;
 	unsigned long max_addr;
 	char *blob_buf = NULL;
 	off_t blob_size = 0;
+	char *error_msg = NULL;
 
 	cmdline_buf = NULL;
 	command_line = NULL;
@@ -186,7 +187,8 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		ret = load_crashdump_segments(info, crash_cmdline,
 						max_addr, 0);
 		if (ret < 0) {
-			return -1;
+			ret = -1;
+			goto out;
 		}
 	}
 
@@ -212,8 +214,10 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 		create_flatten_tree(info, (unsigned char **)&blob_buf,
 				(unsigned long *)&blob_size, cmdline_buf);
 	}
-	if (!blob_buf || !blob_size)
-		die("Device tree seems to be an empty file.\n");
+	if (!blob_buf || !blob_size) {
+		error_msg = "Device tree seems to be an empty file.\n";
+		goto out2;
+	}
 
 	/* initial fixup for device tree */
 	blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, load_addr, &dtb_addr);
@@ -249,7 +253,8 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 			load_addr + KERNEL_ACCESS_TOP, 1);
 	if (dtb_addr_actual != dtb_addr) {
 		printf("dtb_addr_actual: %lx, dtb_addr: %lx\n", dtb_addr_actual, dtb_addr);
-		die("Error device tree not loadded to address it was expecting to be loaded too!\n");
+		error_msg = "Error device tree not loadded to address it was expecting to be loaded too!\n";
+		goto out2;
 	}
 
 	/* set various variables for the purgatory */
@@ -286,7 +291,13 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 	addr = elf_rel_get_addr(&info->rhdr, "purgatory_start");
 	info->entry = (void *)addr;
 
-	return 0;
+out2:
+	free(cmdline_buf);
+out:
+	free(crash_cmdline);
+	if (error_msg)
+		die(error_msg);
+	return ret;
 }
 
 int uImage_ppc_load(int argc, char **argv, const char *buf, off_t len,
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
