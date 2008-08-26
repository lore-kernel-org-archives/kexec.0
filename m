Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXwT0-00071v-8Y
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 11:12:06 +0000
Received: by rv-out-0708.google.com with SMTP id b17so1911060rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 04:12:06 -0700 (PDT)
From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2008 20:12:18 +0900
Message-Id: <20080826111218.615.85487.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
Subject: [PATCH 04/06] sh: Autodetect zImage zero page address
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@igel.co.jp>

Autodetect the zero page base address for zImages on SuperH.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 kexec/arch/sh/kexec-sh.c        |   40 +++++++------------
 kexec/arch/sh/kexec-sh.h        |    3 -
 kexec/arch/sh/kexec-zImage-sh.c |   79 ++++++++++++++++++++++++++++-----------
 3 files changed, 75 insertions(+), 47 deletions(-)

--- 0004/kexec/arch/sh/kexec-sh.c
+++ work/kexec/arch/sh/kexec-sh.c	2008-08-22 12:05:08.000000000 +0900
@@ -65,16 +65,8 @@ void arch_usage(void)
     " none\n\n"
     "Default options:\n"
     " --append=\"%s\"\n"
-    " --empty-zero=0x%08x\n\n"
     " STRING of --appned is set form /proc/cmdline as default.\n"
-    " ADDRESS of --empty-zero can be set SHELL environment variable\n"
-    " KEXEC_EMPTY_ZERO as default.\n\n"
-    " ADDRESS can be get in the following method in your system. \n"
-    " 1) \"grep empty_zero /proc/kallsyms\". \n"
-    " 2) \"grep empty_zero System.map\". \n"
-    " 3) CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET in your kernel\n"
-    "    config file.\n"
-    ,get_append(), (unsigned int) get_empty_zero(NULL));
+    ,get_append());
 
 }
 
@@ -130,21 +122,6 @@ void arch_update_purgatory(struct kexec_
 {
 }
 
-
-unsigned long get_empty_zero(char *s)
-{
-        char *env;
-
-	env = getenv("KEXEC_EMPTY_ZERO");
-
-	if(s){
-	  env = s;
-	}else if(!env){
-	  env = "0x0c001000";
-	}
-	return 0x1fffffff & strtoul(env,(char **)NULL,0);
-}
-
 char append_buf[256];
 
 char *get_append(void)
@@ -162,6 +139,21 @@ char *get_append(void)
         return append_buf;
 }
 
