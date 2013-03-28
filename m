Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ULCan-0001DO-5b
 for kexec@lists.infradead.org; Thu, 28 Mar 2013 13:10:10 +0000
Received: by mail-pd0-f172.google.com with SMTP id w10so4110425pde.3
 for <kexec@lists.infradead.org>; Thu, 28 Mar 2013 06:10:07 -0700 (PDT)
Message-ID: <51544127.5080502@gmail.com>
Date: Thu, 28 Mar 2013 21:09:59 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: i386: Add cmdline_add_memmap_internal() to reduce
 the code duplication
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

Functions:
- cmdline_add_memmap()
- cmdline_add_memmap_acpi()
- cmdline_add_memmap_reserved()
is kind of similar, So add a new function cmdline_add_memmap_internal() to
hold the common codes, reducing the duplication.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/i386/crashdump-x86.c |   74 +++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 5462f8b..9ab648b 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -685,13 +685,40 @@ static void ultoa(unsigned long i, char *str)
 	}
 }
 
+static void cmdline_add_memmap_internal(char *cmdline, unsigned long startk,
+					unsigned long endk, int type)
+{
+	int cmdlen, len;
+	char str_mmap[256], str_tmp[20];
+
+	strcpy (str_mmap, " memmap=");
+	ultoa((endk-startk), str_tmp);
+	strcat (str_mmap, str_tmp);
+
+	if (type == RANGE_RAM)
+		strcat (str_mmap, "K@");
+	else if (type == RANGE_RESERVED)
+		strcat (str_mmap, "K$");
+	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
+		strcat (str_mmap, "K#");
+
+	ultoa(startk, str_tmp);
+	strcat (str_mmap, str_tmp);
+	strcat (str_mmap, "K");
+	len = strlen(str_mmap);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str_mmap);
+}
+
 /* Adds the appropriate memmap= options to command line, indicating the
  * memory regions the new kernel can use to boot into. */
 static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
 {
 	int i, cmdlen, len;
 	unsigned long min_sizek = 100;
-	char str_mmap[256], str_tmp[20];
+	char str_mmap[256];
 
 	/* Exact map */
 	strcpy(str_mmap, " memmap=exactmap");
@@ -713,18 +740,7 @@ static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
 		 * up precious command line length. */
 		if ((endk - startk) < min_sizek)
 			continue;
-		strcpy (str_mmap, " memmap=");
-		ultoa((endk-startk), str_tmp);
-		strcat (str_mmap, str_tmp);
-		strcat (str_mmap, "K@");
-		ultoa(startk, str_tmp);
-		strcat (str_mmap, str_tmp);
-		strcat (str_mmap, "K");
-		len = strlen(str_mmap);
-		cmdlen = strlen(cmdline) + len;
-		if (cmdlen > (COMMAND_LINE_SIZE - 1))
-			die("Command line overflow\n");
-		strcat(cmdline, str_mmap);
+		cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_RAM);
 	}
 
 	dbgprintf("Command line after adding memmap\n");
@@ -817,27 +833,15 @@ static enum coretype get_core_type(struct crash_elf_info *elf_info,
 static int cmdline_add_memmap_acpi(char *cmdline, unsigned long start,
 					unsigned long end)
 {
-	int cmdlen, len, align = 1024;
+	int align = 1024;
 	unsigned long startk, endk;
-	char str_mmap[256], str_tmp[20];
 
 	if (!(end - start))
 		return 0;
 
 	startk = start/1024;
 	endk = (end + align - 1)/1024;
-	strcpy (str_mmap, " memmap=");
-	ultoa((endk - startk), str_tmp);
-	strcat (str_mmap, str_tmp);
-	strcat (str_mmap, "K#");
-	ultoa(startk, str_tmp);
-	strcat (str_mmap, str_tmp);
-	strcat (str_mmap, "K");
-	len = strlen(str_mmap);
-	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
-		die("Command line overflow\n");
-	strcat(cmdline, str_mmap);
+	cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_ACPI);
 
 	dbgprintf("Command line after adding acpi memmap\n");
 	dbgprintf("%s\n", cmdline);
@@ -907,27 +911,15 @@ static void get_backup_area(struct kexec_info *info,
 static int cmdline_add_memmap_reserved(char *cmdline, unsigned long start,
 					unsigned long end)
 {
-	int cmdlen, len, align = 1024;
+	int align = 1024;
 	unsigned long startk, endk;
-	char str_mmap[256], str_tmp[20];
 
 	if (!(end - start))
 		return 0;
 
 	startk = start/1024;
 	endk = (end + align - 1)/1024;
-	strcpy (str_mmap, " memmap=");
-	ultoa((endk - startk), str_tmp);
-	strcat (str_mmap, str_tmp);
-	strcat (str_mmap, "K$");
-	ultoa(startk, str_tmp);
-	strcat (str_mmap, str_tmp);
-	strcat (str_mmap, "K");
-	len = strlen(str_mmap);
-	cmdlen = strlen(cmdline) + len;
-	if (cmdlen > (COMMAND_LINE_SIZE - 1))
-		die("Command line overflow\n");
-	strcat(cmdline, str_mmap);
+	cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_RESERVED);
 
 #ifdef DEBUG
 		printf("Command line after adding reserved memmap\n");
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
