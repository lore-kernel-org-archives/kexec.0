Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaHj0-00020L-S9
 for kexec@lists.infradead.org; Sun, 27 Oct 2013 04:13:15 +0000
Message-Id: <20131027041231.024036396@dhcp-16-126.nay.redhat.com>
Date: Sun, 27 Oct 2013 12:04:39 +0800
From: dyoung@redhat.com
Subject: [patch 2/4] remove extra acpi_rsdp command line for efi
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
Content-Disposition: inline; filename=02-kexec-remove-cmdline-add-efi.patch
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

Removing code to pass acpi_rsdp because this
patch series will support efi runtime, it's not
necessary any more. EFI initialization code will
take the functionality.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 include/x86/x86-linux.h           |    3 ++-
 kexec/arch/i386/crashdump-x86.c   |   35 -----------------------------------
 kexec/arch/i386/x86-linux-setup.c |    8 ++++++++
 3 files changed, 10 insertions(+), 36 deletions(-)

--- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
+++ kexec-tools/kexec/arch/i386/crashdump-x86.c
@@ -848,40 +848,6 @@ static int cmdline_add_memmap_acpi(char
 	return 0;
 }
 
-/* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
-static void cmdline_add_efi(char *cmdline)
-{
-	FILE *fp;
-	int cmdlen, len;
-	char line[MAX_LINE], *s;
-	const char *acpis = " acpi_rsdp=";
-
-	fp = fopen("/sys/firmware/efi/systab", "r");
-	if (!fp)
-		return;
-
-	while(fgets(line, sizeof(line), fp) != 0) {
-		/* ACPI20= always goes before ACPI= */
-		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
-		        line[strlen(line) - 1] = '\0';
-			s = strchr(line, '=');
-			s += 1;
-			len = strlen(s) + strlen(acpis);
-			cmdlen = strlen(cmdline) + len;
-			if (cmdlen > (COMMAND_LINE_SIZE - 1))
-				die("Command line overflow\n");
-			strcat(cmdline, acpis);
-			strcat(cmdline, s);
-			dbgprintf("Command line after adding efi\n");
-			dbgprintf("%s\n", cmdline);
-
-			break;
-		}
-	}
-
-	fclose(fp);
-}
-
 static void get_backup_area(struct kexec_info *info,
 				struct memory_range *range, int ranges)
 {
@@ -1046,7 +1012,6 @@ int load_crashdump_segments(struct kexec
 	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
 		return -1;
 	cmdline_add_memmap(mod_cmdline, memmap_p);
-	cmdline_add_efi(mod_cmdline);
 	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
 
 	/* Inform second kernel about the presence of ACPI tables. */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