+void kexec_sh_setup_zero_page(char *zero_page_buf, int zero_page_size,
+			      char *cmd_line)
+{
+	int n = zero_page_size - 0x100;
+
+	memset(zero_page_buf, 0, zero_page_size);
+	
+	if (cmd_line) {
+		if (n > strlen(cmd_line))
+			n = strlen(cmd_line);
+
+		memcpy(zero_page_buf + 0x100, cmd_line, n);
+		zero_page_buf[0x100 + n] = '\0';
+	}
+}
 
 int is_crashkernel_mem_reserved(void)
 {
--- 0001/kexec/arch/sh/kexec-sh.h
+++ work/kexec/arch/sh/kexec-sh.h	2008-08-22 12:05:08.000000000 +0900
@@ -12,6 +12,7 @@ int netbsd_sh_load(int argc, char **argv
 void netbsd_sh_usage(void);
 
 char *get_append(void);
-unsigned long get_empty_zero(char *s);
+void kexec_sh_setup_zero_page(char *zero_page_buf, int zero_page_size,
+			      char *cmd_line);
 
 #endif /* KEXEC_SH_H */
--- 0004/kexec/arch/sh/kexec-zImage-sh.c
+++ work/kexec/arch/sh/kexec-zImage-sh.c	2008-08-22 14:28:29.000000000 +0900
@@ -28,6 +28,24 @@
 
 static const int probe_debug = 0;
 
+#define HEAD32_KERNEL_START_ADDR 0
+#define HEAD32_DECOMPRESS_KERNEL_ADDR 1
+#define HEAD32_INIT_STACK_ADDR 2
+#define HEAD32_INIT_SR 3
+#define HEAD32_INIT_SR_VALUE 0x400000F0
+
+unsigned long zImage_head32(const char *buf, off_t len, int offs)
+{
+	unsigned long *values = (void *)buf;
+	int k;
+
+	for (k = (0x200 / 4) - 1; k > 0; k--)
+		if (values[k] != 0x00090009) /* not nop + nop padding*/
+			return values[k - offs];
+
+	return 0;
+}
+
 /*
  * zImage_sh_probe - sanity check the elf image
  *
@@ -35,10 +53,12 @@ static const int probe_debug = 0;
  */
 int zImage_sh_probe(const char *buf, off_t len)
 {
-	if (memcmp(&buf[0x202], "HdrS", 4) != 0) {
-	        fprintf(stderr, "Not a zImage\n");
+	if (memcmp(&buf[0x202], "HdrS", 4) != 0)
 	        return -1;
-	}
+
+	if (zImage_head32(buf, len, HEAD32_INIT_SR) != HEAD32_INIT_SR_VALUE)
+	        return -1;
+
 	return 0;
 }
 
@@ -54,10 +74,9 @@ int zImage_sh_load(int argc, char **argv
 	struct kexec_info *info)
 {
         char *command_line;
-	int opt;
-	unsigned long empty_zero, area;
-	unsigned char *param;
-	unsigned long *paraml;
+	int opt, k;
+	unsigned long empty_zero, area, zero_page_base, zero_page_size;
+	char *param;
 
 	static const struct option options[] = {
        	        KEXEC_ARCH_OPTIONS
@@ -67,7 +86,6 @@ int zImage_sh_load(int argc, char **argv
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "";
 
 	command_line = 0;
-	empty_zero = get_empty_zero(NULL);
 	while ((opt = getopt_long(argc, argv, short_options, options, 0)) != -1) {
 		switch (opt) {
 		default:
@@ -81,25 +99,42 @@ int zImage_sh_load(int argc, char **argv
 		case OPT_APPEND:
 			command_line = optarg;
 			break;
-		case OPT_EMPTYZERO:
-			empty_zero = get_empty_zero(optarg);
-			break;
 		}
 	}
-	param = xmalloc(4096);
-	memset(param, 0, 4096);
-	area       = empty_zero & 0x1c000000;
-	if (!command_line) {
+
+	if (!command_line)
 	        command_line = get_append();
-	}
-	strncpy(&param[256], command_line, strlen(command_line));
-        paraml = (unsigned long *)param;
-	// paraml[0] = 1;  // readonly flag is set as default
 
-	add_segment(info, param, 4096, 0x80000000 | empty_zero, 4096);
-	add_segment(info, buf,   len,  (area | 0x80210000), len);
+	/* assume the zero page is the page before the vmlinux entry point.
+	 * we don't know the page size though, but 64k seems to be max.
+	 * put several 4k zero page copies before the entry point to cover
+	 * all combinations.
+	 */
+
+	empty_zero = zImage_head32(buf, len, HEAD32_KERNEL_START_ADDR);
+
+	zero_page_size = 0x10000;
+	zero_page_base = virt_to_phys(empty_zero - zero_page_size);
+
+	while (!valid_memory_range(info, zero_page_base,
+				   zero_page_base + zero_page_size - 1)) {
+		zero_page_base += 0x1000;
+		zero_page_size -= 0x1000;
+		if (zero_page_size == 0)
+			die("Unable to determine zero page size from %p \n",
+			    (void *)empty_zero);
+	} 
+
+	param = xmalloc(zero_page_size);
+	for (k = 0; k < (zero_page_size / 0x1000); k++)
+		kexec_sh_setup_zero_page(param + (k * 0x1000), 0x1000,
+					 command_line);
 
-	/* For now we don't have arguments to pass :( */
+	add_segment(info, param, zero_page_size,
+		    0x80000000 | zero_page_base, zero_page_size);
+
+	area = empty_zero & 0x1c000000;
+	add_segment(info, buf,   len,  (area | 0x80210000), len);
 	info->entry = (void *)(0x80210000 | area);
 	return 0;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
