Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TxfNU-0001za-D9
 for kexec@lists.infradead.org; Tue, 22 Jan 2013 15:03:10 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] kexec x86: Make kexec aware of new memmap= kernel
 parameter possibilities
Date: Tue, 22 Jan 2013 16:02:15 +0100
Message-Id: <1358866935-18458-4-git-send-email-trenn@suse.de>
In-Reply-To: <1358866935-18458-1-git-send-email-trenn@suse.de>
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
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
To: horms@verge.net.au
Cc: x86@kernel.org, kexec@lists.infradead.org, hpa@zytor.com, yinghai@kernel.org, Thomas Renninger <trenn@suse.de>, vgoyal@redhat.com

Latest kernel (3.9 and newer) is aware of
memmap=resetusablemap (instead of memmap=exactmap).
In this case the kdump kernel uses unusable memory areas (reserved, ACPI, NVS)
as passed by e820 table via kexec. This is done in
kexec/firmware_memmap.c (collected from /sys/firmware/memmap from the original
kernel).
Therefore reserved memory areas need not to get passed via memmap=x#y or
memmap=x$y anymore.

With this kernel version on, it is also possible to pass several memmap=
options via one comma separated memmap=resetusablemap,x@y,... kernel parameter.
This patch enables kexec to make use of it.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 kexec/arch/i386/crashdump-x86.c |   46 ++++++++++++++++++++++++++++----------
 1 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index a900b03..9bba8d1 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -676,6 +676,8 @@ static void ultoa(unsigned long i, char *str)
 	}
 }
 
+static int new_memmap_syntax;
+
 /* Adds the appropriate memmap= options to command line, indicating the
  * memory regions the new kernel can use to boot into. */
 static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
@@ -684,8 +686,23 @@ static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
 	unsigned long min_sizek = 100;
 	char str_mmap[256], str_tmp[20];
 
-	/* Exact map */
-	strcpy(str_mmap, " memmap=exactmap");
+	/*
+	 * kernel is aware of comma separated memmap=
+	 * and memmap=resetusablemap boot param, reserved memory
+	 * areas are taken over from original e820 boot map and must
+	 * not be passed anymore, only usable memory areas:
+	 * old syntax: memmap=exactmap memmap=x@y memmap=w@z memmap=k#f
+	 * new syntax: memmap=resetusablemap,x@y,w@z
+	 */
+	if (kv_to_load >= KERNEL_VERSION(3, 7, 0))
+		new_memmap_syntax = 1;
+
+	if (new_memmap_syntax)
+		strcpy(str_mmap, " memmap=resetusablemap");
+	else
+		/* Exact map */
+		strcpy(str_mmap, " memmap=exactmap");
+
 	len = strlen(str_mmap);
 	cmdlen = strlen(cmdline) + len;
 	if (cmdlen > (COMMAND_LINE_SIZE - 1))
@@ -704,7 +721,10 @@ static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
 		 * up precious command line length. */
 		if ((endk - startk) < min_sizek)
 			continue;
-		strcpy (str_mmap, " memmap=");
+		if (new_memmap_syntax)
+			strcpy (str_mmap, ",");
+		else
+			strcpy (str_mmap, " memmap=");
 		ultoa((endk-startk), str_tmp);
 		strcat (str_mmap, str_tmp);
 		strcat (str_mmap, "K@");
@@ -1035,15 +1055,17 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	cmdline_add_efi(mod_cmdline);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
-	/* Inform second kernel about the presence of ACPI tables. */
-	for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
-		unsigned long start, end;
-		if ( !( mem_range[i].type == RANGE_ACPI
-			|| mem_range[i].type == RANGE_ACPI_NVS) )
-			continue;
-		start = mem_range[i].start;
-		end = mem_range[i].end;
-		cmdline_add_memmap_acpi(mod_cmdline, start, end);
+	if (!new_memmap_syntax) {
+		/* Inform second kernel about the presence of ACPI tables. */
+		for (i = 0; i < CRASH_MAX_MEMORY_RANGES; i++) {
+			unsigned long start, end;
+			if ( !( mem_range[i].type == RANGE_ACPI
+				|| mem_range[i].type == RANGE_ACPI_NVS) )
+				continue;
+			start = mem_range[i].start;
+			end = mem_range[i].end;
+			cmdline_add_memmap_acpi(mod_cmdline, start, end);
+		}
 	}
 	return 0;
 }
-- 
1.7.6.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
