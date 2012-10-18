Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TOgeA-0003Hp-S1
 for kexec@lists.infradead.org; Thu, 18 Oct 2012 03:19:48 +0000
Date: Thu, 18 Oct 2012 11:16:08 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH v2] kdump: pass acpi_rsdp= to 2nd kernel for efi booting
Message-ID: <20121018031608.GA3925@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
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
To: horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com, khalid@gonehiking.org


In case efi booting, kdump need kernel parameter acpi_rsdp= to retrieve
the acpi root table physical address.

Add a function cmdline_add_efi to get the address from /sys/firmware/efi/systab
If there's no such file or read fail the function will just do nothing.

Tested efi boot Fedora 17 on thinkpad T420.

Some background info for this issue:
http://lists.infradead.org/pipermail/kexec/2010-March/003889.html

[v1 -> v2]:
Address comments from Khalid and Simon
use fgets instead of read(2) to iterate the file
do not add 'noefi' because kexec does not construct EFI signature
in bootloader signature in boot_params, so kexec'd kernel will
disable EFI automatically even without noefi.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/crashdump-x86.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -835,6 +835,40 @@ static int cmdline_add_memmap_acpi(char 
 	return 0;
 }
 
+/* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
+static void cmdline_add_efi(char *cmdline)
+{
+	FILE *fp;
+	int cmdlen, len;
+	char line[MAX_LINE], *s;
+	const char *acpis = " acpi_rsdp=";
+
+	fp = fopen("/sys/firmware/efi/systab", "r");
+	if (!fp)
+		return;
+
+	while(fgets(line, sizeof(line), fp) != 0) {
+		/* ACPI20= always goes before ACPI= */
+		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
+		        line[strlen(line) - 1] = '\0';
+			s = strchr(line, '=');
+			s += 1;
+			len = strlen(s) + strlen(acpis);
+			cmdlen = strlen(cmdline) + len;
+			if (cmdlen > (COMMAND_LINE_SIZE - 1))
+				die("Command line overflow\n");
+			strcat(cmdline, acpis);
+			strcat(cmdline, s);
+			dbgprintf("Command line after adding efi\n");
+			dbgprintf("%s\n", cmdline);
+
+			break;
+		}
+	}
+
+	fclose(fp);
+}
+
 static void get_backup_area(struct kexec_info *info,
 				struct memory_range *range, int ranges)
 {
@@ -998,6 +1032,7 @@ int load_crashdump_segments(struct kexec
 	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
 		return -1;
 	cmdline_add_memmap(mod_cmdline, memmap_p);
+	cmdline_add_efi(mod_cmdline);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
 	/* Inform second kernel about the presence of ACPI tables. */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
