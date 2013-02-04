Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U2S78-0001ns-Uf
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 19:54:03 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
 by relay3.corp.sgi.com (Postfix) with ESMTP id E3CAAAC001
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 11:54:00 -0800 (PST)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
 by estes.americas.sgi.com (Postfix) with ESMTP id A2955700179D
 for <kexec@lists.infradead.org>; Mon,  4 Feb 2013 13:54:00 -0600 (CST)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
 (envelope-from <cpw@sgi.com>) id 1U2S76-00057L-Kp
 for kexec@lists.infradead.org; Mon, 04 Feb 2013 13:54:00 -0600
Subject: [PATCH] kexec: include reserved e820 sections in crash kernel
Message-Id: <E1U2S76-00057L-Kp@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Mon, 04 Feb 2013 13:54:00 -0600
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
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

From: Cliff Wickman <cpw@sgi.com>

The crash kernel is not able to find its root device if that device is not
on PCI 0.

This is because it is booted with the command line option memmap=exactmap
which currently clears the e820 table and does not restore reserved spaces.

This works for a device on PCI 0 because ACPI falls back to a legacy mode.
But the error message " [Firmware Bug]: PCI: MMCONFIG at
 [mem 0x80000000-0x80cfffff] not reserved in ACPI motherboard resources"
is written to the log even in this functioning case.

It fails for some devices on UV2, and only for UV2, because SGI seems to
be the only manufacturer currently using the extended PCI(>0).

The fix is simple, as long as the command line is long enough to include
all the reserved spaces.
The command line may have to be lengthened. See
  [PATCH] kexec: lengthen the kernel command line image

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 kexec/arch/i386/crashdump-x86.c |   43 ++++++++++++++++++++++++++++++++++++++--
 kexec/kexec-syscall.h           |    2 -
 2 files changed, 42 insertions(+), 3 deletions(-)

Index: kexec-tools-2.0.3/kexec/arch/i386/crashdump-x86.c
===================================================================
--- kexec-tools-2.0.3.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools-2.0.3/kexec/arch/i386/crashdump-x86.c
@@ -236,6 +236,8 @@ static int get_crash_memory_ranges(struc
 			type = RANGE_ACPI;
 		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
 			type = RANGE_ACPI_NVS;
+		} else if(memcmp(str,"reserved\n", 9) == 0 ) {
+			type = RANGE_RESERVED;
 		} else if (memcmp(str, "GART\n", 5) == 0) {
 			gart_start = start;
 			gart_end = end;
@@ -708,6 +710,39 @@ static void get_backup_area(unsigned lon
 	fclose(fp);
 }
 
+/* Appends memmap=X$Y commandline for reserved memory to command line*/
+static int cmdline_add_memmap_reserved(char *cmdline, unsigned long start,
+					unsigned long end)
+{
+	int cmdlen, len, align = 1024;
+	unsigned long startk, endk;
+	char str_mmap[256], str_tmp[20];
+
+	if (!(end - start))
+		return 0;
+
+	startk = start/1024;
+	endk = (end + align - 1)/1024;
+	strcpy (str_mmap, " memmap=");
+	ultoa((endk - startk), str_tmp);
+	strcat (str_mmap, str_tmp);
+	strcat (str_mmap, "K$");
+	ultoa(startk, str_tmp);
+	strcat (str_mmap, str_tmp);
+	strcat (str_mmap, "K");
+	len = strlen(str_mmap);
+	cmdlen = strlen(cmdline) + len;
+	if (cmdlen > (COMMAND_LINE_SIZE - 1))
+		die("Command line overflow\n");
+	strcat(cmdline, str_mmap);
+
+#ifdef DEBUG
+		printf("Command line after adding reserved memmap\n");
+		printf("%s\n", cmdline);
+#endif
+	return 0;
+}
+
 /* Loads additional segments in case of a panic kernel is being loaded.
  * One segment for backup region, another segment for storing elf headers
  * for crash memory image.
@@ -844,11 +879,15 @@ int load_crashdump_segments(struct kexec
 	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
 		unsigned long start, end;
 		if ( !( mem_range[i].type == RANGE_ACPI
-			|| mem_range[i].type == RANGE_ACPI_NVS) )
+			|| mem_range[i].type == RANGE_ACPI_NVS
+			|| mem_range[i].type == RANGE_RESERVED) )
 			continue;
 		start = mem_range[i].start;
 		end = mem_range[i].end;
-		cmdline_add_memmap_acpi(mod_cmdline, start, end);
+		if (mem_range[i].type == RANGE_RESERVED)
+			cmdline_add_memmap_reserved(mod_cmdline, start, end);
+		else
+			cmdline_add_memmap_acpi(mod_cmdline, start, end);
 	}
 	return 0;
 }
Index: kexec-tools-2.0.3/kexec/kexec-syscall.h
===================================================================
--- kexec-tools-2.0.3.orig/kexec/kexec-syscall.h
+++ kexec-tools-2.0.3/kexec/kexec-syscall.h
@@ -96,7 +96,7 @@ static inline long kexec_reboot(void)
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
 #define KEXEC_ARCH_CRIS    (76 << 16)
 
-#define KEXEC_MAX_SEGMENTS 16
+#define KEXEC_MAX_SEGMENTS 70
 
 #ifdef __i386__
 #define KEXEC_ARCH_NATIVE	KEXEC_ARCH_386

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
